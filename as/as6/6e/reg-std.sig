signature REGISTER_STD =
sig
  type register = string
  val RV : Temp.temp (* return value *)
  val FP : Temp.temp (* frame pointer *)
  val SP : Temp.temp (* stack pointer *)
  val paramBaseOffset : int
  val localsBaseOffset : int
  val specialregs : (Temp.temp * register) list
  val calleesaves : register list
  val callersaves : register list
end (* signature REGISTER_STD *)
