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

  (* To construct the interference graph, it is convenient to
     construct a liveness map at each node in the FlowGraph first.
     For each node in the flowgraph, i.e., for each assembly 
     instruction, we want to easily look up the set S of live 
     temporaries. 
   *)

  structure F = Flow
  structure G = Graph
  structure T = Temp

  fun bug s = ErrorMsg.impossible("Node: " ^ s ^ " does not exist")

  (* Utility functions to get union and difference of two list*)
  fun member (x, nil) = false
    | member (x, h::t) = 
        if x = h then true
        else member(x, t)

  fun union (nil, y) = y
    | union (h::t, y) = 
        if(member(h, y)) then union(t, y)
        else (h::union(t, y))
  
  fun difference(nil, y) = nil
    | difference(h::t, y) = 
        if(member(h, y)) then difference(t, y)
        else (h::difference(t, y))


  type liveSet = unit Temp.Table.table * Temp.temp list
  type livenessMap = liveSet Flow.Graph.Table.table

  val liveInMap = Flow.Graph.Table.empty
  val liveOutMap = Flow.Graph.Table.empty



  fun interferenceGraph (Flow.FGRAPH{control, def, use, ismove}) = 
    let

      val nodes = Graph.nodes(control)

      fun initialize nil = (G.Table.empty, G.Table.empty)
        | initialize (a::r) =
            let 
              val (lim, lom) = initialize r
            in 
              (G.Table.enter(lim, a, (T.Table.empty, [])),
              G.Table.enter(lom, a, (T.Table.empty, [])))
            end 
      

      val (lim, lom) = initialize nodes 
      
      fun liveness (lim, lom) = 
        let
          val lim' = lim
          val lom' = lom

          (*has bug here*)
          fun compare (map1, map2, nil) = true
            | compare (map1, map2, node::rest) = 
            let
              val (set1, list1) = valOf(G.Table.look(map1, node))
              val (set2, list2) = valOf(G.Table.look(map2, node))

              fun contains (nil, set) = true
                | contains (node::rest, set) = 
                    if T.Table.look(set, node) = NONE then false
                    else contains(rest, set)

              val eq = contains(list1, set2) andalso contains(list2, set1)
            in
              if eq then compare(map1, map2, rest)
              else false 
            end 

          fun updateInOutMap (lim, lom, nil) = (lim, lom)
            | updateInOutMap (lim, lom, node::rest) = 
                let 
                  fun printList nil = ()
                    | printList (head::tail) = (
                        print(Int.toString(head) ^ " ");
                        printList(tail))

                  (*Using Temp.temp list to make unit Temp.Table*) 
                  fun makeTable nil = T.Table.empty
                    | makeTable (t::r) =
                        let val table = makeTable(r)
                        in T.Table.enter(table, t, ()) end
                  (*Update live-out map for all succs of node n*)
                  fun updateOutMap (lim, nil) = []
                    | updateOutMap (lim, succ::rest) = 
                        let
                          val liveOut = updateOutMap(lim, rest)
                          val (t, liveIn) = valOf(G.Table.look(lim, succ))
                        in union(liveIn, liveOut) end
                  (*Update live-in*)
                  val u = valOf(G.Table.look(use, node))
                  val (t, liveOut) = valOf(G.Table.look(lom, node))
                  val d = valOf(G.Table.look(def, node))
                  val liveInList = union(u, difference(liveOut, d))
                  val liveInTable = makeTable liveInList
                  val lim' = G.Table.enter(lim, node, (liveInTable, 
                                liveInList))
                  (*Update live-out*)
                  val succs = G.succ(node)
                  val liveOutList = updateOutMap (lim, succs)
                  val liveOutTable = makeTable (liveOutList)
                  val lom' = G.Table.enter(lom, node, (liveOutTable,
                                liveOutList))
                in
                  (*print("Union result:");
                  printList liveInList;
                  print("\n");*)
                  updateInOutMap(lim', lom', rest) 
                end
          

          val (lim, lom) = updateInOutMap(lim, lom, nodes)

          (* for debug use, test liveOutMap*)
          fun printLiveOut (nil, map) = ()
          | printLiveOut (node::rest, map) =
            let 
              val (t, l) = valOf(G.Table.look(map, node))

              fun printList nil = ()
                | printList (node::rest) = (print(Int.toString(node) ^  " "); printList(rest))

            in
              print(G.nodename node ^ "\n");
              printList(l);
              print("\n");
              printLiveOut(rest, map)
            end




        in
          (*print("liveOut-----------\n");
          printLiveOut(nodes, lom);
          print("liveIn-----------\n");
          printLiveOut(nodes, lim);*)
          if(compare(lim, lim', nodes) andalso compare(lom, lom', nodes)) then lom
          else liveness(lim, lom) 
        end

      val liveOutMap = liveness(lim, lom)




      (* after constructing the livenessMap, it is quite easy to
         construct the interference graph, just scan each node in
         the Flow Graph, add interference edges properly ... 
       *)
      val graph = G.newGraph()    

      fun interference nil = (T.Table.empty, G.Table.empty, []) 

        | interference (node::rest) = 
            let

              val (tnode, gtemp, moves) = interference(rest)
              val move = valOf(G.Table.look(ismove, node))
              val d = valOf(G.Table.look(def, node))
              val u = valOf(G.Table.look(use, node))
              val (_, liveOut) = valOf(G.Table.look(liveOutMap, node))


              fun insertNode (tnode, gtemp, nil) = (tnode, gtemp)
                | insertNode (tnode, gtemp, h::t) = 
                    let 
                      val optionNode = T.Table.look(tnode, h)

                      fun helper optionNode = 
                          case optionNode of NONE => 
                            let val n = G.newNode(graph)
                            in (T.Table.enter(tnode, h, n),
                                G.Table.enter(gtemp, n, h))
                            end
                          | _ => (tnode, gtemp)

                      val (tnode', gtemp') = helper optionNode
                    in
                      insertNode(tnode', gtemp', t)
                    end


              fun connect (definitions, uses, liveOut) = 
                let 
                  val (tnode, gtemp) = insertNode(tnode, gtemp, definitions)
                  val (tnode, gtemp) = insertNode(tnode, gtemp, uses)
                  val (tnode, gtemp) = insertNode(tnode, gtemp, liveOut)


                  fun helper(nil, liveOut) = ()
                    | helper(h::t, liveOut) = (*app (fn x => G.mk_edge{from=h, to=x}) liveOutNode *)
                        let
                          fun edge (head, nil) = ()
                            | edge (head, h::t) = 
                                let 
                                  val from = valOf(T.Table.look(tnode, head))
                                  val to = valOf(T.Table.look(tnode, h))
                                  val from_adjs = G.adj(from)
                                  val to_adjs = G.adj(to)

                                  
                                  fun isConnected (n, nil) = false
                                    | isConnected (n, adj::rest) = 
                                        if(G.eq(n, adj)) then true
                                        else isConnected(n, rest)

                                  fun printAdj nil = ()
                                    | printAdj (adj::rst) = 
                                        ( 
                                          print(G.nodename(adj) ^ " ");
                                          printAdj(rst))


                                  fun handleNormal () = 
                                    if ((G.eq(from, to)) orelse 
                                      (isConnected(from, to_adjs)))  
                                    then ()
                                    else 
                                      (G.mk_edge{from=from, to=to};
                                      G.mk_edge{from=to, to=from});

                                  fun handleMove () = 
                                    let 
                                      (*caution, might have bug here*)
                                      val moveUse = valOf(T.Table.look(tnode, hd(u)))
                                    in 
                                      if ((G.eq(from, to)) orelse 
                                        (isConnected(from, to_adjs)) orelse
                                        ((move = true) andalso (G.eq(to, moveUse))))  
                                      then ()
                                      else 
                                        (G.mk_edge{from=from, to=to};
                                        G.mk_edge{from=to, to=from})
                                    end
                                in 

                                  (*print("from is " ^ G.nodename(from) ^ "\n");
                                  print("to is " ^ G.nodename(to) ^ "\n");
                                  print("adjs is \n");
                                  printAdj(from_adjs);
                                  print("\n");*)

                                  case move of false =>
                                    handleNormal ()
                                  | true =>
                                    handleMove ();
                                  (*G.mk_edge{from=from, to=to};*)
                                  edge(head, t)
                                end
                        in 
                          edge(h, liveOut);
                          helper(t, liveOut)
                        end

                in (helper(definitions, liveOut);(tnode, gtemp)) end

              val (tnode, gtemp) = connect(d, u, liveOut)

            in
              case move of false => (tnode, gtemp, moves)
                | true => 
                  let 
                    val moveSrc = valOf(T.Table.look(tnode, hd(u)))
                    val moveDst = valOf(T.Table.look(tnode, hd(d)))
                  in (tnode, gtemp, ((moveSrc, moveDst)::moves)) end
            end


      val (tnode, gtemp, moves) = interference nodes
      val outs = TextIO.openOut "igraph.dot"
      val igraph = IGRAPH{graph=graph, tnode=tnode, gtemp=gtemp, moves=moves}

    in 
      
      (igraph,
        fn n => case G.Table.look(liveOutMap, n)
                  of SOME((t, l)) => l
                  | NONE => bug(G.nodename(n))) 

    end

  fun show (out, igraph as IGRAPH{graph, tnode, gtemp, moves}) = 
    let 

      fun node2temp node = 
        let val temp = valOf(G.Table.look(gtemp, node))
        in Int.toString(temp) end

      fun label node = node2temp node
    in DotGraph.dot(out, graph, label) end



end (* structure Liveness *)

     

                 
