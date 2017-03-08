structure Types =
struct

  type unique = unit ref

  datatype ty = 
            RECORD of (Symbol.symbol * ty) list * unique
          | NIL
          | INT
          | STRING
          | ARRAY of ty * unique
	  | NAME of Symbol.symbol * ty option ref
	  | UNIT



  fun printTy ty =
      case ty of
           RECORD(_, _) => print "type is record\n"
         | NIL => print "type is nil\n"
         | INT => print "type is int\n"
         | STRING => print "type is string\n"
         | ARRAY(arrTy, _) => (print "array: "; printTy arrTy)
         | NAME(sym, _) => print ("name type is " ^ Symbol.name sym ^ "\n")
         | UNIT => print "type is unit\n"
end

