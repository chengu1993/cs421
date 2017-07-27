signature MAIN = sig val compile : string -> unit end

structure Main : MAIN = struct

structure Semant = SemantGen(Register)
structure RegAlloc = RegAllocGen(Register)
structure C = Codegen
structure F = C.F
structure R = Register
structure A = Assem

fun emitproc out (F.DATA {lab, s}) = TextIO.output (out, C.string (lab, s))
  | emitproc out (F.PROC {name, body, frame}) =
    let 
        (*val _ = print ("Emit " ^ Symbol.name(name) ^ "\n")
        val _ = Printtree.printtree(out, body)*)
        val stms = Canon.linearize body
        val stms' = Canon.traceSchedule (Canon.basicBlocks stms)

        val instrs = List.concat(map C.codegen stms')

        val (fgraph, fodes) = MakeGraph.instrs2graph instrs


        val (igraph, livenessMap) = Liveness.interferenceGraph fgraph
        

        val initial = foldr (fn ((temp, reg), tab) => Temp.Table.enter (tab, temp, reg))
                          Temp.Table.empty R.specialregs

        val allocation = RegAlloc.color
              {interference = igraph,
              initial = initial,
              registers = R.registers}

        val assembly = C.procEntryExit
              {name = name, 
              body = map (fn instr => (instr, nil)) instrs,
              allocation = allocation, 
              formals = nil, 
              frame = frame}

        val format = A.format (fn t => (valOf(Temp.Table.look(allocation, t))))
     in 
      app (fn i => TextIO.output (out, format i)) assembly
    end

fun withOpenFile fname f =
    let val out = TextIO.openOut fname
     in f out before TextIO.closeOut out
              handle e => (TextIO.closeOut out; raise e)
    end

fun compile file =
    let val frags = Semant.transprog (Parse.parse file)
     in if !(ErrorMsg.anyErrors) then ()
        else withOpenFile (file ^ ".s") (fn out => (app (emitproc out) frags));
        ErrorMsg.reset()
    end

end (* structure Main *)
