(* regalloc.sml *)

signature REG_ALLOC =
sig
   structure R : REGISTER_STD
   
   type allocation = Register.register Temp.Table.table

   val color : {interference : Liveness.igraph,
                initial : allocation,
                registers : R.register list} -> allocation

end (* signature REG_ALLOC *)


functor RegAllocGen(Register : REGISTER_STD) : REG_ALLOC =
struct
    structure R : REGISTER_STD = Register
    structure G = Graph
    structure T = Temp

    type allocation = R.register Temp.Table.table

    type selectNode = G.node * G.node list

    type tempSet = unit T.Table.table




    (* The color function talkes an initial allocation table (which assigns
      temporary variables such as FP or SP into certain fixed registers)
      plus an interference graph and a list of registers, and returns
      a new allocation table (mapping from temporaries to registers).

      Notice, you don't need to implement spilling and coalescing. 
      Just do the "simplify" and then do the "select".
    *)

    fun color {interference, initial, registers} = 
      let 
        val Liveness.IGRAPH{graph, tnode, gtemp, moves} = interference
        val maxDegree = length(registers)
        val temporaries = G.nodes(graph)

        (*get degree and adj of a node*)
        fun degreeAndNeighbors (node) = 
          let 
            val neighbors = G.adj(node)
            val set = G.Table.empty

            fun removeDuplicate (set, nil) = (set, nil)
              | removeDuplicate (set, neighbor::rest) = 
                  let
                    val (set', neighbors) = removeDuplicate(set, rest)
                    val exist = G.Table.look(set', neighbor)
                  in 
                    case exist of NONE =>
                      (G.Table.enter(set', node, neighbor),
                        neighbor::neighbors)
                    | _ =>
                      (set, neighbors) 
                  end

              val (_, neighbors') = removeDuplicate(set, neighbors)

          in 
            ((length(neighbors) div 2),
            neighbors')
          end



        (*since we can guarantee we have enough number of registers,
          we conntinue select process until the graph is empty*)
        fun select (igraph, stack, temporaries) = 
          let

            
            fun helper (igraph, stack, nil) = stack
              | helper (igraph, stack, node::rest) = 
                  let 



                    val (degree, neighbors) = degreeAndNeighbors(node)
                    val _ = print ("node:" ^ G.nodename(node) ^ "\n")
                    fun printNeighbors nil = 
                          print("\n")
                      | printNeighbors (neighbor::rest) = 
                          (print(G.nodename(neighbor) ^ " ");
                            printNeighbors(rest))

                    val _ = printNeighbors(neighbors)
                  

                  in 
                    if degree < maxDegree then
                      stack

                    else 
                      stack
                  end

            val stack' = helper(igraph, stack, temporaries);
          in 

            if(length(stack') < length(temporaries)) then
              select(igraph, stack', temporaries)
            else 
              stack'
          end


      in
        select(graph, [], G.nodes(graph)); 
        initial 
      end


end (* functor RegAllocGen *)
