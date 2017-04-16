signature TRANSLATE = sig
  type level
  type access
  type frag
  val outermost : level
  val newLevel : level -> 'a list -> level * access list
  val allocInFrame : level -> access
  type gexp
  val empty : gexp
  val intExp : int -> gexp
  val stringExp : string -> gexp
  val appExp : Temp.label -> gexp list -> level -> level -> gexp
  val relop : Absyn.oper -> gexp -> gexp -> gexp
  val strCmp : Absyn.oper -> gexp -> gexp -> gexp
  val binop : Absyn.oper -> gexp -> gexp -> gexp
  val recordExp : gexp list -> gexp
  val seqExp : gexp list -> gexp
  val assign : gexp -> gexp -> gexp
  val ifThen : gexp -> gexp -> gexp
  val ifThenElse : gexp -> gexp -> gexp -> gexp
  val whileLoop : gexp -> gexp -> Temp.label -> gexp
  val forLoop : gexp -> gexp -> gexp -> Temp.label -> access -> gexp
  val break : Temp.label -> gexp
  val array : gexp -> gexp -> gexp
  val simpleVar : access -> level -> gexp
  val field : gexp -> int -> gexp
  val subscript : gexp -> gexp -> gexp
  val addFrag : Temp.label -> level -> gexp -> unit
  val getFragList : unit -> frag list
end

functor TranslateGen (Register: REGISTER_STD) : TRANSLATE = struct

structure A = Absyn
structure F = Frame
structure T = Tree
structure E = ErrorMsg
structure R = Register
datatype level = TOP | LEVEL of {frame: F.frame,
                                 sl_offset: F.offset,
                                 parent: level} * unit ref
type access = level * F.offset
type frag = F.frag
val outermost = TOP
val fragList = ref (nil : frag list)

fun mem address offset = T.MEM (T.BINOP (T.PLUS, address, offset), F.wordSize)

fun newLevel parent formals =
  let val (frame, offsets) = F.newFrame (length formals + 1) (* static link *)
      val level = LEVEL ({frame = frame, sl_offset = R.paramBaseOffset,
                          parent = parent}, ref ())
      val accesses = map (fn offset => (level, offset)) (tl offsets)
   in (level, accesses)
  end

fun allocInFrame level =
  case level
    of LEVEL ({frame,...}, _) => (level, F.allocInFrame frame)
     | TOP => E.impossible "cannot allocate variable inside TOP"

datatype gexp = Ex of T.exp (* expression *)
              | Nx of T.stm (* no result *)
              | Cx of Temp.label * Temp.label -> T.stm (* conditional *)

fun seq [stm1, stm2] = T.SEQ (stm1, stm2)
  | seq (stm :: stms) = T.SEQ (stm, seq stms)
  | seq nil = E.impossible "T.SEQ requires two or more statements"

fun unEx (Ex e) = e
  | unEx (Cx genstm) =
    let val reg = T.TEMP (Temp.newtemp())
        val t = Temp.newlabel() and f = Temp.newlabel()
     in T.ESEQ (seq [T.MOVE (reg, T.CONST 1),
                     genstm (t, f),
                     T.LABEL f,
                     T.MOVE (reg, T.CONST 0),
                     T.LABEL t],
                reg)
    end
  | unEx (Nx (T.EXP e)) = e
  | unEx (Nx s) = T.ESEQ (s, T.CONST 0)

fun unNx (Ex e) = T.EXP e
  | unNx (Nx s) = s
  | unNx (Cx genstm) = T.EXP (unEx (Cx genstm))

fun unCx (Ex e) =
    (fn (t, f) =>
      (case e
         of T.CONST 0 => T.JUMP (T.NAME f, [f])
          | T.CONST _ => T.JUMP (T.NAME t, [t])
          | _ => T.CJUMP (T.TEST (T.EQ, e, T.CONST 0), f, t)))
  | unCx (Nx _) = E.impossible "cannot convert from no result to conditional"
  | unCx (Cx genstm) = genstm

val empty = Ex (T.CONST 0)

fun intExp i = Ex (T.CONST i)

fun stringExp s =
  let val label = Temp.newlabel()
   in fragList := F.DATA {lab = label, s = s} :: !fragList;
      Ex (T.NAME label)
  end

fun followStaticLinks decRef (LEVEL ({sl_offset, parent,...}, curRef)) fp =
    if curRef = decRef then fp
    else followStaticLinks decRef parent (mem fp (T.CONST sl_offset))
  | followStaticLinks _ _ _ =
    E.impossible "followed chain of static links to TOP level"

fun appExp label argExps TOP (LEVEL ({frame,...}, _)) =
    let val args = map unEx argExps
     in F.updateMaxOutgoingArgs frame (length args);
        Ex (T.CALL (T.NAME label, args)) (* library call *)
    end
  | appExp label argExps (LEVEL ({frame, parent = LEVEL (_, enclRef),...}, _))
           appLevel =
    let val sl = followStaticLinks enclRef appLevel (T.TEMP R.FP)
        val args = sl :: map unEx argExps
     in F.updateMaxOutgoingArgs frame (length args);
        Ex (T.CALL (T.NAME label, args))
    end
  | appExp _ _ _ _ = E.impossible "function call at TOP level"

fun relop oper left right =
  let val oper = case oper of A.EqOp => T.EQ | A.NeqOp => T.NE | A.LtOp => T.LT
                            | A.LeOp => T.LE | A.GtOp  => T.GT | A.GeOp => T.GE
                            | _ => E.impossible "unknown relational operator"
   in Cx (fn (t, f) => T.CJUMP (T.TEST (oper, unEx left, unEx right), t, f))
  end

fun runtimeCall name args = T.CALL (T.NAME (Temp.namedlabel name), args)

fun strCmp oper left right =
  let val left = unEx left and right = unEx right
      fun negate exp = runtimeCall "not" [exp]
   in Cx (unCx (Ex
      (case oper
         of A.EqOp => runtimeCall "stringEqual" [left, right]
          | A.NeqOp => negate (runtimeCall "stringEqual" [left, right])
          | A.LtOp => runtimeCall "stringLessThan" [left, right]
          | A.LeOp => negate (runtimeCall "stringLessThan" [right, left])
          | A.GtOp  => runtimeCall "stringLessThan" [right, left]
          | A.GeOp => negate (runtimeCall "stringLessThan" [left, right])
          | _ => E.impossible "unknown relational operator")))
  end

fun binop oper left right =
  let val oper = case oper of A.PlusOp => T.PLUS | A.MinusOp => T.MINUS
                            | A.TimesOp => T.MUL | A.DivideOp => T.DIV
                            | _ => E.impossible "unknown arithmetic operator"
   in Ex (T.BINOP (oper, unEx left, unEx right))
  end

fun recordExp fields =
  let val reg = T.TEMP (Temp.newtemp())
      val size = T.CONST (length fields * F.wordSize)
      val allocate = T.MOVE (reg, runtimeCall "allocRecord" [size])
      fun saveField (offset, field) =
        T.MOVE (mem reg (T.CONST (offset * F.wordSize)), unEx field)
      val saveFields = List.mapi saveField fields
   in Ex (T.ESEQ (seq (allocate :: saveFields), reg))
  end

fun seqExp nil = E.impossible "sequence must contain at least one expression"
  | seqExp [exp] = exp
  | seqExp (exp :: exps) = Ex (T.ESEQ (unNx exp, unEx (seqExp exps)))

fun assign varExp valExp =
  let val t = T.MOVE (unEx varExp, unEx valExp)
   in Nx t
  end

fun ifThen test thenExp =
  let val t = Temp.newlabel() and f = Temp.newlabel()
   in Nx (seq [unCx test (t, f), T.LABEL t, T.EXP (unEx thenExp), T.LABEL f])
  end

fun ifThenElse test thenExp elseExp =
  let val t = Temp.newlabel() and f = Temp.newlabel() and join = Temp.newlabel()
      val reg = T.TEMP (Temp.newtemp())
   in Ex (T.ESEQ (seq [unCx test (t, f),
                       T.LABEL t,
                       T.MOVE (reg, unEx thenExp),
                       T.JUMP (T.NAME join, [join]),
                       T.LABEL f,
                       T.MOVE (reg, unEx elseExp),
                       T.LABEL join], reg))
  end

fun whileLoop test body done =
  let val t = Temp.newlabel()
   in Nx (seq [unCx test (t, done),
               T.LABEL t,
               unNx body,
               unCx test (t, done),
               T.LABEL done])
  end

fun forLoop loExp hiExp bodyExp done (_, offset) =
  let val var = mem (T.TEMP R.FP) (T.CONST offset)
      val limit = unEx hiExp
      val body = Temp.newlabel()
      val incr = Temp.newlabel ()
   in Nx (seq [T.MOVE (var, unEx loExp),
               T.CJUMP (T.TEST (T.LE, var, limit), body, done),
               T.LABEL body,
               unNx bodyExp,
               T.CJUMP (T.TEST (T.LT, var, limit), incr, done),
               T.LABEL incr,
               T.MOVE (var, T.BINOP (T.PLUS, var, T.CONST 1)),
               T.JUMP (T.NAME body, [body]),
               T.LABEL done])
  end

fun break label = Nx (T.JUMP (T.NAME label, [label]))

fun array size init = Ex (runtimeCall "initArray" [unEx size, unEx init])

fun simpleVar (LEVEL (_, decRef), offset) levelAccessed =
    let val fp = followStaticLinks decRef levelAccessed (T.TEMP R.FP)
     in Ex (mem fp (T.CONST offset))
    end
  | simpleVar _ _ = E.impossible "simple variable at TOP level"

fun field recordStart fieldNum =
  let val offset = T.BINOP (T.MUL, T.CONST fieldNum, T.CONST F.wordSize)
      val start = unEx recordStart
   in Ex (T.ESEQ (T.EXP (runtimeCall "checkNilRecord" [start]),
                  mem start offset))
  end

fun subscript arrayStart idxExp =
  let val start = unEx arrayStart and idx = unEx idxExp
      val offset = T.BINOP (T.MUL, idx, (T.CONST F.wordSize))
   in Ex (T.ESEQ (T.EXP (runtimeCall "checkArrayBounds" [start, idx]),
                  mem start offset))
  end

fun addFrag label (LEVEL ({frame,...}, _)) bodyExp =
    let val body = T.MOVE (T.TEMP R.RV, unEx bodyExp)
        val frag = F.PROC {name = label, body = body, frame = frame}
     in fragList := frag :: !fragList
    end
  | addFrag _ TOP _ = E.impossible "function fragment at TOP level"

fun getFragList () = !fragList before fragList := nil

end (* functor TranslateGen *)
