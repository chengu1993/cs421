(*assignment 1.1*)
type id = string

datatype binop = PLUS | MINUS | TIMES | DIV

datatype stm = SEQ of stm * stm
	     | ASSIGN of id * exp
	     | PRINT of exp list

     and exp = VAR of id
	     | CONST of int
             | BINOP of exp * binop * exp
             | ESEQ of stm * exp

val prog = 
SEQ(ASSIGN("a",BINOP(CONST 5, PLUS, CONST 3)),
 SEQ(ASSIGN("b",ESEQ(PRINT[VAR"a",BINOP(VAR"a",	MINUS,CONST 1)],
	             BINOP(CONST 10, TIMES, VAR"a"))),
  PRINT[VAR "b"]))

fun maxargs (SEQ(s1,s2)) = Int.max(maxargs(s1), maxargs(s2))
  | maxargs (ASSIGN(i,e)) = maxargsE(e)
  | maxargs (PRINT(l)) = Int.max(length(l), maxargsEL(l))

and maxargsE (ESEQ(s,e)) = Int.max(maxargs(s), maxargsE(e))
  | maxargsE (BINOP(e1, _, e2)) = Int.max(maxargsE(e1), maxargsE(e2))
  | maxargsE (_) = 0

and maxargsEL ([]) = 0
  | maxargsEL (e::t) = Int.max(maxargsE(e), maxargsEL(t))


(*assignment 1.2*)
type pair = id * int

type table = pair list

fun update(t:table, id, value) = ((id, value)::t)

exception KeyNotExist
fun lookup([], id) = raise KeyNotExist
  | lookup((a::r): table, id) = 
		if #1a = id then #2a
		else lookup(r, id)

fun interStm (SEQ(s1,s2), t:table) = interStm(s2, interStm(s1, t))
  | interStm (ASSIGN(i,e), t:table) = 
		let 
		  val (v, t1) = interExp(e, t)
		in
		  (i, v)::t1
		end
  | interStm (PRINT(l), t: table) = interExpL(l, t)

and interExp (VAR(i), t: table) = (lookup(t, i), t)
  | interExp (CONST(c), t: table) = (c, t)
  | interExp (BINOP(e1, oper, e2), t: table) = 
		let 
		  val (v1, t1) = interExp(e1, t);
		  val (v2, t2) = interExp(e2, t1)
		in
		  case oper 
			of PLUS => (v1 + v2, t2)
			| MINUS => (v1 - v2, t2)
			| TIMES => (v1 * v2, t2)
			| DIV => (v1 div v2, t2)
		end
  | interExp (ESEQ(s,e), t: table) = 
		let
		  val t1 = interStm(s, t)
		in
		  interExp(e, t1)
		end

and interExpL ([], t: table) = t
  | interExpL ([e], t: table) =
		let
		  val (v, t1) = interExp(e, t)
		in
		  (print(Int.toString(v) ^ "\n"); t1)
		end
  | interExpL (e::r, t: table) = 
		let
		  val (v, t1) = interExp(e, t)
		in
		  (print(Int.toString(v) ^ " "); interExpL(r, t1))
		end

fun interp (s: stm) = (interStm(s, nil); ())

