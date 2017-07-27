(* liveness.sml *)

signature LIVENESS =
sig

  datatype igraph = 
      IGRAPH of {graph : Graph.graph,
                 tnode : Graph.node Temp.Table.table,
                 gtemp : Temp.temp Graph.Table.table,
                 moves : (Graph.node * Graph.node) list}
  
  val interferenceGraph : 
           Flow.flowgraph -> igraph * (Flow.Graph.node -> Temp.temp list)
           
  val show : TextIO.outstream * igraph -> unit
     
end (* signature LIVENESS *)

structure Liveness : LIVENESS = 
struct

  datatype igraph = 
      IGRAPH of {graph : Graph.graph,
                 tnode : Graph.node Temp.Table.table,
                 gtemp : Temp.temp Graph.Table.table,
                 moves : (Graph.node * Graph.node) list}

  structure F = Flow
  structure G = Graph
  structure T = Temp

  fun bug s = ErrorMsg.impossible("Node: " ^ s ^ " does not exist")

  (* Utility functions*)
  (* Test whether x is a member of list, used in difference and union*)
  fun member (x, nil) = false
    | member (x, h::t) = 
        if x = h then true
        else member(x, t)
  (* Union of two sets*)
  fun union (nil, y) = y
    | union (h::t, y) = 
        if(member(h, y)) then union(t, y)
        else (h::union(t, y))
  (* Difference of two sets*)
  fun difference(nil, y) = nil
    | difference(h::t, y) = 
        if(member(h, y)) then difference(t, y)
        else (h::difference(t, y))

  type liveSet = unit Temp.Table.table * Temp.temp list
  type livenessMap = liveSet Flow.Graph.Table.table

  (* after constructing the livenessMap, 
  then construct the infererfence graph*)
  fun interferenceGraph (Flow.FGRAPH{control, def, use, ismove}) = 
    let
      val nodes = Graph.nodes(control)

      (*initialize livein and liveout set for every instruction*)
      fun initializeMap (node, (lim, lom)) =
            (G.Table.enter(lim, node, (T.Table.empty, [])),
             G.Table.enter(lom, node, (T.Table.empty, [])))

      (*lim: liveIn Map
       *lom: liveOut Map*)
      val (lim, lom) = foldl initializeMap (G.Table.empty, G.Table.empty) nodes
      
      (*Iteratively update lim and lom until a fixed point is found*)
      fun liveness (lim, lom) = 
        let
          (*assign last lim and lom to temporaries*)
          val lim' = lim
          val lom' = lom
          (*compare if two set are equal, if yes, the iteration for calculating liveness terminates*)
          fun compare (map1, map2, nil) = true
            | compare (map1, map2, node::rest) = 
            let
              val (set1, list1) = valOf(G.Table.look(map1, node))
              val (set2, list2) = valOf(G.Table.look(map2, node))

              fun contains (nil, set) = true
                | contains (node::rest, set) = 
                    case T.Table.look(set, node) of NONE => false
                    | _ => contains(rest, set)
              (*if both two set contains the other, then then are equal*)
              val eq = contains(list1, set2) andalso contains(list2, set1)
            in
              if eq then compare(map1, map2, rest)
              else false 
            end 
          (*update lim and lom each round
            1.If a variable is in use[n], then it is live-in at node n. That is, if a statement uses 
                a variable, the variable is live on entry to that statement.
            2.If a variable is live-in at a node n, then it is live-out at all nodes m in pred[n].
            3.If a variable is live-out at node n, and not in def[n], then the variable is also live-in 
                at n. That is, if someone needs the value of a at the end of statement n, and n does 
                not provide that value, then a’s value is needed even on entry to n.*)
          fun updateInOutMap (node, (lim, lom)) = 
                let   
                  (*Update live-in*)
                  val u = valOf(G.Table.look(use, node))
                  val (t, liveOut) = valOf(G.Table.look(lom, node))
                  val d = valOf(G.Table.look(def, node))
                  val liveInList = union(u, difference(liveOut, d))
                  val liveInTable = foldl (fn (temp, set) => T.Table.enter(set, temp, ())) T.Table.empty liveInList
                  val lim' = G.Table.enter(lim, node, (liveInTable, 
                                liveInList))
                  (*Update live-out*)
                  (*Update live-out map for all succs of node n*)
                  fun updateOutMap (succ, liveOut) = 
                        let val (_, liveIn) = valOf(G.Table.look(lim', succ))
                        in union(liveIn, liveOut) end 
                  val succs = G.succ(node)
                  val liveOutList = foldr updateOutMap [] succs
                  val liveOutTable = foldl (fn (temp, set) => T.Table.enter(set, temp, ())) T.Table.empty liveOutList
                  val lom' = G.Table.enter(lom, node, (liveOutTable,
                                liveOutList))
                in (lim', lom') end
          (*here I use foldr to start from the last node in the nodes in order to reduce computation time*)
          val (lim, lom) = foldr updateInOutMap (lim, lom) nodes
        in
          (*if newly updated lim and lom is the same as the old one, a fixed point is find, algorithm
            terminates. Otherwise, start another round*)
          if(compare(lim, lim', nodes) andalso compare(lom, lom', nodes)) then lom
          else liveness(lim, lom) 
        end

      (*The final liveoutMap from the calculation, is used to construct interference graph*)
      val liveOutMap = liveness(lim, lom)

      (*initialize graph*)
      val graph = G.newGraph()    
      (*initialize nodes mapped to temporaries in interference graph*)
      fun initializeNode (node, (tnode, gtemp, moves)) = 
            let
              val move = valOf(G.Table.look(ismove, node))
              val d = valOf(G.Table.look(def, node))
              val u = valOf(G.Table.look(use, node))
              (*update tnode and gtemp*)
              fun addTemptoMap (temp, (tnode, gtemp)) = 
                    case T.Table.look(tnode, temp) of NONE =>
                      let val node = G.newNode(graph)
                      in (T.Table.enter(tnode, temp, node),
                          G.Table.enter(gtemp, node, temp))
                      end
                    | _ => (tnode, gtemp)
              (*update moves*)
              fun updateMoves moves = 
                    case move of false => moves
                    | true => 
                      let 
                        val moveSrc = valOf(T.Table.look(tnode, hd(u)))
                        val moveDst = valOf(T.Table.look(tnode, hd(d)))
                      in ((moveSrc, moveDst)::moves) end

              val (tnode, gtemp) = foldr addTemptoMap (tnode, gtemp) d
              val (tnode, gtemp) = foldr addTemptoMap (tnode, gtemp) u
              val moves = updateMoves moves
            in (tnode, gtemp, moves) end

      val (tnode, gtemp, moves) = foldr initializeNode (T.Table.empty, G.Table.empty, []) nodes
      (*add edges in interference graph*)
      fun makeEdges (node) = 
            let
              val move = valOf(G.Table.look(ismove, node))
              val d = valOf(G.Table.look(def, node))
              val u = valOf(G.Table.look(use, node))
              val (_, liveOut) = valOf(G.Table.look(liveOutMap, node))
              (*from one definition*)
              fun makeEdge (definition) = 
                    let 
                      (*to one liveout *)
                      fun helper (liveOutTemp) = 
                         let 
                            val from = valOf(T.Table.look(tnode, definition))
                            val to = valOf(T.Table.look(tnode, liveOutTemp))
                            val to_adjs = G.adj(to)
                            (*test if an edge already exists*)
                            fun isConnected (n, nil) = false
                              | isConnected (n, adj::rest) = 
                                  if(G.eq(n, adj)) then true
                                  else isConnected(n, rest)
                          in 
                            (*if from == equal, skip
                            if edge already exist, skip
                            if ismove and to == use, skip*)
                            if (G.eq(from, to) orelse 
                               isConnected(from, to_adjs) orelse
                               (move andalso G.eq(to, valOf(T.Table.look(tnode, hd(u)))))) 
                            then ()
                            else 
                              (*here I make two edges, since interference is an undirected graph,
                              though add one edge is sufficient. To be more consistent, I add two 
                              edges here*)
                              (G.mk_edge{from=from, to=to};
                              G.mk_edge{from=to, to=from})
                          end
                    in app helper liveOut end
            in app makeEdge d end
    in 
      app makeEdges nodes;
      (IGRAPH{graph=graph, tnode=tnode, gtemp=gtemp, moves=moves},
       fn n => case G.Table.look(liveOutMap, n)
                  of SOME((t, l)) => l
                  | NONE => bug(G.nodename(n))) 

    end

  (*Use dot to generate the interfernce graph, for debug use only*)
  fun show (out, igraph as IGRAPH{graph, tnode, gtemp, moves}) = 
    let
      fun node2temp node = 
        let val temp = valOf(G.Table.look(gtemp, node))
        in Int.toString(temp) end
      fun label node = node2temp node
    in DotGraph.dot(out, graph, label) end

end (* structure Liveness *)

     

                 
