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
    let val stms = Canon.linearize body
        val stms' = Canon.traceSchedule (Canon.basicBlocks stms)
        val basicBlocks = (map C.codegen stms')
        val instrs = List.concat(basicBlocks)
        val (flowGraph, graphNodes) = MakeGraph.instrs2graph instrs
        val (igraph, nodeToTempList) = Liveness.interferenceGraph flowGraph
        val regs = List.concat [R.calleesaves, R.truecallersaves, R.callersaves]
        val initMapping =
          foldr (fn ((temp, reg), tab) => Temp.Table.enter (tab, temp, reg))
            Temp.Table.empty R.specialregs
        val registerAllocations = RegAlloc.color
          {interference = igraph, initial = initMapping, registers = regs}
        fun instrWithTemps instr = case instr
          of A.OPER {dst, src,...} => (instr, dst @ src)
           | A.LABEL _ => (instr, nil)
           | A.MOVE {dst, src,...} => (instr, [dst, src])
        val newInstrs = C.procEntryExit
          {name = name, body = map instrWithTemps instrs,
           allocation = registerAllocations, formals = nil, frame = frame}
        val format = A.format (fn t => "t" ^ Temp.makestring t)
     in app (fn i => TextIO.output (out, format i)) newInstrs
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
