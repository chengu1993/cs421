signature ENV =
sig
  type access
  type level
  type label
  type ty

  datatype enventry 
    = VARentry of {access: access, ty: ty}
    | FUNentry of {level: level, label: label, formals: ty list, result: ty}

  type tenv = ty Symbol.table
  type env = enventry Symbol.table

  val base_tenv : tenv
  val base_env : env
end

structure Env : ENV =
struct

  structure S = Symbol
  structure T = Types

  type access = unit   (* not used for the time being *)
  type level = unit    (* not used for the time being *)
  type label = unit    (* not used for the time being *)
  type ty = T.ty

  datatype enventry 
    = VARentry of {access: access, ty: ty}
    | FUNentry of {level: level, label: label, formals: ty list, result: ty}

  type tenv = ty Symbol.table

  type env = enventry Symbol.table

  (* here you need to add all primtive types into the base_tenv *)
  val base_tenv = 
    let 
        val temp_tenv = S.enter(S.empty, S.symbol("int"), T.INT);
        val temp_tenv = S.enter(temp_tenv, S.symbol("string"), T.STRING)
    in temp_tenv end
                
 
  (* here you need to add all primitive library functions into the base_env *)
  val base_env = 
    let
        val temp_env = S.enter(S.empty, S.symbol("print"), 
            FUNentry{level=(), label=(), formals=[T.STRING], result=T.UNIT});
        val temp_env = S.enter(temp_env, S.symbol("flush"),
            FUNentry{level=(), label=(), formals=[], result=T.UNIT});
        val temp_env = S.enter(temp_env, S.symbol("getchar"),
            FUNentry{level=(), label=(), formals=[], result=T.STRING});
        val temp_env = S.enter(temp_env, S.symbol("ord"), 
            FUNentry{level=(), label=(), formals=[T.STRING], result=T.INT});
        val temp_env = S.enter(temp_env, S.symbol("chr"),
            FUNentry{level=(), label=(), formals=[T.INT], result=T.STRING});
        val temp_env = S.enter(temp_env, S.symbol("size"),
            FUNentry{level=(), label=(), formals=[T.STRING], result=T.INT});
        val temp_env = S.enter(temp_env, S.symbol("substring"),
            FUNentry{level=(), label=(), formals=[T.STRING, T.INT, T.INT],
            result=T.STRING});
        val temp_env = S.enter(temp_env, S.symbol("concat"),
            FUNentry{level=(), label=(), formals=[T.STRING, T.STRING],
            result=T.STRING});
        val temp_env = S.enter(temp_env, S.symbol("not"),
            FUNentry{level=(), label=(), formals=[T.INT], result=T.INT});
        val temp_env = S.enter(temp_env, S.symbol("exit"),
            FUNentry{level=(), label=(), formals=[T.INT], result=T.UNIT})
    in temp_env end
end  (* structure Env *)
  
