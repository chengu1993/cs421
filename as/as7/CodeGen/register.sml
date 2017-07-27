(* register.sml *)

signature REGISTER =
sig 
  include REGISTER_STD

  val ECX : Temp.temp
  val EDX : Temp.temp

 (* we maintain a separate list here of true callersaves, so that
  * CodeGen will not emit code to "save" the pseudo-registers, since
  * they already live on the stack.
  *)
  val truecallersaves : register list (* CodeGen use only! *)

  (* number of pseudo-registers: *)
  val NPSEUDOREGS : int  (* CodeGen use only! *)

end (* signature REGISTER *)



structure Register : REGISTER = 
struct

  type register = string

  val RV = Temp.newtemp()
  val FP = Temp.newtemp()

  val SP = Temp.newtemp()

  val ECX = Temp.newtemp()
  val EDX = Temp.newtemp()


  val NPSEUDOREGS = 30 
  val localsBaseOffset : int = ~4 * (NPSEUDOREGS + 1) 
  val paramBaseOffset : int = 8  

  val specialregs : (Temp.temp * register) list = [
                                            (RV, "%eax"), 
                                            (FP, "%ebp"), 
                                            (SP, "%esp"), 
                                            (ECX, "%ecx"), 
                                            (EDX, "%edx")]

  val argregs : (Temp.temp * register) list = []

  val calleesaves : register list = ["%ebx", "%edi", "%esi"]

  val truecallersaves : register list = ["%eax", "%ecx", "%edx"]

  val callersaves : register list = map (fn i => "f" ^ Int.toString(i)) 
                                                         (List.tabulate(NPSEUDOREGS, fn x => x+1))


  val registers: register list = calleesaves @ callersaves

end (* structure Register *)

