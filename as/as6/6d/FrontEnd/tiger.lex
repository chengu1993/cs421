type svalue = Tokens.svalue
type pos = int
type ('a, 'b) token = ('a, 'b) Tokens.token
type lexresult = (svalue, pos) token
val lineNum = ErrorMsg.lineNum
val linePos = ErrorMsg.linePos
fun err pos msg = ErrorMsg.error pos msg
fun newline yypos = (lineNum := !lineNum + 1; linePos := yypos :: !linePos)
val cmts = ref (nil : int list) (* stack of open comment starting positions *)
fun toInt str = valOf (Int.fromString str)
val curStr = ref ""
val strStart = ref ~1
fun append str = curStr := !curStr ^ str
fun fmtCtrl c = (str o chr) (ord c - ord #"@")
fun fmtAsc ddd = (str o chr o toInt) ddd
fun eof () =
  (if !strStart >= 0 then err (!strStart) "unclosed string" else ();
   app (fn n => err n "unclosed comment") (rev (!cmts));
   cmts := nil;
   curStr := "";
   strStart := ~1;
   let val pos = hd (!linePos) in Tokens.EOF (pos, pos) end)

%%

%header (functor TigerLexFun (structure Tokens : Tiger_TOKENS));
%s COMMENT STRING;
formFeed = \012;
carriageReturn = \013;
id = [a-zA-Z][a-zA-Z0-9_]*;
ignore = \\([ \n\t\b]|{formFeed}{carriageReturn})+\\;
newline = \n|{formFeed};
spacing = [ \t]|{carriageReturn};
ddd = [0-1][0-9][0-9]|2[0-4][0-9]|25[0-5];

%%

<INITIAL,
 COMMENT> {newline} => (newline yypos; continue ());
<STRING>  {newline} => (err yypos ("unescaped line break in string");
                        newline yypos; continue ());
<INITIAL,
 COMMENT> {spacing} => (continue ());
<INITIAL> \"        => (YYBEGIN STRING;
                        strStart := yypos;
                        curStr := "";
                        continue ());
<STRING>  \"        => (YYBEGIN INITIAL;
                        Tokens.STRING(!curStr, !strStart, yypos + 1)
                        before strStart := ~1);
<STRING>  [ -~]     => (append yytext; continue ());
<STRING>  \\n       => (append (str #"\n"); continue ());
<STRING>  \\t       => (append (str #"\t"); continue ());
<STRING>  \\{ddd}   => (append (fmtAsc (substring (yytext, 1, 3))); continue ());
<STRING>  \\\"      => (append (str #"\""); continue ());
<STRING>  \\\\      => (append (str #"\\"); continue ());
<STRING>  {ignore}  => (app (fn #"\n" => newline yypos
                              | #"\f" => newline yypos
                              | _ => ())
                            (explode yytext);
                        continue ());
<STRING>  \\\^[@-_] => (append (fmtCtrl (String.sub (yytext, 2))); continue ());
<INITIAL,
 COMMENT> "/*"      => (cmts := yypos :: !cmts; YYBEGIN COMMENT; continue ());
<COMMENT> "*/"      => (case !cmts
                          of nil => err yypos "unmatched close comment"
                           | [c] => (cmts := tl (!cmts); YYBEGIN INITIAL)
                           | _ => cmts := tl (!cmts);
                        continue ());
<COMMENT> [!-~]     => (continue ());
<INITIAL> type      => (Tokens.TYPE (yypos, yypos + 4));
<INITIAL> var       => (Tokens.VAR (yypos, yypos + 3));
<INITIAL> function  => (Tokens.FUNCTION (yypos, yypos + 8));
<INITIAL> break     => (Tokens.BREAK (yypos, yypos + 5));
<INITIAL> of        => (Tokens.OF (yypos, yypos + 2));
<INITIAL> end       => (Tokens.END (yypos, yypos + 3));
<INITIAL> in        => (Tokens.IN (yypos, yypos + 2));
<INITIAL> nil       => (Tokens.NIL (yypos, yypos + 3));
<INITIAL> let       => (Tokens.LET (yypos, yypos + 3));
<INITIAL> do        => (Tokens.DO (yypos, yypos + 2));
<INITIAL> to        => (Tokens.TO (yypos, yypos + 2));
<INITIAL> for       => (Tokens.FOR (yypos, yypos + 3));
<INITIAL> while     => (Tokens.WHILE (yypos, yypos + 5));
<INITIAL> else      => (Tokens.ELSE (yypos, yypos + 4));
<INITIAL> then      => (Tokens.THEN (yypos, yypos + 4));
<INITIAL> if        => (Tokens.IF (yypos, yypos + 2));
<INITIAL> array     => (Tokens.ARRAY (yypos, yypos + 5));
<INITIAL> ":="      => (Tokens.ASSIGN (yypos, yypos + 2));
<INITIAL> "|"       => (Tokens.OR (yypos, yypos + 1));
<INITIAL> "&"       => (Tokens.AND (yypos, yypos + 1));
<INITIAL> ">="      => (Tokens.GE (yypos, yypos + 2));
<INITIAL> ">"       => (Tokens.GT (yypos, yypos + 1));
<INITIAL> "<="      => (Tokens.LE (yypos, yypos + 2));
<INITIAL> "<"       => (Tokens.LT (yypos, yypos + 1));
<INITIAL> "<>"      => (Tokens.NEQ (yypos, yypos + 2));
<INITIAL> "="       => (Tokens.EQ (yypos, yypos + 1));
<INITIAL> "/"       => (Tokens.DIVIDE (yypos, yypos + 1));
<INITIAL> "*"       => (Tokens.TIMES (yypos, yypos + 1));
<INITIAL> "-"       => (Tokens.MINUS (yypos, yypos + 1));
<INITIAL> "+"       => (Tokens.PLUS (yypos, yypos + 1));
<INITIAL> "."       => (Tokens.DOT (yypos, yypos + 1));
<INITIAL> "}"       => (Tokens.RBRACE (yypos, yypos + 1));
<INITIAL> "{"       => (Tokens.LBRACE (yypos, yypos + 1));
<INITIAL> "]"       => (Tokens.RBRACK (yypos, yypos + 1));
<INITIAL> "["       => (Tokens.LBRACK (yypos, yypos + 1));
<INITIAL> ")"       => (Tokens.RPAREN (yypos, yypos + 1));
<INITIAL> "("       => (Tokens.LPAREN (yypos, yypos + 1));
<INITIAL> ";"       => (Tokens.SEMICOLON (yypos, yypos + 1));
<INITIAL> ":"       => (Tokens.COLON (yypos, yypos + 1));
<INITIAL> ","       => (Tokens.COMMA (yypos, yypos + 1));
<INITIAL> [0-9]+    => (Tokens.INT (toInt yytext, yypos, yypos + size yytext));
<INITIAL> {id}      => (Tokens.ID (yytext, yypos, yypos + size yytext));
.                   => (err yypos ("illegal character: " ^ yytext);
                        continue ());
