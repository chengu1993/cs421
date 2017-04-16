
(* makegraph.sml *)

signature MAKEGRAPH =
sig
  val fake_input: unit -> Assem.instr list

  val instrs2graph : Assem.instr list -> Flow.flowgraph * Flow.Graph.node list


end

structure MakeGraph : MAKEGRAPH =
struct

  structure G = Graph
  structure A = Assem


  fun fake_input () =
    let val instr1 = A.OPER{assem="assign", dst=[1], src=[], jump=NONE}
        val instr2 = A.LABEL{assem="hello", lab=Symbol.symbol("hello")}
        val instr3 = A.OPER{assem="add", dst=[2], src=[1], jump=NONE}
        val instr4 = A.OPER{assem="add", dst=[3], src=[2,3], jump=NONE}
        val instr5 = A.OPER{assem="mul", dst=[1], src=[2], jump=NONE}
        val instr6 = A.OPER{assem="jump", dst=[], src=[1], 
                            jump=SOME([Symbol.symbol("hello")])}
        val instr7 = A.OPER{assem="return", dst=[], src=[3], jump=NONE}
   

    in (instr1::(instr2::(instr3::(instr4::(instr5::(instr6::[instr7])))))) end


  fun bug s = ErrorMsg.impossible("Label: " ^ s ^ " does not exist")

  fun instrs2graph instrs =
    let
      val graph = G.newGraph()


      (*
      * generate nodes for each instructions
      * im: instructions map
      * dm: def map
      * um: use map
      * mm: move map
      *)
      fun instrs2nodes nil = ({
                im = G.Table.empty,
                dm = G.Table.empty,
                um = G.Table.empty,
                mm = G.Table.empty}, nil)

        | instrs2nodes (a::r) =
            let 
              val n = G.newNode(graph)
              val ({im, dm, um, mm}, t) = instrs2nodes r
            in (
                (case a of
                  A.OPER{assem, dst, src, jump} =>
                     {im = G.Table.enter(im, n, a),
                     dm = G.Table.enter(dm, n, dst),
                     um = G.Table.enter(um, n, src),
                     mm = G.Table.enter(mm, n, false)}
                  | A.LABEL{assem, lab} =>
                     {im = G.Table.enter(im, n, a),
                     dm = G.Table.enter(dm, n, nil),
                     um = G.Table.enter(um, n, nil),
                     mm = G.Table.enter(mm, n, false)}
                  | A.MOVE{assem, dst, src} =>
                     {im = G.Table.enter(im, n, a),
                     dm = G.Table.enter(dm, n, [dst]),
                     um = G.Table.enter(um, n, [src]),
                     mm = G.Table.enter(mm, n, true)}
                )
                , n::t)
            end

      val ({im, dm, um, mm}, nodes) = instrs2nodes instrs
      

      (*
      * translate label to its corresponding node
      *)
      fun label2node (im, label, nil) =
        (bug(Symbol.name label); NONE)
        | label2node (im, label, a::r) =
            let val instr =G.Table.look(im, a)
              in case instr of
                SOME(A.LABEL{assem, lab}) =>
                    (if (lab = label) then SOME(a)
                     else label2node(im, label, r))
              | _ => label2node(im, label, r)
            end
            

      (*
      * connect nodes (jump labels or falling through)
      *)
      fun connect (im, a::(b::r)) =
        let
          val instr = G.Table.look(im, a)
          (*connect nodes through jump labels*)
          fun connect_jump (from, nil) = ()
            | connect_jump (from, label::r) =
                let val option_to = label2node(im, label, nodes)
                in case option_to of SOME(to) =>
                     G.mk_edge {from=from, to=to}
                   | _ => ();
                   connect_jump(from, r)
                end
        in
          case instr of
            SOME(A.OPER{assem, dst, src, jump}) => (
                case jump of SOME(labels) => connect_jump(a, labels)
                | _ => ())
          | _ => ();
          G.mk_edge {from=a, to=b}; (*connect nodes falling through*)
          connect(im, b::r)
        end
        | connect (_, _) = ()
      

      val _ = connect(im, nodes)
      val fgraph = Flow.FGRAPH{control=graph, def=dm, use=um, ismove=mm}
      val outs = TextIO.openOut "graph.dot"
      
      fun printDefUse (nil, map) = ()
        | printDefUse (node::rest, map) = 
            let 
              val l = valOf(G.Table.look(map, node))
              fun printList nil = ()
                | printList (node::rest) = 
                    (print(Int.toString(node) ^ " ");
                    printList(rest))
            in 
              print ("-----------\n");
              print(G.nodename(node) ^ "\n");
              printList(l);
              print ("\n-----------\n");
              printDefUse (rest, map)
            end
               



    in (
        Flow.dot(outs, fgraph);
        (*print ("def map \n");
        printDefUse(nodes, dm);
        print ("use map \n");
        printDefUse(nodes, um);*)
        (fgraph, nodes)) end

(* The "instrs2graph" function takes a list of assembly instructions,
   and constructs its flowgraph and also returns the list of nodes in
   the flowgraph. The instructions exactly correspond to the nodes in
   the graph. If instruction m can be followed by instruction n (either
   by a jump or by falling through), there should be an edge from m to n
   in the graph.

   The flowgraph also maintains several attributes for each node in the
   graph, i.e., the "def" set, the "use" set, and the "ismove" flag

 *)


end
