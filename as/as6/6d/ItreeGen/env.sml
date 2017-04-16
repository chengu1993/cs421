signature ENV = sig
  type access
  type level
  type label
  type ty
  datatype enventry
    = VARentry of {access: access, ty: ty, readonly: bool}
    | FUNentry of {level: level, label: label, formals: ty list, result: ty}
  type tenv = ty Symbol.table
  type env = enventry Symbol.table
  val base_tenv : tenv
  val base_env : env
end

functor EnvGen (Translate: TRANSLATE) : ENV = struct
  structure S = Symbol
  structure T = Types
  type access = Translate.access
  type level = Translate.level
  type label = Temp.label
  type ty = T.ty
  datatype enventry
    = VARentry of {access: access, ty: ty, readonly: bool}
    | FUNentry of {level: level, label: label, formals: ty list, result: ty}
  type tenv = ty Symbol.table
  type env = enventry Symbol.table
  fun enter ((name, binding), env) = S.enter (env, S.symbol name, binding)
  fun mkFn label formals result =
    let fun mkFml (name, ty) = T.NAME (S.symbol name, ref (SOME ty))
     in FUNentry {level = Translate.outermost, label = label,
                  formals = map mkFml formals, result = result}
    end
  val base_tenv = foldl enter S.empty [("int", T.INT), ("string", T.STRING)]
  val base_env = foldl enter S.empty
    [("print", mkFn (Temp.namedlabel "print") [("s", T.STRING)] T.UNIT),
     ("flush", mkFn (Temp.namedlabel "flush") [] T.UNIT),
     ("getchar", mkFn (Temp.namedlabel "getch") [] T.STRING),
     ("ord", mkFn (Temp.namedlabel "ord") [("s", T.STRING)] T.INT),
     ("chr", mkFn (Temp.namedlabel "chr") [("i", T.INT)] T.STRING),
     ("size", mkFn (Temp.namedlabel "size") [("s", T.STRING)] T.INT),
     ("substring", mkFn (Temp.namedlabel "substring")
                   [("s", T.STRING), ("first", T.INT), ("n", T.INT)] T.STRING),
     ("concat", mkFn (Temp.namedlabel "concat")
                [("s1", T.STRING), ("s2", T.STRING)] T.STRING),
     ("not", mkFn (Temp.namedlabel "not") [("i", T.INT)] T.INT),
     ("exit", mkFn (Temp.namedlabel "exit") [("i", T.INT)] T.INT)]
end
