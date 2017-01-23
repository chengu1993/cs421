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
 SEQ(ASSIGN("b",ESEQ(PRINT[VAR"a",BINOP(VAR"a",MINUS,CONST 1)],
	             BINOP(CONST 10, TIMES, VAR"a"))),
  PRINT[VAR "b"]))

fun length ([]) = 0
  | length (a::r) = 1 + length(r)

fun maxargs (SEQ(s1,s2)) = Int.max(maxargs(s1), maxargs(s2))
  | maxargs (ASSIGN(i,e)) = maxargsE(e)
  | maxargs (PRINT l) = Int.max(length(l), maxargsEL(l))

and maxargsE (BINOP(_,_,_)) = 0
  | maxargsE (ESEQ(s,e)) = Int.max(maxargs(s), maxargsE(e))
  | maxargsE (_) = 0

and maxargsEL ([]) = 0
  | maxargsEL (a::r) = Int.max(maxargsE(a), maxargsEL(r))
