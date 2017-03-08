signature SEMANT =
sig
  type ir_code
  val transprog : Absyn.exp -> {exp: ir_code, ty: Types.ty}
end

structure Semant : SEMANT = 
struct

  structure A = Absyn
  structure E = Env
  structure S = Symbol
  structure T = Types
  val error = ErrorMsg.error
  type ir_code = unit (* not used for the time being *)

  
  (*** FILL IN DETAILS OF YOUR TYPE CHECKER PLEASE !!! ***)

  (*************************************************************************
   *                       UTILITY FUNCTIONS                               *
   *************************************************************************)

  (* ...... *)

  fun checkInt ({exp=_, ty=t}, pos) = (
        if t <> T.INT then 
            error pos "Operand should be integer."
        else ())

  fun checkUnit ({exp=_, ty=t}, pos) = (
        if t <> T.UNIT then 
            error pos "Operand must produce no value."
        else ())

  fun checkEqaulity ({exp=_, ty=T.INT}, {exp=_, ty=T.INT}, pos) = ()
    | checkEqaulity ({exp=_, ty=T.RECORD(l1, uni1)}, 
                    {exp=_, ty=T.RECORD(l2, uni2)}, pos) = 
        if uni1 <> uni2 then error pos "cannot be compared"
        else ()
    | checkEqaulity ({exp=_, ty=T.ARRAY(t1, uni1)}, 
                    {exp=_, ty=T.ARRAY(t2, uni2)}, pos) = 
        if uni1 <> uni2 then error pos "cannot be compared"
        else ()
    | checkEqaulity (_, _, pos) = error pos "cannot be compared"

  fun checkTypeMatch (T.INT, T.INT, pos) = ()
    | checkTypeMatch (T.STRING, T.STRING, pos) = ()
    | checkTypeMatch (T.UNIT, T.UNIT, pos) = ()
    | checkTypeMatch (_, _, pos) = error pos "type doesn't match"
 (**************************************************************************
  *                   TRANSLATING TYPE EXPRESSIONS                         *
  *                                                                        *
  *              transty : (E.tenv * A.ty) -> (T.ty * A.pos)               *
  *************************************************************************)
  fun transty (tenv, A.ArrayTy(id, pos)) =
    let val ty = S.look(tenv, id)
    in 
        if ty = NONE then (error pos (S.name(id) ^ " doesn't exist");
             (T.ARRAY(T.UNIT, ref()), pos))
        else (T.ARRAY(valOf(ty), ref()), pos)
    end 

    | transty (tenv, A.NameTy(id, pos)) =
     let val ty = S.look(tenv, id)
     in 
        if ty = NONE then (error pos (S.name(id) ^ " doesn't exist"); (T.UNIT, pos))
        else (valOf(ty), pos)
    end 

    | transty (tenv, A.RecordTy([])) = (T.RECORD([], ref()), 0)
    | transty (tenv, A.RecordTy(l)) = 
    let
            fun transform_tfields_ty nil = nil
              | transform_tfields_ty ({name, typ, pos}::r) = 
                    let val ty = getOpt(S.look(tenv, typ), T.UNIT)
                    in (name, ty) :: (transform_tfields_ty r) end
            val symbol_ty = transform_tfields_ty l
        in (T.RECORD(symbol_ty, ref ()), 0) end

  (* ...... *)




 (**************************************************************************
  *                   TRANSLATING EXPRESSIONS                              *
  *                                                                        *
  *  transexp : (E.env * E.tenv) -> (.exp -> {exp : ir_code, ty : T.ty})  *
  **************************************************************************)
  fun transexp (env, tenv) expr =
    let fun g (A.OpExp {left,oper=A.NeqOp,right,pos}) = 
                   (checkEqaulity(g left, g right, pos); {exp=(), ty=T.INT})

          | g (A.OpExp {left,oper=A.EqOp,right,pos}) =
                   (checkEqaulity(g left, g right, pos); {exp=(), ty=T.INT}) 

          | g (A.OpExp {left,oper,right,pos}) =
 		   (checkInt (g left, pos);
		    checkInt (g right, pos);
 		    {exp=(), ty=T.INT})

          | g (A.RecordExp {typ,fields,pos}) =
            let 
                fun checkfields (nil, nil) = ()
                  | checkfields (nil, a::r) = 
                    error pos "the length of fields doesn't match"
                  | checkfields (a::r, nil) = 
                    error pos "the length of fields doesn't match"
                  | checkfields ((s1, e, p)::r1, (s2, t)::r2) =
                    let val {exp, ty} = g e
                    in checkTypeMatch (ty, t, p);
                       if s1 <> s2 then error p "symbol of fields doesn't match"
                       else ();     
                       checkfields(r1, r2) 
                    end
            in case S.look(tenv, typ) of NONE =>
                    (error pos "record type donesn't exist";
                    {exp=(), ty=T.RECORD([], ref ())})
                | SOME(T.RECORD(l, unique)) =>
                    (checkfields (fields, l);
                    {exp=(), ty=T.RECORD(l,unique)})
                | SOME(_) => 
                    (error pos (S.name(typ) ^ " is not record type");
                    {exp=(), ty=T.RECORD([], ref ())})
            end

          | g (A.AppExp {func, args, pos}) =
            let 
                fun checkFormals (nil, nil) = ()
                  | checkFormals (nil, (a::r)) = 
                    error pos "the length of formals and agrs doesn't match"
                  | checkFormals ((a::r), nil) = 
                    error pos "the length of formals and agrs doesn't match"
                  | checkFormals ((a1::r1), (a2::r2)) = 
                    let val {exp, ty} = g a2
                    in checkTypeMatch(ty, a1, pos);
                        checkFormals(r1, r2)
                    end
            in   case S.look(env, func) of NONE => 
                    (error pos "function doesn't exist";
                    {exp=(), ty=T.UNIT})
                 | SOME(E.FUNentry {level, label, formals, result}) => 
                    (checkFormals(formals, args);
                    {exp=(), ty=result})
                 | SOME(_) =>
                     (error pos (S.name(func) ^ " is not a function type");
                     {exp=(), ty=T.UNIT})
            end
            
          | g (A.SeqExp []) = {exp=(), ty=T.UNIT}
          | g (A.SeqExp ((e, p)::r)) = (g e; g(A.SeqExp r))

          | g (A.AssignExp {var, exp, pos}) = 
                let val {exp=e1, ty=t1} = h var
                    val {exp=e2, ty=t2} = g exp
                in checkTypeMatch(t1, t2, pos);
                   {exp=(), ty=T.UNIT}
                end 

          | g (A.IfExp {test, then', else', pos}) = 
                (checkInt(g test, pos);
                checkUnit(g then', pos);
                case else' of SOME(exp) => checkUnit(g exp, pos)
                   | NONE => ();
                {exp=(), ty=T.UNIT})
          
          | g (A.WhileExp {test, body, pos}) = 
                (checkInt (g test, pos);
                 checkUnit(g body, pos);
                 g body;
                 {exp=(), ty=T.UNIT})
          
          | g (A.ForExp {var, lo, hi, body, pos}) = 
                let 
                    val v = A.VarDec {var=var, typ=NONE, init=lo, pos=pos};
                    val (env', tenv') = transdec (env, tenv, v)
                in
                    (checkInt (g lo, pos);
                     checkInt (g hi, pos);
                     checkUnit (g body, pos);
                     transexp (env', tenv') body)
                end
          
          | g (A.BreakExp pos) = {exp=(), ty=T.UNIT}
          
          | g (A.LetExp {decs, body, pos}) = 
                let val (env', tenv') = transdecs (env, tenv, decs)
                in transexp (env', tenv') body end
          
          | g (A.ArrayExp {typ, size, init, pos}) = (*{exp=(), ty=T.UNIT} *)
                let val {exp, ty} = g init
                in  checkInt(g size, pos);
                    case S.look(tenv, typ) of NONE => 
                        (error pos "array type doesn't exist";
                        {exp=(), ty=T.UNIT})
                   | SOME(T.ARRAY(t, _)) =>
                        (checkTypeMatch (t, ty, pos);
                        {exp=(), ty=T.ARRAY(ty, ref ())})
                   | SOME(_) => 
                       (error pos "type is not array type";
                        {exp=(), ty=T.UNIT}) 
                end
                 
          | g (A.NilExp) = {exp=(), ty=T.NIL}

          | g (A.IntExp num) = {exp=(), ty=T.INT}
         
          | g (A.StringExp (s, pos)) = {exp=(), ty=T.STRING}  
        
          | g (A.VarExp var) = h var

        (* function dealing with "var", may be mutually recursive with g *)
        and h (A.SimpleVar (id,pos)) = 
                (case S.look(env, id) of NONE =>
                    (error pos ("undefined variable " ^ S.name(id));
                    {exp=(), ty=T.UNIT})
                | SOME(E.VARentry{access, ty}) => 
                    {exp=(), ty=ty}
                | SOME(_) =>
                    (error pos (S.name(id) ^ "is not simple var");
                    {exp=(), ty=T.UNIT}))

	  | h (A.FieldVar (v,id,pos)) =  
              let val {exp, ty} = h v
                    (*find field type in field list*)
                    fun find_field_ty (nil, sym) = NONE
                      | find_field_ty ((s, t)::r, sym) = 
                            if s = sym then SOME(t)
                            else find_field_ty(r, sym)

                in case ty of T.RECORD(l, unique) =>
                        (case find_field_ty(l, id) of NONE => (
                                error pos ("previous var doesn't contain field: " ^
                                             S.name(id));
                                {exp=(), ty=T.UNIT})
                        | SOME(ty) => {exp=(), ty=ty})
                    | _ => (error pos "previous var is not record";
                            {exp=(), ty=T.UNIT})
                end 

	  | h (A.SubscriptVar (v,expr,pos)) =
                let val {exp, ty} = h v
                in case ty of T.ARRAY(t, unique) => 
                        (checkInt(g expr, pos);
                        {exp=(), ty=t})
                    | _ => (error pos "previous var is not array";
                            {exp=(), ty=T.UNIT})
                end

     in g expr
    end

 (**************************************************************************
  *                   TRANSLATING DECLARATIONS                             *
  *                                                                        *
  *  transdec : (E.env * E.tenv * A.dec) -> (E.env * E.tenv)               *
  **************************************************************************)
  and transdec (env, tenv, A.VarDec({var, typ, init, pos})) = 
    let val var_id = #name var
        val {exp, ty} = transexp (env, tenv) init
        val v = E.VARentry{access=(), ty=ty}
        val env' = S.enter(env, var_id, v)
    in 
        case typ 
          of NONE => (env', tenv)
          | SOME(s, p) => 
            let val t = S.look(tenv, s)
            in
              case t of NONE => (error pos "type doesn't exist"; (env, tenv)) 
                  | SOME(t') => 
                      if t' <> ty then (error pos "type doesn't match";(env, tenv))
                      else (env', tenv)
            end
    end  

    | transdec (env, tenv, A.FunctionDec(nil)) = (env, tenv)
    | transdec (env, tenv, A.FunctionDec({name, params, result, body, pos}::r))=
        let 
            fun transform_formals_ty (te, p) = []
            fun enter_params(e, p) = e
            val formals_ty = transform_formals_ty(tenv, params)
            val entry = E.FUNentry{level=(), label=(), formals=formals_ty,
                    result=T.NAME(name, ref NONE)}
            val env' = S.enter(env, name, entry)
            val env'' = enter_params(env', params)
            val {exp, ty} = transexp (env'', tenv) body
        in 
            case result of NONE =>
                    let val entry' = E.FUNentry{level=(), label=(), formals=formals_ty,
                            result=T.NAME(name, ref(SOME ty))}
                        val env' = S.enter(env, name, entry')
                    in (env', tenv) end
               | SOME(id, p) => 
                    case S.look(tenv, id) of NONE => (error p "type doesn't exist"; 
                                                (env', tenv))
                    | SOME(typ) => 
                        let val entry' = E.FUNentry{level=(), label=(),
                                formals=formals_ty, result=T.NAME(name, ref(SOME typ))}
                            val env' = S.enter(env, name, entry')
                        in (checkTypeMatch(typ, ty, p); (env', tenv)) end
        end


    | transdec (env, tenv, A.TypeDec(nil)) = (env, tenv)
    | transdec (env, tenv, A.TypeDec({name, ty, pos}::r)) =
        let 
          val (t, p) = transty(tenv, ty)
          val tenv' = S.enter(tenv, name, t)
        in transdec(env, tenv', A.TypeDec(r)) end

  (*** transdecs : (E.env * E.tenv * A.dec list) -> (E.env * E.tenv) ***)
  and transdecs (env,tenv,nil) = (env, tenv)
    | transdecs (env,tenv,dec::decs) =
	let val (env',tenv') = transdec (env,tenv,dec)
 	 in transdecs (env',tenv',decs)
	end

  (*** transprog : A.exp -> {exp : ir_code, ty : T.ty} ***)
  fun transprog prog = transexp (E.base_env, E.base_tenv) prog

end  (* structure Semant *)
  

