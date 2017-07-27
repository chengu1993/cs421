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

    fun bug s = ErrorMsg.impossible("Cannot assign a color for " ^ s)

    fun color {interference, initial, registers} = 
      let 
        val Liveness.IGRAPH{graph, tnode, gtemp, moves} = interference
        (*max number of availalble registers can be assigned*)
        val maxDegree = length(registers)
        (*all temporaries in the graph*)
        val temporaries = G.nodes(graph)
        (*get degree and neighbors of a node*)
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
                    (*find a node with degree < number of available registers,
                      delete this node in graph and push it on a statck along with
                        its neighbors*)
                    if degree < maxDegree andalso optionNode = NONE then
                      (app (fn n => G.rm_edge{from=node, to=n}) neighbors;
                      app (fn n => G.rm_edge{from=n, to=node}) neighbors;
                      ((node, neighbors)::stack, G.Table.enter(set, node, ())))
                    else (*else* skip*)
                      (stack, set)
                  end
            val (stack', set') = helper(igraph, stack, temporaries, set);
          in 
            if(length(stack') < length(temporaries)) then
              simplify(igraph, stack', temporaries, set')
            else 
              (stack', set')
          end

        (*now we have all nodes deleted from the original graph sitting on a stack*)
        val (stack, set) = simplify(graph, [], G.nodes(graph), G.Table.empty)

        (*reconstruct the graph using the stack, in the meantime assign color to temp*)
        fun select (nil, allocation) = allocation
          | select ((node, neighbors)::rest, allocation) = 
              let
                (*translate a node to actual temporary*)
                val temp = valOf(G.Table.look(gtemp, node))
                (*find all neighbors which cannot share a same color*)
                val interferedTemps = map (fn n => valOf(G.Table.look(gtemp, n))) neighbors

                (*find all the colors neighbors have used, these colors cannot be assigned to the temp*)
                fun colorAlraedyUsed(nil, used) = used
                  | colorAlraedyUsed((interferedTemp::rest), used) = 
                      let 
                        val used = colorAlraedyUsed(rest, used)
                        val color =  valOf(T.Table.look(allocation, interferedTemp))
                      in color::used end

                val used = colorAlraedyUsed(interferedTemps, [])

                (*assign a color to a temp*)
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
                (*restore graph by adding back edges*)
                fun restoreGraph(neighbor) =
                  (G.mk_edge{from=node, to=neighbor};
                  G.mk_edge{from=neighbor, to=node})
              in
                (*restore graph*)
                app restoreGraph neighbors;
                (*if this temp has been already assigned a clor, like in the initail mapping, 
                  we skip it and follow its initial mapping. Otherwise, we put a new entry in allocation map*)
                case assigned of NONE =>
                  select(rest, T.Table.enter(allocation, temp, color))
                | _ =>
                  select(rest, allocation)
              end
      in select(stack, initial) end
end (* functor RegAllocGen *)
