(* codegen.sml *)

signature CODEGEN =
sig
  structure F : FRAME
  structure R : REGISTER

  (* translate each canonical tree into a list of assembly instructions *)
  val codegen : Tree.stm -> Assem.instr list 

  (* converting a string fragment into the actual assembly code *)
  val string : Temp.label * string -> string

  (* procEntryExit sequence + function calling sequence tune-up 
   * + mapping pseudo-registers to memory load/store instructions 
   * and actual registers.
   * This is a post-pass, to be done after register allocation.
   *)
  val procEntryExit : {name : Temp.label, 
                          body : (Assem.instr * Temp.temp list) list,
                          allocation : R.register Temp.Table.table,
                          formals : Temp.temp list,
                          frame : Frame.frame} -> Assem.instr list
 

end (* signature CODEGEN *)

structure Codegen : CODEGEN =
struct

  structure T = Tree
  structure A = Assem
  structure Er = ErrorMsg
  structure F = Frame
  structure R = Register
  structure S = Symbol

  val instrlist = ref (nil : A.instr list)
  (*utility functions*)
  fun bug s = ErrorMsg.impossible(s)

  fun emit instr = instrlist := instr :: !instrlist
  
  fun int2string i = if i >= 0 then Int.toString(i) else "-" ^ Int.toString(~i)
  
  fun relop2assem T.EQ = "je"
    | relop2assem T.NE = "jne"
    | relop2assem T.LT = "jl"
    | relop2assem T.GT = "jg"
    | relop2assem T.LE = "jle"
    | relop2assem T.GE = "jge"
    | relop2assem T.ULT = "jb"
    | relop2assem T.ULE = "jbe"
    | relop2assem T.UGT = "ja"
    | relop2assem T.UGE = "jae"
    | relop2assem _ = bug "Unsupported relation operation\n"

  fun binop2assem T.PLUS = "addl"
    | binop2assem T.MINUS = "subl"
    | binop2assem T.MUL = "imull"
    | binop2assem T.DIV = "idivl"
    | binop2assem T.AND = "andl"
    | binop2assem T.OR = "orl"
    | binop2assem T.XOR = "xorl"
    | binop2assem T.LSHIFT = "shll"
    | binop2assem T.RSHIFT = "shrl"
    | binop2assem T.ARSHIFT = "sarl"
    | binop2assem _ = bug "Unsupported binary operation\n"

  


  fun pushargs [] = ()
    | pushargs (arg::rest) = 
        (pushargs(rest);
        emit (A.OPER{assem = "pushl `s0\n",
                    src = [munchExp arg],
                    dst = [R.SP],
                    jump = NONE})) 

  and popargs([]) = ()
    | popargs(args) =  emit(A.OPER{assem = "addl $"^ int2string (4 * (length args)) ^", `s0\n",
                       src=[R.SP],
                       dst=[R.SP],
                       jump=NONE})

  and munchStm(T.SEQ(a, b)) = (munchStm a; munchStm b)

    | munchStm(T.EXP(T.CALL(T.NAME(lab), args))) = 
        (pushargs args;
        emit (A.OPER{assem = "call " ^ Symbol.name(lab) ^ "\n",
                    src = [],
                    dst = [],
                    jump = NONE});
        popargs args)

    | munchStm(T.MOVE(T.TEMP(temp), T.CALL(T.NAME(lab), args))) = 
        (pushargs args;
        emit (A.OPER{assem = "call " ^ Symbol.name(lab) ^ "\n",
                    src = [],
                    dst = [R.RV],
                    jump = NONE});
        emit (A.OPER{assem = "movl `s0, `d0\n",
                    src = [R.RV],
                    dst = [temp],
                    jump = NONE});
        popargs args)

     (*move e2 -> [e1+i] , but size is not used here*)
    | munchStm(T.MOVE(T.MEM(T.BINOP(T.PLUS, e1, T.CONST i), size), e2)) = 
        emit (A.OPER{assem="movl `s0, " ^ int2string(i) ^ "(`s1)\n",
                   src = [munchExp e2, munchExp e1],
                   dst = [],
                   jump = NONE})
      (*move e2 -> [i+e1] , but size is not used here*)
    | munchStm(T.MOVE(T.MEM(T.BINOP(T.PLUS, T.CONST i, e1), size), e2)) = 
        emit (A.OPER{assem="movl `s0, " ^ int2string(i) ^ "(`s1)\n",
                   src = [munchExp e2, munchExp e1],
                   dst = [],
                   jump = NONE})
      (*move [e2] -> [e1]*)
    | munchStm(T.MOVE(T.MEM(e1, size1), T.MEM(e2, size2))) = 
        let 
          val temp = Temp.newtemp()
        in 
          emit (A.OPER{assem="movl (`s0), `d0\n",
                      src = [munchExp e2],
                      dst = [temp],
                      jump = NONE});
          emit (A.OPER{assem="movl `s0, (`s1)\n",
                      src = [temp, munchExp e1],
                      dst = [],
                      jump = NONE})
        end
      (*move e -> [i]*)
    | munchStm(T.MOVE(T.MEM(T.CONST i, size), e)) = 
        emit (A.OPER{assem="movl `s0, " ^ int2string(i) ^ "(,1)\n",
                    src = [munchExp e],
                    dst = [],
                    jump = NONE})
      
      (*move e2 -> [e1]*)
    | munchStm(T.MOVE(T.MEM(e1, size), e2)) = 
        emit (A.OPER{assem = "movl `s0, (`s1)\n",
                    src = [munchExp e2, munchExp e1],
                    dst = [],
                    jump = NONE})
      (*move e -> temp*)
    | munchStm(T.MOVE(T.TEMP temp, e)) = 
        emit (A.OPER{assem = "movl `s0, `d0\n",
                    src = [munchExp e],
                    dst = [temp],
                    jump = NONE})

    | munchStm(T.JUMP(T.NAME(label), labels)) = 
        emit (A.OPER{assem = "jmp " ^ Symbol.name(label) ^ "\n",
                    src = [],
                    dst = [],
                    jump = SOME(labels)})

    | munchStm(T.CJUMP(T.TEST(relop, e1, e2), tlabel, flabel)) = 
        (emit (A.OPER{assem = "cmp `s0, `s1\n",
                    src = [munchExp e2, munchExp e1],
                    dst = [],
                    jump = NONE});
        emit (A.OPER{assem = relop2assem(relop) ^ " " ^ Symbol.name(tlabel) ^ "\n",
                    src = [],
                    dst = [],
                    jump = SOME([tlabel, flabel])}))
        

    | munchStm(T.LABEL lab) = 
        emit (A.LABEL{assem = Symbol.name(lab) ^ ":\n",
                    lab = lab})

    | munchStm(T.EXP e) = (munchExp e; ())

    | munchStm _ = bug "Unsupported Itree statement\n"

  and result(gen) = let val t = Temp.newtemp() in gen t; t end

      (*[e+i]*)
  and munchExp(T.MEM(T.BINOP(T.PLUS, e, T.CONST i), size)) = 
        result(fn t => 
          emit (A.OPER{assem = "movl " ^ int2string(i) ^ "(`s0), `d0\n",
                      src = [munchExp e],
                      dst = [t],
                      jump = NONE}))
      (*[i+e]*)
    | munchExp(T.MEM(T.BINOP(T.PLUS, T.CONST i, e), size)) = 
        result(fn t => 
          emit (A.OPER{assem = "movl " ^ int2string(i) ^ "(`s0), `d0\n",
                      src = [munchExp e],
                      dst = [t],
                      jump = NONE}))

    | munchExp(T.MEM(T.CONST i, size)) = 
        result(fn t => 
          emit (A.OPER{assem = "movl " ^ int2string(i) ^ "(,1), `d0\n",
                      src = [],
                      dst = [t],
                      jump = NONE}))

    | munchExp(T.MEM(e, size)) = 
        result(fn t => 
          emit (A.OPER{assem = "movl (`s0), `d0\n",
                      src = [munchExp e],
                      dst = [t],
                      jump = NONE}))

    | munchExp(T.CONST i) = 
        result(fn t => 
          emit (A.OPER{assem = "movl $" ^ int2string(i) ^ ", `d0\n",
                      src = [],
                      dst = [t],
                      jump = NONE}))

    | munchExp(T.BINOP(T.DIV, e1, e2)) = 
        (emit (A.OPER{assem = "movl $0, `d0\n",
              src = [],
              dst = [R.EDX],
              jump = NONE});
        emit (A.OPER{assem = "movl `s0, `d0\n",
              src = [munchExp e1],
              dst = [R.RV],
              jump = NONE});
        emit (A.OPER{assem = "idivl `s0\n",
              src = [munchExp e2, R.RV],
              dst = [R.RV, R.EDX],
              jump = NONE}); R.RV)

    | munchExp(T.BINOP(binop, e1, e2)) = 
        result(fn t => 
          (emit (A.OPER{assem = "movl `s0, `d0\n",
                      src = [munchExp e1],
                      dst = [t],
                      jump = NONE});
          emit (A.OPER{assem = binop2assem(binop) ^ " `s0, `d0\n",
                      src = [munchExp e2, t],
                      dst = [t],
                      jump = NONE})))


    | munchExp(T.NAME(label)) = 
        result(fn t => 
          emit (A.OPER{assem = "leal " ^ Symbol.name(label) ^ ", `d0\n",
                      src = [],
                      dst = [t],
                      jump = NONE}))

    | munchExp(T.TEMP t) = t


    | munchExp _ = bug "Unsupported Itree expression\n"
    

  fun codegen stm = (instrlist := []; munchStm stm; rev(!instrlist))

  fun string (lab, s) =  
 	  let 
 		 val header = S.name(lab) ^ ":\n  .long "  ^ Int.toString(size(s))
 		 val body = String.concatWith ", " (map (fn c => Int.toString(ord(c))) (explode s))
 	  in header ^ "\n  .byte " ^ body ^ "\n" end

 
(************************************************************
  The following is an example implementation of mapping pseudo-registers 
  to memory load/store instructions and actual registers.  It is done
  in a single pass.  It assumes that pseudo-register names start with
  the letter "f".  It uses the actual registers ECX and EDX as temporaries
  when a pseudo-register is an operand of an instruction.

  There is a special case that this function does NOT handle, but you MUST!
  The DIV instruction has special requirements.  Its dividend must be in EAX, 
  its divisor in a general-purpose register.  It returns both the quotient,
  in EAX, and the remainder, in EDX regardless where the original divisor was! 
  So be careful that a divide instruction does not trash something useful
  in EDX, and that you retrieve the correct resulut from the divide instruction.
************************************************************)

  (* regname -- produce an assembly language name for the given machine
   * register or psuedo-register.
   * psuedo-registers are mapped to an expression for psuedo-register's
   * location in stack frame.
   *)
  (* regname : R.register -> string *)
  fun regname reg =
      if (String.isPrefix "f" reg) then
    (* it's a psuedo-register *)
    let
        val (SOME prNum) = Int.fromString (String.extract(reg,1,NONE));
        val offset = (prNum + 1) * 4
    in
        "-" ^ Int.toString(offset) ^ "(%ebp)"
    end
      else
    reg


 (* genSpills -- do our "poor man's spilling".  Maps all pseudo-register
  * references to actual registers, by inserting instructions to load/store
  * the pseudo-register to/from a real register
  *)
 fun genSpills (insns,saytemp) =
     let
    (* doload() -- given name of a source register src, and a true
     * machine register mreg, will return a load instruction (if needed)
     * and a machine register.
     *)
    (* loadit: Temp.temp * Temp.temp -> string * Temp.temp *)
    fun loadit (src,mreg) =
        let 
      val srcnm = (saytemp src)
        in
      if (String.isPrefix "f" srcnm) then
          (* it's a fake register: *)
          let
        (*val _ = print ("loadit(): mpping pseudo-register `"
                          * ^ srcnm ^ "' to machine reg. `" ^ (saytemp mreg)
                          * ^"'\n");*)
        val loadInsn = "\tmovl\t" ^ (regname srcnm) ^ ", " ^ (saytemp mreg) ^ " # load pseudo-register\n"
          in
        (loadInsn, mreg)
          end
      else
          (* no mapping needed *)
          ("", src)
        end
    (* mapsrcs : produce a sequence of instructions to load
     * pseudo-registers into real registers, and produce a list
     * of sources which reflects the real registers.
     *)
    (* mapsrcs : Temp.temp list * Temp.temp list -> string * Temp.temp list *)
    fun mapsrcs ([],_) = ("",[])
      | mapsrcs (src::srcs,mreg::mregs) =
              let
                  val (loadInsn, src') = loadit(src,mreg)
                  val (loadRest, srcs') = mapsrcs(srcs,mregs)
              in
                  (loadInsn ^ loadRest, src'::srcs')
              end
    (* findit -- like List.find, but returns SOME i, where i is index
     * of element, if found
     *)
          fun findit f l =
        let
      fun dosrch([],f,_) = NONE
        | dosrch(el::els,f,idx) =
          if f(el) then
        SOME idx
          else
        dosrch(els,f,idx+1)
        in
      dosrch(l,f,0)
        end

    (* mapdsts -- after we have mapped sources to real machine
     * registers, iterate through dsts.
     * If dst is a pseudo-register then
     *    if dst was also a src,
     *         replace dst with machine register to which src is already
     *         mapped
     *    else
     *         map dst to its own machine register (just use %ecx)
     *    generate a store insn for dst to save result
     *)
          (* mapdsts : Temp.temp list * Temp.temp list * Temp.temp list ->
     *           string * Temp.temp list
     *)
          (* N.B.!  This only works for dst of length 0 or 1 !! *)
          (* pre: length(dsts) <= 1 *)
    fun mapdsts([],_,_) = ("",[])
      | mapdsts(dst::dsts,srcs,newsrcs) =
        let
      val found = findit (fn e => e=dst) srcs
      val dstnm = (saytemp dst)
        in
      if (isSome(found)) then
          (* this dst is also a source *)
          let
        val idx=valOf(found)
        val src=List.nth (srcs,idx)
        val mreg=List.nth (newsrcs,idx)
          in
        if (src <> mreg) then
            ("\tmovl\t`d0, " ^ (regname dstnm) ^ " # save pseudo-register\n", mreg::dsts)
        else
            (* no mapping *)
            ("", dst::dsts)
          end
      else
          (* this dst isn't a source, but it might be a pseudo-register *)
                      if (String.isPrefix "f" dstnm) then
                          (* it's a fake register: *)
                          (* we can safely just replace this destination with
                           * %ecx, and then write out %ecx to the pseudo-register
                           * location.  Even if %ecx was used to hold a different
                           * source pseudo-register, we won't end up clobbering
                           * it until after the source has been used...
                           *)
                          ("\tmovl\t`d0, " ^ (regname dstnm) ^ " # save pseudo-register\n", R.ECX::dsts)
                      else
                          (* no mapping *)
                          ("", dst::dsts)
        end

    fun mapInstr(A.OPER{assem=insn, dst=dsts, src=srcs, jump=jmp}) = 
        let
      val (loadinsns, newsrcs) = mapsrcs(srcs, [R.ECX, R.EDX]);
                      val (storeinsns, newdsts) = mapdsts(dsts, srcs, newsrcs); 
        in
      A.OPER{assem=loadinsns ^ insn ^ storeinsns,
       dst=newdsts, src=newsrcs, jump=jmp}
        end
      | mapInstr(instr as A.LABEL _) = instr
      | mapInstr(instr) =
        (* we never generate these! *)
              ErrorMsg.impossible ("CodeGen: unexpected instruction type in mapInstr!")
     in
         map mapInstr insns
     end


  (* procEntryExit sequence + function calling sequence tune-up 
   * + mapping pseudo-registers to memory load/store instructions 
   * and actual registers.
   * This is a post-pass, to be done after register allocation.
   *)
  fun procEntryExit {name=name, body=body, allocation=allocation, formals=formals, frame=frame:(F.frame)} = 
    let
      val procName = Symbol.name(name)
      val stackSize = (!(#locals(frame)) + Register.NPSEUDOREGS) * 4
      
      val prologIntrs = [
            ".globl " ^ procName,
            "\t.type\t" ^ procName ^ ", @function",
            procName ^ ":",
            "pushl %ebp",
            "movl %esp, %ebp",
            "subl $" ^ int2string(stackSize) ^ ", %esp"]
            @ map (fn r => "pushl " ^ r) R.calleesaves

      val intrs = (List.map (fn(instr, _) => instr) body)
      val spilledInstrs = genSpills(intrs, fn t => valOf(Temp.Table.look(allocation, t)))

      val epilogIntrs =  (map (fn r => "popl " ^ r) (rev R.calleesaves)) @
                            ["movl %ebp, %esp",
                            "popl %ebp",
                            "ret"]
    in 
      [A.OPER({assem=(String.concatWith "\n" prologIntrs) ^ "\n", src=[],dst=[],jump=NONE})] 
      @ spilledInstrs
      @ [A.OPER({assem=(String.concatWith "\n" epilogIntrs) ^ "\n", src=[],dst=[],jump=NONE})]
    end  




end (* structure Codegen *)
