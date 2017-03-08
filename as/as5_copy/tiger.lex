type svalue = Tokens.svalue
type pos = int
type ('a, 'b) token = ('a, 'b) Tokens.token
type lexresult = (svalue, pos) token

val commentLevel = ref 0
val inString = ref false
val str = ref ""
val strPos = ref 0
val lineNum = ErrorMsg.lineNum
val linePos = ErrorMsg.linePos
fun err(p1,p2) = ErrorMsg.error p1

val eof = fn () => 
	let 
		val pos = hd(!linePos) 
	in 
		if (!commentLevel <> 0) then
			ErrorMsg.error pos "unclosed comment"
		else if !inString then
			ErrorMsg.error pos "unclosed string"
		else ();
		ErrorMsg.reset();
		commentLevel := 0;
		inString := false;
		str := "";
		strPos := 0;
		Tokens.EOF(pos,pos)
end

fun translate (s : string, pos: int) = 
	let
		val temp = String.fromString s
	in
		if temp = NONE then
			(ErrorMsg.error pos "illegal escaped character";"")
		else valOf temp
	end



%%
%header (functor TigerLexFun(structure Tokens : Tiger_TOKENS));
%s COMMENT STRING MULTILINE;
alpha=[A-Za-z];
digit=[0-9];
ws=[ \t\012];
%%

<INITIAL, COMMENT>"/*"	=> (YYBEGIN COMMENT; commentLevel := !commentLevel + 1; continue());
<INITIAL>"*/"	=> (ErrorMsg.error yypos "unbalanced comment"; continue());
<COMMENT>"*/"	=> (commentLevel := !commentLevel - 1; if !commentLevel = 0 then YYBEGIN INITIAL else (); continue());
<COMMENT>.	=> (continue());

<INITIAL>\"	=> (YYBEGIN STRING; inString := true; str := ""; strPos := yypos; continue());
<STRING>\"	=> (YYBEGIN INITIAL; inString := false; Tokens.STRING(!str, !strPos, yypos));
<STRING>\\	=> (YYBEGIN MULTILINE; continue());
<STRING>\\[nt\"\\]	=> (str := !str ^ translate(yytext, yypos); continue());
<STRING>\\{digit}{3}	=> (str := !str ^ translate(yytext, yypos); continue());
<STRING>\\\^.	=> (str := !str ^ translate(yytext, yypos); continue());
<STRING>.		=> (str := !str ^ yytext; continue());
<STRING>\n	=> (ErrorMsg.error yypos "illegal newline in string"; lineNum := !lineNum+1; linePos := yypos :: !linePos; continue());
<MULTILINE>\\	=> (YYBEGIN STRING; continue());
<MULTILINE>({ws})+	=> (continue());
<MULTILINE>.	=> (ErrorMsg.error yypos ("illegal character " ^ yytext); continue());

<INITIAL, COMMENT, MULTILINE>\n	=> (lineNum := !lineNum+1; linePos := yypos :: !linePos; continue());
<INITIAL>{ws}*	=> (continue());
<INITIAL>type	=> (Tokens.TYPE(yypos, yypos+4));
<INITIAL>var  	=> (Tokens.VAR(yypos,yypos+3));
<INITIAL>function 	=> (Tokens.FUNCTION(yypos, yypos+8));
<INITIAL>break	=> (Tokens.BREAK(yypos, yypos+5));
<INITIAL>of		=> (Tokens.OF(yypos, yypos+2));
<INITIAL>end 	=> (Tokens.END(yypos, yypos+3));
<INITIAL>in 		=> (Tokens.IN(yypos, yypos+2));
<INITIAL>nil 	=> (Tokens.NIL(yypos, yypos+3));
<INITIAL>let 	=> (Tokens.LET(yypos, yypos+3));
<INITIAL>do		=> (Tokens.DO(yypos, yypos+2));
<INITIAL>to  	=> (Tokens.TO(yypos, yypos+2));
<INITIAL>for		=> (Tokens.FOR(yypos, yypos+3));
<INITIAL>while 	=> (Tokens.WHILE(yypos, yypos+5));
<INITIAL>else	=> (Tokens.ELSE(yypos, yypos+4));
<INITIAL>then	=> (Tokens.THEN(yypos, yypos+4));
<INITIAL>if		=> (Tokens.IF(yypos, yypos+2));
<INITIAL>array	=> (Tokens.ARRAY(yypos, yypos+5));
<INITIAL>":="		=> (Tokens.ASSIGN(yypos, yypos+2));
<INITIAL>"|"		=> (Tokens.OR(yypos, yypos+1));
<INITIAL>"&"		=> (Tokens.AND(yypos, yypos+1));
<INITIAL>">="		=> (Tokens.GE(yypos, yypos+2));
<INITIAL>">"		=> (Tokens.GT(yypos, yypos+1));
<INITIAL>"<=" 		=> (Tokens.LE(yypos, yypos+2));
<INITIAL>"<"		=> (Tokens.LT(yypos, yypos+1));
<INITIAL>"<>"		=> (Tokens.NEQ(yypos, yypos+2));
<INITIAL>"="		=> (Tokens.EQ(yypos, yypos+1));
<INITIAL>"/"		=> (Tokens.DIVIDE(yypos, yypos+1));
<INITIAL>"*"		=> (Tokens.TIMES(yypos, yypos+1));
<INITIAL>"-"		=> (Tokens.MINUS(yypos, yypos+1));
<INITIAL>"+"		=> (Tokens.PLUS(yypos, yypos+1));
<INITIAL>"}"		=> (Tokens.RBRACE(yypos, yypos+1));
<INITIAL>"."		=> (Tokens.DOT(yypos, yypos+1));
<INITIAL>"{"		=> (Tokens.LBRACE(yypos, yypos+1));
<INITIAL>"]"		=> (Tokens.RBRACK(yypos, yypos+1));
<INITIAL>"["		=> (Tokens.LBRACK(yypos, yypos+1));
<INITIAL>")"		=> (Tokens.RPAREN(yypos, yypos+1));
<INITIAL>"("		=> (Tokens.LPAREN(yypos, yypos+1));
<INITIAL>";"		=> (Tokens.SEMICOLON(yypos, yypos+1));
<INITIAL>":"		=> (Tokens.COLON(yypos, yypos+1));
<INITIAL>","	=> (Tokens.COMMA(yypos,yypos+1));
<INITIAL>{alpha}({alpha}|{digit}|_)*	=> (Tokens.ID(yytext, yypos, yypos + size(yytext)));
<INITIAL>{digit}+	=> (Tokens.INT(valOf(Int.fromString(yytext)),yypos,yypos+size(yytext)));
<INITIAL>.       => (ErrorMsg.error yypos ("illegal character " ^ yytext); continue());
