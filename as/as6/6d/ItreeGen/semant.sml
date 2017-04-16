signature SEMANT = sig val transprog : Absyn.exp -> Frame.frag list end

functor SemantGen (Register: REGISTER_STD) : SEMANT = struct

structure A = Absyn
structure Tr = TranslateGen (Register)
structure E = EnvGen (Tr)
structure S = Symbol
structure T = Types
val e = ErrorMsg.error

val canBreak = ref [false]
fun enterLoop () = canBreak := true :: !canBreak
fun exitLoop () = canBreak := tl (!canBreak)
fun enterFn () = canBreak := false :: !canBreak
fun exitFn () = canBreak := tl (!canBreak)
fun reset () = canBreak := [false]

fun tyBinding tenv name = valOf (S.look (tenv, name))

fun actualTy tenv (T.NAME (name, ref (SOME ty))) = ty
  | actualTy tenv (T.NAME (name, tyOpRef as ref NONE)) =
    let val ty = actualTy tenv (tyBinding tenv name)
     in tyOpRef := SOME ty; ty
    end
  | actualTy _ ty = ty

fun sameTy (T.RECORD (_, ref1)) (T.RECORD (_, ref2)) = (ref1 = ref2)
  | sameTy (T.RECORD _) T.NIL = true
  | sameTy T.NIL (T.RECORD _) = true
  | sameTy T.INT T.INT = true
  | sameTy T.STRING T.STRING = true
  | sameTy (T.ARRAY (_, ref1)) (T.ARRAY (_, ref2)) = (ref1 = ref2)
  | sameTy T.UNIT T.UNIT = true
  | sameTy _ _ = false

fun constraintsSatisfied pos constraints =
  let fun check (true, msg) = ()
        | check (false, msg) = e pos msg
   in map check constraints;
      List.all #1 constraints
  end

fun transExp env tenv level expr break = let
    fun trExp (A.VarExp var) = trVar var
      | trExp (A.NilExp) = (Tr.empty, T.NIL)
      | trExp (A.IntExp i) = (Tr.intExp i, T.INT)
      | trExp (A.StringExp (s, pos)) = (Tr.stringExp s, T.STRING)
      | trExp (A.AppExp {func, args, pos}) =
        let fun checkArgs (formal :: formals) (arg :: args) =
                let val (argExp, argTy) = trExp arg
                 in if sameTy (actualTy tenv formal) argTy then ()
                    else e pos "type mismatch in function argument";
                    argExp :: checkArgs formals args
                end
              | checkArgs nil nil = nil
              | checkArgs nil _ = nil before e pos "missing arguments"
              | checkArgs _ nil = nil before e pos "too many arguments"
         in case S.look (env, func)
              of SOME (E.FUNentry {level = decLevel, label, formals, result}) =>
                 let val argExps = checkArgs formals args
                  in (Tr.appExp label argExps decLevel level, result)
                 end
               | _ => (Tr.empty, T.INT) before e pos "unbound function name"
        end
      | trExp (A.OpExp {left, oper, right, pos}) =
        let val (leftExp, leftTy) = trExp left
            val (rightExp, rightTy) = trExp right
            val exp = case oper
                of (A.EqOp | A.NeqOp) =>
                   if constraintsSatisfied pos
                        [(sameTy leftTy rightTy,
                          "type mismatch between operands"),
                         (leftTy <> T.NIL orelse rightTy <> T.NIL,
                          "cannot infer record type of nil expressions")]
                   then if leftTy = T.STRING
                        then Tr.strCmp oper leftExp rightExp
                        else Tr.relop oper leftExp rightExp
                   else Tr.empty
                 | (A.LtOp | A.LeOp | A.GtOp | A.GeOp) =>
                   (case (leftTy, rightTy)
                      of (T.INT, T.INT) => Tr.relop oper leftExp rightExp
                       | (T.STRING, T.STRING) => Tr.strCmp oper leftExp rightExp
                       | _ => Tr.empty before
                        e pos "type mismatch; expected integers or strings")
                 | (A.PlusOp | A.MinusOp | A.TimesOp | A.DivideOp) =>
                   if leftTy = T.INT andalso rightTy = T.INT
                   then Tr.binop oper leftExp rightExp
                   else Tr.empty before
                        e pos "type mismatch; operands must be integers"
         in (exp, T.INT)
        end
      | trExp (A.RecordExp {typ, fields=efields, pos}) =
        let fun checkFields (tfield :: tfields) (efield :: efields) =
                let val (varSym : S.symbol, varTy) = tfield
                    val (expSym, exp, pos) = efield
                    val (exp, ty) = trExp exp
                    val satisfied = constraintsSatisfied pos
                        [(varSym = expSym, "field name mismatch in record"),
                         (sameTy (actualTy tenv varTy) ty,
                          "type mismatch in record field")]
                    val (othersSatisfied, exps) = checkFields tfields efields
                 in (satisfied andalso othersSatisfied, exp :: exps)
                end
              | checkFields nil nil = (true, nil)
              | checkFields nil _ =
                (false, nil) before e pos "missing record fields"
              | checkFields _ nil =
                (false, nil) before e pos "too many record fields"
            val eRec = (Tr.empty, T.RECORD ([], ref ()))
            fun trRecord (ty as T.RECORD (tfields, _)) =
                let val (satisfied, fieldExps) = checkFields tfields efields
                 in if satisfied then (Tr.recordExp fieldExps, ty) else eRec
                end
              | trRecord _ = eRec before e pos "type mismatch: expected record"
         in case S.look (tenv, typ)
              of SOME ty => trRecord (actualTy tenv ty)
               | NONE => eRec before e pos "unbound record type"
        end
      | trExp (A.SeqExp exps) =
        let fun trSeq nil = (Tr.empty, T.UNIT)
              | trSeq [(exp, _)] = trExp exp
              | trSeq exps =
                let val trExps = map (trExp o #1) exps
                    val exp = Tr.seqExp (map #1 trExps)
                    val lastTy = (#2 o List.last) trExps
                 in (exp, lastTy)
                end
         in trSeq exps
        end
      | trExp (A.AssignExp {var, exp, pos}) =
        let val (leftExp, leftTy) = trVar var
            val (rightExp, rightTy) = trExp exp
         in if constraintsSatisfied pos
                [case var
                   of A.SimpleVar (symbol, _) =>
                      (case S.look (env, symbol)
                         of SOME (E.VARentry {readonly,...}) =>
                            if not readonly then (true, "")
                            else (false, "assignment to read-only loop counter")
                          | _ => (false, "assignment to unbound lval"))
                    | _ => (true, ""),
                 (sameTy leftTy rightTy, "type mismatch between lval and rval")]
            then (Tr.assign leftExp rightExp, T.UNIT)
            else (Tr.empty, T.UNIT)
        end
      | trExp (A.IfExp {test, then', else', pos}) =
        let val (testExp, testTy) = trExp test
            val (thenExp, thenTy) = trExp then'
            val expRef = ref Tr.empty
            val tyRef = ref T.UNIT
         in if testTy = T.INT then ()
            else e pos "test expression must produce an integer";
            case else'
              of SOME exp =>
                 let val (elseExp, elseTy) = trExp exp
                  in if sameTy thenTy elseTy
                     then (if thenTy = T.NIL then tyRef := elseTy
                           else tyRef := thenTy;
                           expRef := Tr.ifThenElse testExp thenExp elseExp)
                     else e pos "type mismatch between if and then clauses"
                 end
               | NONE =>
                 if thenTy = T.UNIT
                 then expRef := Tr.ifThen testExp thenExp
                 else e pos "then clause cannot produce a value";
            (!expRef, !tyRef)
        end
      | trExp (A.WhileExp {test, body, pos}) =
        let val (testExp, testTy) = trExp test
            val break = Temp.newlabel()
            val (bodyExp, bodyTy) = (enterLoop();
                transExp env tenv level body break before exitLoop())
         in if constraintsSatisfied pos
                 [(testTy = T.INT, "test must be an integer expression"),
                  (bodyTy = T.UNIT, "loop body cannot produce a value")]
            then (Tr.whileLoop testExp bodyExp break, T.UNIT)
            else (Tr.empty, T.UNIT)
        end
      | trExp (A.ForExp {var={name, escape=_}, lo, hi, body, pos}) =
        let val (loExp, loTy) = trExp lo
            val (hiExp, hiTy) = trExp hi
            val access = Tr.allocInFrame level
            val bind = E.VARentry {access = access, ty = T.INT, readonly = true}
            val env = S.enter (env, name, bind)
            val break = Temp.newlabel()
            val (bodyExp, bodyTy) = (enterLoop();
                transExp env tenv level body break before exitLoop())
         in if constraintsSatisfied pos
                 [(loTy = T.INT, "lower bound must evaluate to an integer"),
                  (hiTy = T.INT, "upper bound must evaluate to an integer"),
                  (bodyTy = T.UNIT, "loop body cannot produce a value")]
            then (Tr.forLoop loExp hiExp bodyExp break access, T.UNIT)
            else (Tr.empty, T.UNIT)
        end
      | trExp (A.BreakExp pos) =
        if hd (!canBreak)
        then (Tr.break break, T.UNIT)
        else (Tr.empty, T.UNIT) before
             e pos "break expression outside for-loop or while-loop"
      | trExp (A.LetExp {decs, body, pos}) =
        let val (env, tenv, exps) = transDecs env tenv level decs break
            val (exp, ty) = transExp env tenv level body break
         in (Tr.seqExp (exps @ [exp]), ty)
        end
      | trExp (A.ArrayExp {typ, size, init, pos}) =
        let val eArray = (Tr.empty, T.ARRAY (T.UNIT, ref ()))
            fun trArray (ty as T.ARRAY (valTy, _)) =
                let val (sizeExp, sizeTy) = trExp size
                    val (initExp, initTy) = trExp init
                 in if constraintsSatisfied pos
                         [(sizeTy = T.INT, "array size must be an integer"),
                          (sameTy (actualTy tenv valTy) initTy,
                           "type mismatch: expected array value")]
                    then (Tr.array sizeExp initExp, ty)
                    else eArray
                end
              | trArray _ = eArray before e pos "type mismatch: expected array"
         in case S.look (tenv, typ)
              of SOME ty => trArray (actualTy tenv ty)
               | NONE => eArray before e pos "unbound array type"
        end
      and trVar (A.SimpleVar (id, pos)) =
          (case S.look (env, id)
             of SOME (E.VARentry {access, ty, ...}) =>
                (Tr.simpleVar access level, actualTy tenv ty)
              | _ => (Tr.empty, T.UNIT) before e pos "unbound variable")
        | trVar (A.FieldVar (var, fieldId, pos)) =
          let val eField = (Tr.empty, T.UNIT)
              val (varExp, varTy) = trVar var
              fun trField ((id, ty) :: fields) fieldNum =
                  if id = fieldId
                  then (Tr.field varExp fieldNum, actualTy tenv ty)
                  else trField fields (fieldNum + 1)
                | trField nil _ =
                  eField before e pos "unbound record field"
           in case varTy
                of T.RECORD (fields, _) => trField fields 0
                 | _ => eField before e pos "field access of non-record type"
          end
        | trVar (A.SubscriptVar (var, exp, pos)) =
          let val (varExp, varTy) = trVar var
              val (idxExp, idxTy) = trExp exp
              val tyRef = ref T.UNIT
           in if constraintsSatisfied pos
                   [(idxTy = T.INT, "array index must evaluate to an integer"),
                    case varTy of T.ARRAY (ty, _) =>
                                  (true, "") before tyRef := actualTy tenv ty
                                | _ => (false, "subscript of non-array type")]
              then (Tr.subscript varExp idxExp, !tyRef)
              else (Tr.empty, !tyRef)
          end
  in trExp expr end

and transDec env tenv level (A.VarDec {var={name,...}, typ, init, pos}) break =
    let val (initExp, initTy) = transExp env tenv level init break
        fun varTy (SOME (symbol, pos)) =
            (case S.look (tenv, symbol)
               of SOME ty =>
                  let val constraintTy = actualTy tenv ty
                   in if sameTy constraintTy initTy then (constraintTy, true)
                      else (T.UNIT, false) before
                        e pos "initial value does not match type constraint"
                  end
                | NONE => (T.UNIT, false) before e pos "unbound type")
          | varTy NONE =
            if initTy <> T.NIL then (initTy, true)
            else (T.UNIT, false) before e pos "cannot infer type of nil"
        val (ty, valid) = varTy typ
        val access = Tr.allocInFrame level
        val binding = E.VARentry {access = access, ty = ty, readonly = false}
        val env = S.enter (env, name, binding)
        val exp = if valid then Tr.assign (Tr.simpleVar access level) initExp
                  else Tr.empty
     in (env, tenv, [exp])
    end
  | transDec env tenv level (A.FunctionDec fundecs) break =
    let fun trTy id pos =
            case S.look (tenv, id)
              of SOME ty => actualTy tenv ty
               | NONE => T.UNIT before e pos "unbound type"
        fun trParam {var = {name, escape=_}, typ, pos} =
            {name = name, ty = trTy typ pos}
        fun resultTy (SOME (id, pos)) = trTy id pos
          | resultTy NONE = T.UNIT
        fun trDecs env nil = (env, nil)
          | trDecs env ({name, params, result, body, pos} :: decs) =
            let val label = Temp.newlabel()
                val (level, accessList) = Tr.newLevel level params
                val entry = E.FUNentry {level = level, label = label,
                                        formals = map (#ty o trParam) params,
                                        result = resultTy result}
                val env = S.enter (env, name, entry)
                val (env, levels) = trDecs env decs
             in (env, (label, level, accessList) :: levels)
            end
        fun filterDups ((fundec as {name, pos,...}) :: fundecs) ids =
            (if List.exists (fn id => name = id) ids
             then (e pos "duplicate function name in function sequence";
                   filterDups fundecs ids)
             else fundec :: filterDups fundecs (name :: ids))
          | filterDups (nil : A.fundec list) _ = nil
        val fundecs = filterDups fundecs nil
        val (env, decs) = trDecs env fundecs
        fun enterParams env ({name, ty} :: params) (access :: accesses) =
            let val entry = E.VARentry {access=access, ty=ty, readonly=false}
                val env = S.enter (env, name, entry)
             in enterParams env params accesses
            end
          | enterParams env _ _ = env
        fun trDefs ({name=_, params, result, body, pos} :: defs)
                   ((label, level, accessList) :: levels) =
            let val env = enterParams env (map trParam params) accessList
                val (bodyExp, bodyTy) = (enterFn();
                    transExp env tenv level body break before exitFn())
             in Tr.addFrag label level bodyExp;
                if sameTy (resultTy result) bodyTy then ()
                else e pos "mismatch between function body and return type";
                trDefs defs levels
            end
          | trDefs _ _ = ()
     in trDefs fundecs decs; (env, tenv, nil)
    end
  | transDec env tenv level (A.TypeDec tydecs) break =
    let fun filterDups ((tydec as {name, ty=_, pos}) :: tydecs) ids =
            (if List.exists (fn id => name = id) ids
             then (e pos "duplicate type name in type sequence";
                   filterDups tydecs ids)
             else tydec :: filterDups tydecs (name :: ids))
          | filterDups nil (_ : S.symbol list) = nil
        val tydecs = filterDups tydecs nil
        fun enterTyName ({name, ty, pos=_}, tenv) =
          S.enter (tenv, name, T.NAME (name, ref NONE))
        val tenv = foldl enterTyName tenv tydecs
        fun trTy tenv (A.NameTy (name, pos)) = T.NAME (name, ref NONE)
          | trTy tenv (A.RecordTy tfields) =
            let fun trField {name, typ, pos} =
                case S.look (tenv, typ)
                  of SOME ty => (name, ty)
                   | _ => (name, T.UNIT) before e pos "unbound field type"
             in T.RECORD (map trField tfields, ref ())
            end
          | trTy tenv (A.ArrayTy (name, pos)) =
            case S.look (tenv, name)
              of SOME ty => T.ARRAY (ty, ref ())
               | NONE => T.ARRAY (T.UNIT, ref ())
                 before e pos "unbound array element type"
        fun enterTyDef ({name, ty, pos=_}, tenv) =
          S.enter (tenv, name, trTy tenv ty)
        val tenv = foldl enterTyDef tenv tydecs
        fun detectCycle (T.NAME (_, ref (SOME ty))) _ _ = ty
          | detectCycle (T.NAME (name, tyOpRef as ref NONE)) sentinel pos =
            if name <> sentinel
            then let val ty = detectCycle (tyBinding tenv name) sentinel pos
                  in tyOpRef := SOME ty; ty
                 end
            else T.UNIT before e pos "primitive cycle in type sequence"
          | detectCycle ty _ _ = ty
        fun detectCycles ({name, ty=_, pos} :: tydecs) =
            let val binding = tyBinding tenv name
             in detectCycle binding name pos; detectCycles tydecs
            end
          | detectCycles nil = ()
     in detectCycles tydecs; (env, tenv, nil)
    end

and transDecs env tenv _ nil _ = (env, tenv, nil)
  | transDecs env tenv level (dec :: decs) break =
    let val (env, tenv, exp) = transDec env tenv level dec break
        val (env, tenv, exps) = transDecs env tenv level decs break
     in (env, tenv, exp @ exps)
    end

fun transprog prog =
  let val (mainLevel, _) = Tr.newLevel Tr.outermost nil
      val label = Temp.namedlabel "tigermain"
      val (progExp, _) = transExp E.base_env E.base_tenv mainLevel prog label
   in Tr.addFrag label mainLevel progExp; Tr.getFragList()
  end

end (* functor SemantGen *)
