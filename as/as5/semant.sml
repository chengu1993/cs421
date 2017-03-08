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
  val loopLevel = ref [0]
  
  (*** FILL IN DETAILS OF YOUR TYPE CHECKER PLEASE !!! ***)

  (*************************************************************************
   *                       UTILITY FUNCTIONS                               *
   *************************************************************************)

  (* ...... *)

  fun checkInt ({exp=_, ty=t}, pos) = (
        if t <> T.INT then 
            error pos "should be integer."
        else ())

  fun checkUnit ({exp=_, ty=t}, pos) = (
        if t <> T.UNIT then 
            error pos "must produce no value."
        else ())

  fun actualTy {exp=_, ty=ty} = 
        case ty of T.NAME(name, tyRef) =>
            (case !tyRef of NONE => T.INT
                | SOME(t) => (actualTy {exp=(), ty=t}))
        | t => t

  fun checkTypeMatch (ty1, ty2, pos, msg) = 
        let val t1 = actualTy {exp=(), ty=ty1}
            val t2 = actualTy {exp=(), ty=ty2}
            
            fun helper (T.INT, T.INT) = true
              | helper (T.STRING, T.STRING) = true
              | helper (T.UNIT, T.UNIT) = true
              | helper (T.RECORD(l1, uni1), T.RECORD(l2, uni2)) = 
                    if uni1 <> uni2 then (error pos msg; false)
                    else true
              | helper (T.ARRAY(t1, uni1), T.ARRAY(t2, uni2)) = 
                    if uni1 <> uni2 then (error pos msg; false)
                    else true
              | helper (T.RECORD(_, _), T.NIL) = true
              | helper (T.NIL, T.RECORD(_, _)) = true
              | helper (_, _) = (error pos msg; false)
        in (*T.printTy t1; T.printTy t2;*) helper(t1, t2) end

  fun checkComparable (l, r , oper, pos, msg) =  
        let val ty1 = actualTy l
            val ty2 = actualTy r
            fun checkEqualityComparable (ty1, ty2)  =
                    case (ty1, ty2) of (T.INT, T.INT) => ()
                        | (T.STRING, T.STRING) => ()
                        | (T.RECORD(l1, uni1), T.RECORD(l2, uni2)) => 
                                if uni1 <> uni2 then error pos msg
                                else ()
                        | (T.ARRAY(t1, uni1), T.ARRAY(t2, uni2)) => 
                                if uni1 <> uni2 then error pos msg
                                else ()
                        | (T.RECORD(_, _), T.NIL) => ()
                        | (T.NIL, T.RECORD(_, _)) => ()
                        | (_, _) => error pos msg
    
            fun checkOrderComparable (ty1, ty2)  = 
                    case (ty1, ty2) of (T.INT, T.INT) => ()
                                | (T.STRING, T.STRING) => ()
                                | (_, _) => error pos msg 
        in
            if oper = A.EqOp orelse oper = A.NeqOp then 
                checkEqualityComparable (ty1, ty2)
            else checkOrderComparable (ty1, ty2)
        end

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
                    let val tyOption = S.look(tenv, typ)
                        val ty = getOpt(tyOption, T.UNIT)
                        fun checkDefinedType ty = 
                            case ty of NONE => error pos
                                ("undefined type " ^ S.name(typ))
                            | _ => ()  
                    in 
                        checkDefinedType tyOption;
                        (name, ty) :: (transform_tfields_ty r)
                    end
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
                  (checkComparable(g left, g right, A.NeqOp, pos, "Type \
                  \mismatch in inequality comparison \"<>\".");
                  {exp=(), ty=T.INT})
               

          | g (A.OpExp {left,oper=A.EqOp,right,pos}) =
                   (checkComparable(g left, g right, A.EqOp, pos, "Type \
                         \mismatch in equality comparison \"=\".");
                    {exp=(), ty=T.INT}) 

          | g (A.OpExp {left,oper=A.LtOp,right,pos}) =
                   (checkComparable(g left, g right, A.LtOp, pos, "Illegal type\
                        \ for order comparison \"<\".");
                    {exp=(), ty=T.INT}) 

          | g (A.OpExp {left,oper=A.LeOp,right,pos}) =
                   (checkComparable(g left, g right, A.LeOp, pos, "Illegal type\
                        \ for order comparison \"<=\". ");
                    {exp=(), ty=T.INT}) 
          
          | g (A.OpExp {left,oper=A.GtOp,right,pos}) =
                   (checkComparable(g left, g right, A.GtOp, pos, "Illegal type\
                        \ for order comparison \">\".");
                    {exp=(), ty=T.INT}) 
          
          | g (A.OpExp {left,oper=A.GeOp,right,pos}) =
                   (checkComparable(g left, g right, A.GeOp, pos, "Illegal type\
                        \ for order comparison \">=\". ");
                    {exp=(), ty=T.INT}) 
          
          | g (A.OpExp {left,oper,right,pos}) =
 		   (checkInt (g left, pos);
		    checkInt (g right, pos);
 		    {exp=(), ty=T.INT})

          | g (A.RecordExp {typ,fields,pos}) =
            let 
                fun checkfields (nil, nil) = true
                  | checkfields (nil, a::r) = 
                    (error pos "the length of fields doesn't match"; false)
                  | checkfields (a::r, nil) = 
                    (error pos "the length of fields doesn't match"; false)
                  | checkfields ((s1, e, p)::r1, (s2, t)::r2) =
                        let val {exp, ty} = g e
                        in  if s1 <> s2 then (error p ("Expected binding for \
                                \field `" ^ S.name(s2) ^ "', found binding for `" ^
                                S.name(s1) ^ "'."); false)
                            else (checkTypeMatch (ty, t, p, ("Type of field `" ^
                                S.name(s2) ^ "' initializer does not agree \
                                             \with record declaration."))); 
                            checkfields(r1, r2) 
                        end
            in case S.look(tenv, typ) of NONE =>
                    (error pos ("Record type donesn't exist: " ^ S.name(typ));
                    {exp=(), ty=T.INT})
                | SOME(T.NAME(name, tyRef)) =>
                    (case !tyRef of NONE => {exp=(), ty=T.INT}
                     | SOME(ty') => 
                        (case actualTy({exp=(), ty=ty'}) of
                            T.RECORD(l, unique) => 
                                (if checkfields (fields, l)
                                then {exp=(), ty=T.RECORD(l, unique)}
                                else {exp=(), ty=T.INT})
                            | _ => 
                                (error pos (S.name(typ) ^ " is not record type");
                                {exp=(), ty=T.INT})))
                | SOME(_) => 
                    (error pos (S.name(typ) ^ " is not record type");
                    {exp=(), ty=T.INT})
            end

          | g (A.AppExp {func, args, pos}) =
            let
                val n = ref 1 
                fun checkFormals (nil, nil) = ()
                  | checkFormals (nil, (a::r)) = 
                    error pos "the length of formals and agrs doesn't match"
                  | checkFormals ((a::r), nil) = 
                    error pos "the length of formals and agrs doesn't match"
                  | checkFormals ((a1::r1), (a2::r2)) = 
                    let val {exp, ty} = g a2
                    in  checkTypeMatch(ty, a1, pos, ("Type mismatch in parameter\
                        \ " ^ Int.toString(!n)));
                        n := !n + 1;
                        checkFormals(r1, r2)
                    end
            in   case S.look(env, func) of NONE => 
                    (error pos ("Undefined identifier in function call. \
                                    \Assuming function returns INT.");
                    {exp=(), ty=T.INT})
                 | SOME(E.FUNentry {level, label, formals, result}) => 
                    (checkFormals(formals, args);
                    {exp=(), ty=result})
                 | SOME(_) =>
                     (error pos ("Identifier is not bound to a function. \
                                \Assuming function returns INT");
                     {exp=(), ty=T.INT})
            end
            
          | g (A.SeqExp []) = {exp=(), ty=T.UNIT}
          | g (A.SeqExp [(e, p)]) = g e
          | g (A.SeqExp ((e, p)::r)) = (g e; g(A.SeqExp r))

          | g (A.AssignExp {var, exp, pos}) = 
                let val {exp=e1, ty=t1} = h var
                    val {exp=e2, ty=t2} = g exp

                    fun getSymbol (A.SimpleVar(id, _)) = id
                      | getSymbol (A.FieldVar(v, _, _)) = getSymbol v
                      | getSymbol (A.SubscriptVar(v, _, _)) = getSymbol v
                    
                    fun checkAssignable v = 
                        (case S.look(env, getSymbol(v)) of 
                            SOME(E.VARentry {access, ty, assignable}) =>
                                if assignable=false then error pos
                                    "Attempt to assign to a FOR loop \
                                    \induction variable." 
                                else ()               
                        | _ => ())

                in checkTypeMatch(t1, t2, pos, "Type of rvalue in \
                    \assignment expression does not match lvalue.");
                   checkAssignable var; 
                   {exp=(), ty=T.UNIT}
                end 

          | g (A.IfExp {test, then', else', pos}) = 
                let 
                  fun checkType (then', NONE) = 
                        (checkUnit(g then', pos);T.UNIT)
                    | checkType (then', SOME(exp)) =
                        let val {exp=e1, ty=t1} = g then'
                            val {exp=e2, ty=t2} = g exp
                        in  (if checkTypeMatch(t1, t2, pos, 
                            "Type mismatch between THEN and ELSE clauses. \
                            \Assuming expression is an INT.") 
                            then t1 else T.INT) 
                        end
                in 
                    (checkInt(g test, pos);
                    {exp=(), ty=checkType (then', else')})
                end

          | g (A.WhileExp {test, body, pos}) = 
                (loopLevel := (hd(!loopLevel) + 1)::tl(!loopLevel);
                 checkInt (g test, pos);
                 checkUnit(g body, pos);
                 loopLevel := (hd(!loopLevel) - 1)::tl(!loopLevel);
                 {exp=(), ty=T.UNIT})
          
          | g (A.ForExp {var, lo, hi, body, pos}) = 
                let 
                    val id = #name var
                    val env' = S.enter(env, id, E.VARentry{access=(), ty=T.INT,
                                assignable=false} )
                in
                    (loopLevel := (hd(!loopLevel) + 1)::tl(!loopLevel);
                     checkInt (g lo, pos);
                     checkInt (g hi, pos);
                     checkUnit ((transexp (env', tenv) body), pos);
                     loopLevel := (hd(!loopLevel) - 1)::tl(!loopLevel);
                     {exp=(), ty=T.UNIT})
                end
          
          | g (A.BreakExp pos) = 
                (if hd(!loopLevel) > 0 then ()
                 else error pos "BREAK expression found outside of WHILE \
                                \or FOR loop.";
                 {exp=(), ty=T.UNIT})
          
          | g (A.LetExp {decs, body, pos}) = 
                let val (env', tenv') = transdecs (env, tenv, decs)
                in transexp (env', tenv') body end
          
          | g (A.ArrayExp {typ, size, init, pos}) = (*{exp=(), ty=T.UNIT} *)
                let val {exp, ty} = g init
                in  checkInt(g size, pos);
                    case S.look(tenv, typ) of NONE => 
                        (error pos ("Array type doesn't exist:" ^ S.name(typ));
                        {exp=(), ty=T.UNIT})
                   | SOME(T.NAME(name, tyRef)) => 
                        (case !tyRef of NONE => {exp=(), ty=T.UNIT}
                         | SOME(ty') => 
                             case actualTy({exp=(), ty=ty'}) of
                                T.ARRAY(t, unique) =>
                                    (if checkTypeMatch (t, ty, pos, ("Type of \
                                        \array initializer does not agree \
                                        \with array declaration."))
                                    then {exp=(), ty=T.ARRAY(t, unique)}
                                    else {exp=(), ty=T.INT})
                                | _ => 
                                    (error pos "type is not array type";
                                    {exp=(), ty=T.UNIT}))
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
                    (error pos ("Variable (" ^ S.name(id) ^ ") is of an unknown type, \
                    \or the variable has not been defined.");
                    {exp=(), ty=T.INT})
                | SOME(E.VARentry{access, ty, assignable}) => 
                    {exp=(), ty=ty}
                | SOME(_) =>
                    (error pos (S.name(id) ^ "is not simple var");
                    {exp=(), ty=T.INT}))

	  | h (A.FieldVar (v,id,pos)) =  
              let 
                  val ty = actualTy (h v)
                    (*find field type in field list*)
                  fun find_field_ty (nil, sym) = NONE
                    | find_field_ty ((s, t)::r, sym) = 
                        if s = sym then SOME(t)
                        else find_field_ty(r, sym)

              in case ty of T.RECORD(l, unique) =>
                        (case find_field_ty(l, id) of NONE => (
                                error pos ("Previous record doesn't contain field: " ^
                                             S.name(id));
                                {exp=(), ty=T.UNIT})
                        | SOME(ty) => {exp=(), ty=ty})
                    | _ => (error pos "Previous variable is not record";
                            {exp=(), ty=T.UNIT})
              end 

	  | h (A.SubscriptVar (v,expr,pos)) =
                let 
                    val ty = actualTy (h v)
                in case ty of T.ARRAY(t, unique) => 
                        (checkInt(g expr, pos);
                        {exp=(), ty=t})
                    | _ => (error pos "Previous variable is not array";
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
        val v = E.VARentry{access=(), ty=ty, assignable=true}
        val env' = S.enter(env, var_id, v)
    in 
        case typ 
          of NONE => 
            (if ty = T.NIL then error pos "Illegal assignment of NIL \
                    \to declaration of a variable of an unknown type."
             else  (); 
             (env', tenv))
          | SOME(s, p) => 
            let val t = S.look(tenv, s)
            in
              case t of NONE => 
                        (error pos "type doesn't exist"; 
                        (env, tenv)) 
                  | SOME(t') =>
                      let val v' = E.VARentry{access=(), ty=t', assignable=true}
                          val env' = S.enter(env, var_id, v') 
                      in (checkTypeMatch(t', ty, p, "The type specified and \
                      \the type of initial expression doesn't match");
                         (env', tenv))
                      end 
            end
    end  

    | transdec (env, tenv, A.FunctionDec(l))=
        let 
            fun transform_formals_ty (te, nil) = nil
              | transform_formals_ty (te, {var, typ, pos}::r) =
                    let val tyOption = S.look(te, typ)
                    in case tyOption of NONE => T.INT::(transform_formals_ty(te,r))
                        | SOME(ty) => ty::(transform_formals_ty(te,r))
                    end
            
            fun enter_params(e, nil, nil) = e
              | enter_params(e, nil, l) = e
              | enter_params(e, l, nil) = e
              | enter_params(e, (({var, typ, pos}:A.formals)::r1), ty::r2) = 
                    let val e' = S.enter(e, (#name var), E.VARentry{access=(), ty=ty,
                            assignable=true})
                    in enter_params(e', r1, r2) end

            fun getResultType NONE = T.UNIT
              | getResultType (SOME(sym, pos)) = 
                    case S.look(tenv, sym) of NONE => T.UNIT
                            | SOME(ty) => ty
            
            fun checkReturnType (result, exprTy, pos) = 
                    checkTypeMatch(getResultType result, exprTy, pos, "Result\
                        \ type of function body does not match \
                        \declared return type")

            fun duplicateDection (visited, nil) =()
            | duplicateDection (visited, {name, params, result, body, pos}::r) = 
                if List.exists (fn y => y = name) visited then
                    error pos ("Duplicate definition of " ^
                            S.name(name))
                else (duplicateDection(name::visited, r))

            fun parseLeft (env, tenv, nil) = env
              | parseLeft (env, tenv, {name, params, result, body, pos}::r) =
                    let val formals_ty = transform_formals_ty (tenv, params)
                        val funentry = E.FUNentry{level=(), label=(),
                            formals=formals_ty, result=getResultType(result)}
                        val env' = S.enter(env, name, funentry)
                    in parseLeft (env', tenv, r) end

            fun parseRight (env, tenv, nil) = env
              | parseRight (env, tenv, {name, params, result, body, pos}::r) = 
                    let val formals_ty = transform_formals_ty (tenv, params)
                        val env' = enter_params(env, params, formals_ty)
                        val {exp, ty} = transexp (env', tenv) body
                    in checkReturnType (result, ty, pos); 
                       parseRight(env, tenv, r)
                    end    

            val env' = parseLeft(env, tenv, l)
       in
            loopLevel := 0 :: !loopLevel;
            duplicateDection([], l);
            parseRight(env', tenv, l);
            loopLevel := tl(!loopLevel);
            (env', tenv) 
        end


    | transdec (env, tenv, A.TypeDec(l)) =
        let 
          fun parseLeft (env, tenv, nil) = tenv
            | parseLeft (env, tenv, ({name, ty, pos}::r)) = 
                let val tenv' = S.enter(tenv, name, T.NAME(name, ref NONE))
                in parseLeft (env, tenv', r) end 

          fun parseRight (env, tenv, nil) = ()
            | parseRight (env, tenv, ({name, ty, pos}::r)) = 
                let val (t, p) = transty(tenv, ty)
                    val T.NAME (id, tyRef) = valOf(S.look(tenv, name))
                in 
                    tyRef := SOME t;
                    parseRight (env, tenv, r)
                end

          fun duplicateDection (visited, nil) =()
            | duplicateDection (visited, {name, ty, pos}::r) = 
                if List.exists (fn y => y = name) visited then
                    error pos ("Duplicate definition of " ^
                            S.name(name))
                else (duplicateDection(name::visited, r))

          fun cycleDection (env, tenv, nil) = ()
            | cycleDection (env, tenv, ({name, ty, pos}::r)) = 
                let val ty = valOf(S.look(tenv, name))
                    fun helper (T.NAME(sym, tyRef), visited) = 
                            if List.exists (fn y => y = sym) visited then 
                                (tyRef := SOME(T.INT);
                                error pos "Primitive (non-array/record) cycle \
                                    \detected in recursive type definition;\ 
                                    \ Type forced to INT.")
                            else helper(valOf(!tyRef), sym::visited)
                      | helper (_, _) = ()

                in helper (ty, []) end 

          val tenv' = parseLeft (env, tenv, l)
        in duplicateDection([], l);
           parseRight (env, tenv', l);
           cycleDection(env, tenv', l);
           (env, tenv')
        end

  (*** transdecs : (E.env * E.tenv * A.dec list) -> (E.env * E.tenv) ***)
  and transdecs (env,tenv,nil) = (env, tenv)
    | transdecs (env,tenv,dec::decs) =
	let val (env',tenv') = transdec (env,tenv,dec)
 	 in transdecs (env',tenv',decs)
	end

  (*** transprog : A.exp -> {exp : ir_code, ty : T.ty} ***)
  fun transprog prog = transexp (E.base_env, E.base_tenv) prog

end  (* structure Semant *)
  

