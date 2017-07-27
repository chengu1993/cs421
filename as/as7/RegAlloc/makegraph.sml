
(* makegraph.sml *)

signature MAKEGRAPH =
sig
  val instrs2graph : Assem.instr list -> Flow.flowgraph * Flow.Graph.node list
end

structure MakeGraph : MAKEGRAPH =
struct

  structure G = Graph
  structure A = Assem
  structure S = Symbol
  structure F = Flow

  fun bug s = ErrorMsg.impossible("Label: " ^ s ^ " does not exist")

  (*take block of instructions and generate control flow graph*)
  fun instrs2graph instrs =
    let
      val graph = G.newGraph()

      (*
      * generate nodes for each instructions
      * im: instructions map
      * dm: def map (node -> definittions)
      * um: use map (node -> uses)
      * mm: move map (node -> ismoves)
      * lm: label map (label -> node)
      *)
      fun initialize (instr, {im, dm, um, mm, lm, nodes}) = 
        let
          (*create a new node for each instruction*)
          val node = G.newNode(graph)
        in
          case instr of
            A.OPER{assem, dst, src, jump} =>
               {im = G.Table.enter(im, node, instr),
               dm = G.Table.enter(dm, node, dst),
               um = G.Table.enter(um, node, src),
               mm = G.Table.enter(mm, node, false),
               lm = lm,
               nodes = node::nodes}
            | A.LABEL{assem, lab} =>
               {im = G.Table.enter(im, node, instr),
               dm = G.Table.enter(dm, node, nil),
               um = G.Table.enter(um, node, nil),
               mm = G.Table.enter(mm, node, false),
               lm = S.enter(lm, lab, node),
               nodes = node::nodes}
            | A.MOVE{assem, dst, src} =>
               {im = G.Table.enter(im, node, instr),
               dm = G.Table.enter(dm, node, [dst]),
               um = G.Table.enter(um, node, [src]),
               mm = G.Table.enter(mm, node, true),
               lm = lm,
               nodes = node::nodes}
        end

      (*initialize all kinds of map and nodes in graph*)
      val {im, dm, um, mm, lm, nodes} = foldr initialize 
                {im=G.Table.empty, dm=G.Table.empty,
                 um=G.Table.empty, mm=G.Table.empty,
                 lm=S.empty, nodes=[]} instrs
      

      (*translate label to its corresponding node*)
      fun label2node (label) = 
        case S.look(lm, label) of NONE =>
          bug(S.name label) (*cannot find node, rasie excpetion here*)
        | SOME(node) => node
      
      (*connect nodes either by falling through or by jump labels*)
      fun connect (nodes) =
        let    
          (*handle falling through*)
          fun fallingThrough (from::(to::rest)) = 
                (G.mk_edge{from=from, to=to};
                 fallingThrough(to::rest))
            | fallingThrough(_) = ()
          (*handle jump labels*)
          fun jumpLabels (from) = 
            let val instr = valOf(G.Table.look(im, from))
            in case instr of A.OPER{assem, dst, src, jump as SOME(labels)} =>
                  app (fn label => G.mk_edge{from=from, to=label2node(label)}) labels 
                | _ => ()
            end
        in 
          fallingThrough(nodes);
          app jumpLabels nodes
        end
    in 
      connect(nodes);
      (F.FGRAPH{control=graph, def=dm, use=um, ismove=mm}, nodes) 
    end
end
