(* liveness.sml *)

signature LIVENESS =
sig

  datatype igraph = 
      IGRAPH of {graph : Graph.graph,
                 tnode : Graph.node Temp.Table.table,
                 gtemp : Temp.temp Graph.Table.table,
                 moves : (Graph.node * Graph.node) list}

  
     (*val interferenceGraph : 
           Flow.flowgraph -> igraph * (Flow.Graph.node -> Temp.temp list)
           
     val show : outstream * igraph -> unit
     *)
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

  type liveSet = unit Temp.Table.table * Temp.temp list
  type livenessMap = liveSet Flow.Graph.Table.table

  fun construct_livenessMap () = ()

  (* after constructing the livenessMap, it is quite easy to
     construct the interference graph, just scan each node in
     the Flow Graph, add interference edges properly ... 
   *)

  (*fun interferenceGraph fgraph = igraph{graph=fgraph, tnode=tnode,
    gtemp=gtemp,moves=moves}
    *)
  fun show (out, ifgraph) = ()




end (* structure Liveness *)

     

                 
