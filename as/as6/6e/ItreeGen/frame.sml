signature FRAME = sig
  type offset = int
  val wordSize : int
  type frame
  val newFrame : int -> frame * offset list
  val allocInFrame : frame -> offset
  datatype frag = PROC of {name: Temp.label, body: Tree.stm, frame: frame}
                | DATA of {lab: Temp.label, s: string}
  val updateMaxOutgoingArgs : frame -> int -> unit
end

structure Frame : FRAME = struct
  type offset = int
  val wordSize = 4
  type frame = {formals: int,        (* number of formal parameters *)
                offlst: offset list, (* offset list for formals *)
                locals: int ref,     (* # of local variables so far *)
                maxargs: int ref}    (* max outgoing args for the function *)
  datatype frag = PROC of {name: Temp.label, body: Tree.stm, frame: frame}
                | DATA of {lab: Temp.label, s: string}
  structure R = Register
  fun newFrame numFormals =
    let val enum = List.tabulate (numFormals, fn n => n) (* [0, numFormals) *)
        val offsets = map (fn n => R.paramBaseOffset + wordSize * n) enum
     in ({formals = numFormals, offlst = offsets, locals = ref 0,
          maxargs = ref 2}, offsets) (* init to 2 for runtime calls *)
    end
  fun allocInFrame ({locals,...} : frame) =
    R.localsBaseOffset - wordSize * !locals before locals := !locals + 1
  fun updateMaxOutgoingArgs ({maxargs,...} : frame) outgoingArgs =
    maxargs := Int.max (!maxargs, outgoingArgs)
end
