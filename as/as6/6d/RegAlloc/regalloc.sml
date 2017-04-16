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

    type tempSet = unit G.Table.table

    fun bug s = ErrorMsg.impossible("Cannot assign a color for " ^ s)


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

        (*val _ = print("registers num:" ^ Int.toString(maxDegree) ^ "\n")*)

        (*get degree and adj of a node*)
        fun degreeAndNeighbors (node) = 
          let val neighbors = G.pred(node)
          in (length(neighbors), neighbors) end

        (*since we can guarantee we have enough number of registers,
          we conntinue select process until the graph is empty*)

        fun simplify (igraph, stack, temporaries, set) = 
          let
            fun helper (igraph, stack, nil, set) = (stack, set)
              | helper (igraph, stack, node::rest, set) = 
                  let 
                    val (stack, set) = helper(igraph, stack, rest, set)
                    val (degree, neighbors) = degreeAndNeighbors(node)
                    val optionNode = G.Table.look(set, node)
                  in 
                    if degree < maxDegree andalso optionNode = NONE then
                      (*deleteEdges(node, neighbors);*)
                      (app (fn n => G.rm_edge{from=node, to=n}) neighbors;
                      app (fn n => G.rm_edge{from=n, to=node}) neighbors;
                      ((node, neighbors)::stack, G.Table.enter(set, node, ())))
                    else 
                      (stack, set)
                  end
            val (stack', set') = helper(igraph, stack, temporaries, set);
          in 
            if(length(stack') < length(temporaries)) then
              simplify(igraph, stack', temporaries, set')
            else 
              (stack', set')
          end

        val (stack, set) = simplify(graph, [], G.nodes(graph), G.Table.empty)

        fun printOutStack nil = ()
          | printOutStack ((node,neighbors)::rest) = 
              (print("Node:" ^ G.nodename(node) ^ "\n");
                app (fn n => print(G.nodename(n) ^ " ")) neighbors;
                print("\n");
                printOutStack(rest))

        val _ = printOutStack stack

        fun select (nil, allocation) = allocation
          | select ((node, neighbors)::rest, allocation) = 
              let

                val temp = valOf(G.Table.look(gtemp, node))
                val interferedTemps = map (fn n => valOf(G.Table.look(gtemp, n))) neighbors
                val _ = print("Intefered temps:")
                val _ = app (fn n => print(Int.toString(n) ^ " ")) interferedTemps
                val _ = print("\n")

                fun colorAlraedyUsed(nil, used) = used
                  | colorAlraedyUsed((interferedTemp::rest), used) = 
                      let 
                        val used = colorAlraedyUsed(rest, used)
                        val color =  valOf(T.Table.look(allocation, interferedTemp))
                      in color::used end

                val used = colorAlraedyUsed(interferedTemps, [])

                val _ = print("Used colors:")
                val _ = app (fn n => print(n ^ " ")) used
                val _ = print("\n")

                fun getFirstColorUnused(nil) = bug(G.nodename(node))
                  | getFirstColorUnused(color::rest) =
                      let 
                        fun isUsed(color, nil) = false
                          | isUsed(color, colorHead::colorTail) = 
                              if color = colorHead then true
                              else isUsed(color, colorTail)
                      in
                        if isUsed(color, used) then getFirstColorUnused(rest)
                        else color
                      end



                val color = getFirstColorUnused(registers)
                val assigned = T.Table.look(allocation, temp)
                (*val allocation = T.Table.enter(allocation, temp, color)*)

              in
                case assigned of NONE =>
                  select(rest, T.Table.enter(allocation, temp, color))
                | _ =>
                  select(rest, allocation)
              end

        val allocation = select(stack, initial)

        fun printOutAllocation (nil) = print("\n")
          | printOutAllocation (node::rest) = 
              let 
                val temp = valOf(G.Table.look(gtemp, node))
                val _ = print("Temp " ^ Int.toString(temp) ^ " assigned to ")
                val regsiter = valOf(T.Table.look(allocation, temp))
                val _ = print(regsiter ^ "\n")
              in printOutAllocation(rest) end

        val _ = printOutAllocation(G.nodes(graph))
      in
        allocation
        (*select(stack, initial)*)
      end


end (* functor RegAllocGen *)
