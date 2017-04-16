functor TigerLrValsFun(structure Token : TOKEN)
 : sig structure ParserData : PARSER_DATA
       structure Tokens : Tiger_TOKENS
   end
 = 
struct
structure ParserData=
struct
structure Header = 
struct
structure A = Absyn
val sym = Symbol.symbol

fun mkFnApp i a p = A.AppExp {func = sym i, args = a, pos = p}
fun mkOp l e r p = A.OpExp {left = l, oper = e, right = r, pos = p}
fun mkAs v e p = A.AssignExp {var = v, exp = e, pos = p}
fun mkIf i t e p = A.IfExp {test = i, then' = t, else' = e, pos = p}
fun mkRec f t p = A.RecordExp {fields = f, typ = sym t, pos = p}
fun mkFnD n m r b p = {name = sym n, params = m, result = r, body = b, pos = p}
fun mkV n = {name = sym n, escape = ref true}
fun mkVDec v t e p = A.VarDec {var = mkV v, typ = t, init = e, pos = p}
fun mkWhile t b p = A.WhileExp {test = t, body = b, pos = p}
fun mkFor i l h b p = A.ForExp {var = mkV i, lo = l, hi = h, body = b, pos = p}
fun mkLet d b p = A.LetExp {decs = d, body = b, pos = p}
fun mkAr t n i p = A.ArrayExp {typ = sym t, size = n, init = i, pos = p}
fun mkFml n t p = {var = mkV n, typ = sym t, pos = p}


end
structure LrTable = Token.LrTable
structure Token = Token
local open LrTable in 
val table=let val actionRows =
"\
\\001\000\001\000\162\000\002\000\162\000\003\000\162\000\006\000\162\000\
\\007\000\162\000\010\000\162\000\011\000\162\000\014\000\162\000\
\\015\000\162\000\019\000\162\000\020\000\162\000\027\000\022\000\
\\028\000\021\000\029\000\020\000\030\000\019\000\032\000\162\000\
\\034\000\162\000\036\000\162\000\038\000\162\000\040\000\162\000\
\\044\000\162\000\000\000\
\\001\000\001\000\163\000\002\000\163\000\003\000\163\000\006\000\163\000\
\\007\000\163\000\010\000\163\000\011\000\163\000\014\000\163\000\
\\015\000\163\000\019\000\163\000\020\000\163\000\027\000\022\000\
\\028\000\021\000\029\000\020\000\030\000\019\000\032\000\163\000\
\\034\000\163\000\036\000\163\000\038\000\163\000\040\000\163\000\
\\044\000\163\000\000\000\
\\001\000\001\000\164\000\002\000\164\000\003\000\164\000\006\000\164\000\
\\007\000\164\000\010\000\164\000\011\000\164\000\014\000\164\000\
\\015\000\164\000\019\000\164\000\020\000\164\000\027\000\022\000\
\\028\000\021\000\029\000\020\000\030\000\019\000\032\000\164\000\
\\034\000\164\000\036\000\164\000\038\000\164\000\040\000\164\000\
\\044\000\164\000\000\000\
\\001\000\001\000\165\000\002\000\165\000\003\000\165\000\006\000\165\000\
\\007\000\165\000\010\000\165\000\011\000\165\000\014\000\165\000\
\\015\000\165\000\019\000\165\000\020\000\165\000\027\000\022\000\
\\028\000\021\000\029\000\020\000\030\000\019\000\032\000\165\000\
\\034\000\165\000\036\000\165\000\038\000\165\000\040\000\165\000\
\\044\000\165\000\000\000\
\\001\000\001\000\166\000\002\000\166\000\003\000\166\000\006\000\166\000\
\\007\000\166\000\010\000\166\000\011\000\166\000\014\000\166\000\
\\015\000\166\000\019\000\166\000\020\000\166\000\027\000\022\000\
\\028\000\021\000\029\000\020\000\030\000\019\000\032\000\166\000\
\\034\000\166\000\036\000\166\000\038\000\166\000\040\000\166\000\
\\044\000\166\000\000\000\
\\001\000\001\000\167\000\002\000\167\000\003\000\167\000\006\000\167\000\
\\007\000\167\000\010\000\167\000\011\000\167\000\014\000\167\000\
\\015\000\167\000\019\000\167\000\020\000\167\000\027\000\022\000\
\\028\000\021\000\029\000\020\000\030\000\019\000\032\000\167\000\
\\034\000\167\000\036\000\167\000\038\000\167\000\040\000\167\000\
\\044\000\167\000\000\000\
\\001\000\004\000\015\000\008\000\014\000\009\000\013\000\012\000\012\000\
\\013\000\011\000\016\000\010\000\029\000\009\000\036\000\035\000\
\\037\000\008\000\041\000\007\000\042\000\006\000\043\000\005\000\000\000\
\\001\000\004\000\015\000\008\000\014\000\009\000\013\000\012\000\012\000\
\\013\000\011\000\016\000\010\000\029\000\009\000\036\000\065\000\
\\037\000\008\000\041\000\007\000\042\000\006\000\043\000\005\000\000\000\
\\001\000\004\000\015\000\008\000\014\000\009\000\013\000\012\000\012\000\
\\013\000\011\000\016\000\010\000\029\000\009\000\037\000\008\000\
\\041\000\007\000\042\000\006\000\043\000\005\000\000\000\
\\001\000\005\000\132\000\000\000\
\\001\000\006\000\106\000\000\000\
\\001\000\007\000\077\000\000\000\
\\001\000\010\000\073\000\019\000\030\000\020\000\029\000\021\000\028\000\
\\022\000\027\000\023\000\026\000\024\000\025\000\025\000\024\000\
\\026\000\023\000\027\000\022\000\028\000\021\000\029\000\020\000\
\\030\000\019\000\000\000\
\\001\000\010\000\134\000\019\000\030\000\020\000\029\000\021\000\028\000\
\\022\000\027\000\023\000\026\000\024\000\025\000\025\000\024\000\
\\026\000\023\000\027\000\022\000\028\000\021\000\029\000\020\000\
\\030\000\019\000\000\000\
\\001\000\011\000\105\000\019\000\030\000\020\000\029\000\021\000\028\000\
\\022\000\027\000\023\000\026\000\024\000\025\000\025\000\024\000\
\\026\000\023\000\027\000\022\000\028\000\021\000\029\000\020\000\
\\030\000\019\000\000\000\
\\001\000\015\000\072\000\019\000\030\000\020\000\029\000\021\000\028\000\
\\022\000\027\000\023\000\026\000\024\000\025\000\025\000\024\000\
\\026\000\023\000\027\000\022\000\028\000\021\000\029\000\020\000\
\\030\000\019\000\000\000\
\\001\000\017\000\117\000\033\000\116\000\043\000\115\000\000\000\
\\001\000\018\000\074\000\000\000\
\\001\000\018\000\097\000\039\000\096\000\000\000\
\\001\000\018\000\127\000\000\000\
\\001\000\019\000\030\000\020\000\029\000\021\000\028\000\022\000\027\000\
\\023\000\026\000\024\000\025\000\025\000\024\000\026\000\023\000\
\\027\000\022\000\028\000\021\000\029\000\020\000\030\000\019\000\
\\034\000\081\000\000\000\
\\001\000\019\000\030\000\020\000\029\000\021\000\028\000\022\000\027\000\
\\023\000\026\000\024\000\025\000\025\000\024\000\026\000\023\000\
\\027\000\022\000\028\000\021\000\029\000\020\000\030\000\019\000\
\\034\000\084\000\000\000\
\\001\000\019\000\030\000\020\000\029\000\021\000\028\000\022\000\027\000\
\\023\000\026\000\024\000\025\000\025\000\024\000\026\000\023\000\
\\027\000\022\000\028\000\021\000\029\000\020\000\030\000\019\000\
\\036\000\071\000\038\000\070\000\000\000\
\\001\000\026\000\086\000\000\000\
\\001\000\026\000\098\000\000\000\
\\001\000\026\000\123\000\000\000\
\\001\000\032\000\069\000\043\000\068\000\000\000\
\\001\000\032\000\085\000\000\000\
\\001\000\032\000\131\000\043\000\130\000\000\000\
\\001\000\032\000\144\000\000\000\
\\001\000\036\000\082\000\000\000\
\\001\000\036\000\102\000\000\000\
\\001\000\036\000\111\000\043\000\110\000\000\000\
\\001\000\036\000\125\000\000\000\
\\001\000\037\000\095\000\000\000\
\\001\000\039\000\126\000\000\000\
\\001\000\039\000\140\000\000\000\
\\001\000\043\000\039\000\000\000\
\\001\000\043\000\049\000\000\000\
\\001\000\043\000\068\000\000\000\
\\001\000\043\000\078\000\000\000\
\\001\000\043\000\079\000\000\000\
\\001\000\043\000\080\000\000\000\
\\001\000\043\000\110\000\000\000\
\\001\000\043\000\112\000\000\000\
\\001\000\043\000\124\000\000\000\
\\001\000\043\000\130\000\000\000\
\\001\000\043\000\136\000\000\000\
\\001\000\043\000\141\000\000\000\
\\001\000\043\000\146\000\000\000\
\\001\000\044\000\000\000\000\000\
\\150\000\019\000\030\000\020\000\029\000\021\000\028\000\022\000\027\000\
\\023\000\026\000\024\000\025\000\025\000\024\000\026\000\023\000\
\\027\000\022\000\028\000\021\000\029\000\020\000\030\000\019\000\000\000\
\\151\000\018\000\018\000\031\000\017\000\035\000\016\000\000\000\
\\152\000\000\000\
\\153\000\000\000\
\\154\000\000\000\
\\155\000\000\000\
\\156\000\000\000\
\\157\000\000\000\
\\158\000\000\000\
\\159\000\027\000\022\000\028\000\021\000\000\000\
\\160\000\027\000\022\000\028\000\021\000\000\000\
\\161\000\000\000\
\\168\000\021\000\028\000\022\000\027\000\023\000\026\000\024\000\025\000\
\\025\000\024\000\026\000\023\000\027\000\022\000\028\000\021\000\
\\029\000\020\000\030\000\019\000\000\000\
\\169\000\020\000\029\000\021\000\028\000\022\000\027\000\023\000\026\000\
\\024\000\025\000\025\000\024\000\026\000\023\000\027\000\022\000\
\\028\000\021\000\029\000\020\000\030\000\019\000\000\000\
\\170\000\000\000\
\\171\000\000\000\
\\172\000\000\000\
\\173\000\000\000\
\\174\000\000\000\
\\175\000\019\000\030\000\020\000\029\000\021\000\028\000\022\000\027\000\
\\023\000\026\000\024\000\025\000\025\000\024\000\026\000\023\000\
\\027\000\022\000\028\000\021\000\029\000\020\000\030\000\019\000\000\000\
\\176\000\014\000\104\000\019\000\030\000\020\000\029\000\021\000\028\000\
\\022\000\027\000\023\000\026\000\024\000\025\000\025\000\024\000\
\\026\000\023\000\027\000\022\000\028\000\021\000\029\000\020\000\
\\030\000\019\000\000\000\
\\177\000\019\000\030\000\020\000\029\000\021\000\028\000\022\000\027\000\
\\023\000\026\000\024\000\025\000\025\000\024\000\026\000\023\000\
\\027\000\022\000\028\000\021\000\029\000\020\000\030\000\019\000\000\000\
\\178\000\019\000\030\000\020\000\029\000\021\000\028\000\022\000\027\000\
\\023\000\026\000\024\000\025\000\025\000\024\000\026\000\023\000\
\\027\000\022\000\028\000\021\000\029\000\020\000\030\000\019\000\000\000\
\\179\000\019\000\030\000\020\000\029\000\021\000\028\000\022\000\027\000\
\\023\000\026\000\024\000\025\000\025\000\024\000\026\000\023\000\
\\027\000\022\000\028\000\021\000\029\000\020\000\030\000\019\000\000\000\
\\180\000\000\000\
\\181\000\000\000\
\\182\000\019\000\030\000\020\000\029\000\021\000\028\000\022\000\027\000\
\\023\000\026\000\024\000\025\000\025\000\024\000\026\000\023\000\
\\027\000\022\000\028\000\021\000\029\000\020\000\030\000\019\000\000\000\
\\183\000\019\000\030\000\020\000\029\000\021\000\028\000\022\000\027\000\
\\023\000\026\000\024\000\025\000\025\000\024\000\026\000\023\000\
\\027\000\022\000\028\000\021\000\029\000\020\000\030\000\019\000\
\\040\000\083\000\000\000\
\\184\000\000\000\
\\185\000\033\000\033\000\035\000\032\000\037\000\031\000\000\000\
\\186\000\000\000\
\\187\000\000\000\
\\188\000\005\000\100\000\000\000\
\\189\000\000\000\
\\190\000\019\000\030\000\020\000\029\000\021\000\028\000\022\000\027\000\
\\023\000\026\000\024\000\025\000\025\000\024\000\026\000\023\000\
\\027\000\022\000\028\000\021\000\029\000\020\000\030\000\019\000\
\\040\000\119\000\000\000\
\\191\000\000\000\
\\192\000\004\000\015\000\008\000\014\000\009\000\013\000\012\000\012\000\
\\013\000\011\000\016\000\010\000\029\000\009\000\037\000\008\000\
\\041\000\007\000\042\000\006\000\043\000\005\000\000\000\
\\193\000\000\000\
\\194\000\019\000\030\000\020\000\029\000\021\000\028\000\022\000\027\000\
\\023\000\026\000\024\000\025\000\025\000\024\000\026\000\023\000\
\\027\000\022\000\028\000\021\000\029\000\020\000\030\000\019\000\
\\038\000\103\000\000\000\
\\195\000\000\000\
\\196\000\001\000\047\000\002\000\046\000\003\000\045\000\000\000\
\\197\000\000\000\
\\198\000\019\000\030\000\020\000\029\000\021\000\028\000\022\000\027\000\
\\023\000\026\000\024\000\025\000\025\000\024\000\026\000\023\000\
\\027\000\022\000\028\000\021\000\029\000\020\000\030\000\019\000\000\000\
\\199\000\019\000\030\000\020\000\029\000\021\000\028\000\022\000\027\000\
\\023\000\026\000\024\000\025\000\025\000\024\000\026\000\023\000\
\\027\000\022\000\028\000\021\000\029\000\020\000\030\000\019\000\000\000\
\\200\000\000\000\
\\201\000\001\000\047\000\000\000\
\\202\000\000\000\
\\203\000\000\000\
\\204\000\000\000\
\\205\000\000\000\
\\206\000\000\000\
\\207\000\000\000\
\\208\000\040\000\139\000\000\000\
\\209\000\000\000\
\\210\000\003\000\045\000\000\000\
\\211\000\000\000\
\\212\000\019\000\030\000\020\000\029\000\021\000\028\000\022\000\027\000\
\\023\000\026\000\024\000\025\000\025\000\024\000\026\000\023\000\
\\027\000\022\000\028\000\021\000\029\000\020\000\030\000\019\000\000\000\
\\213\000\039\000\108\000\000\000\
\\214\000\000\000\
\\215\000\000\000\
\\216\000\000\000\
\\217\000\040\000\143\000\000\000\
\\218\000\000\000\
\"
val actionRowNumbers =
"\008\000\052\000\051\000\080\000\
\\054\000\055\000\006\000\008\000\
\\008\000\008\000\037\000\091\000\
\\053\000\075\000\008\000\038\000\
\\008\000\008\000\008\000\008\000\
\\008\000\008\000\008\000\008\000\
\\008\000\008\000\008\000\008\000\
\\008\000\007\000\008\000\026\000\
\\022\000\067\000\062\000\015\000\
\\012\000\017\000\092\000\105\000\
\\095\000\091\000\011\000\040\000\
\\041\000\042\000\020\000\081\000\
\\070\000\060\000\061\000\059\000\
\\058\000\000\000\001\000\005\000\
\\004\000\003\000\002\000\063\000\
\\064\000\030\000\078\000\056\000\
\\021\000\027\000\023\000\065\000\
\\008\000\068\000\008\000\008\000\
\\008\000\106\000\090\000\087\000\
\\034\000\018\000\024\000\082\000\
\\057\000\008\000\083\000\066\000\
\\008\000\031\000\089\000\071\000\
\\073\000\014\000\086\000\010\000\
\\108\000\032\000\044\000\008\000\
\\016\000\079\000\008\000\085\000\
\\069\000\008\000\008\000\008\000\
\\076\000\025\000\045\000\033\000\
\\035\000\110\000\019\000\093\000\
\\096\000\098\000\028\000\009\000\
\\077\000\039\000\088\000\072\000\
\\013\000\008\000\109\000\111\000\
\\047\000\008\000\097\000\103\000\
\\036\000\099\000\048\000\084\000\
\\008\000\107\000\112\000\094\000\
\\029\000\046\000\049\000\101\000\
\\074\000\043\000\100\000\103\000\
\\102\000\113\000\104\000\050\000"
val gotoT =
"\
\\001\000\147\000\002\000\002\000\003\000\001\000\000\000\
\\000\000\
\\000\000\
\\000\000\
\\000\000\
\\000\000\
\\002\000\032\000\003\000\001\000\000\000\
\\002\000\034\000\003\000\001\000\000\000\
\\002\000\035\000\003\000\001\000\000\000\
\\002\000\036\000\003\000\001\000\000\000\
\\000\000\
\\006\000\042\000\007\000\041\000\012\000\040\000\013\000\039\000\
\\018\000\038\000\000\000\
\\000\000\
\\000\000\
\\002\000\046\000\003\000\001\000\000\000\
\\000\000\
\\002\000\048\000\003\000\001\000\000\000\
\\002\000\049\000\003\000\001\000\000\000\
\\002\000\050\000\003\000\001\000\000\000\
\\002\000\051\000\003\000\001\000\000\000\
\\002\000\052\000\003\000\001\000\000\000\
\\002\000\053\000\003\000\001\000\000\000\
\\002\000\054\000\003\000\001\000\000\000\
\\002\000\055\000\003\000\001\000\000\000\
\\002\000\056\000\003\000\001\000\000\000\
\\002\000\057\000\003\000\001\000\000\000\
\\002\000\058\000\003\000\001\000\000\000\
\\002\000\059\000\003\000\001\000\000\000\
\\002\000\060\000\003\000\001\000\000\000\
\\002\000\062\000\003\000\001\000\004\000\061\000\000\000\
\\002\000\064\000\003\000\001\000\000\000\
\\005\000\065\000\000\000\
\\000\000\
\\000\000\
\\000\000\
\\000\000\
\\000\000\
\\000\000\
\\000\000\
\\012\000\073\000\013\000\039\000\000\000\
\\000\000\
\\006\000\074\000\007\000\041\000\012\000\040\000\013\000\039\000\
\\018\000\038\000\000\000\
\\000\000\
\\000\000\
\\000\000\
\\000\000\
\\000\000\
\\000\000\
\\000\000\
\\000\000\
\\000\000\
\\000\000\
\\000\000\
\\000\000\
\\000\000\
\\000\000\
\\000\000\
\\000\000\
\\000\000\
\\000\000\
\\000\000\
\\000\000\
\\000\000\
\\000\000\
\\000\000\
\\000\000\
\\000\000\
\\000\000\
\\002\000\086\000\003\000\001\000\009\000\085\000\000\000\
\\000\000\
\\002\000\087\000\003\000\001\000\000\000\
\\002\000\088\000\003\000\001\000\000\000\
\\002\000\089\000\003\000\001\000\000\000\
\\000\000\
\\000\000\
\\002\000\086\000\003\000\001\000\008\000\091\000\009\000\090\000\000\000\
\\014\000\092\000\000\000\
\\000\000\
\\000\000\
\\000\000\
\\000\000\
\\002\000\062\000\003\000\001\000\004\000\097\000\000\000\
\\000\000\
\\000\000\
\\002\000\099\000\003\000\001\000\000\000\
\\000\000\
\\000\000\
\\000\000\
\\000\000\
\\000\000\
\\000\000\
\\000\000\
\\016\000\105\000\000\000\
\\015\000\107\000\000\000\
\\000\000\
\\002\000\111\000\003\000\001\000\000\000\
\\017\000\112\000\000\000\
\\000\000\
\\002\000\116\000\003\000\001\000\000\000\
\\000\000\
\\000\000\
\\002\000\086\000\003\000\001\000\009\000\118\000\000\000\
\\002\000\119\000\003\000\001\000\000\000\
\\002\000\120\000\003\000\001\000\000\000\
\\000\000\
\\000\000\
\\000\000\
\\000\000\
\\000\000\
\\000\000\
\\000\000\
\\000\000\
\\018\000\126\000\000\000\
\\000\000\
\\010\000\127\000\000\000\
\\000\000\
\\000\000\
\\005\000\131\000\000\000\
\\000\000\
\\000\000\
\\000\000\
\\002\000\133\000\003\000\001\000\000\000\
\\000\000\
\\000\000\
\\000\000\
\\002\000\135\000\003\000\001\000\000\000\
\\000\000\
\\011\000\136\000\000\000\
\\000\000\
\\000\000\
\\000\000\
\\000\000\
\\002\000\140\000\003\000\001\000\000\000\
\\000\000\
\\000\000\
\\000\000\
\\000\000\
\\010\000\143\000\000\000\
\\000\000\
\\000\000\
\\000\000\
\\015\000\145\000\000\000\
\\000\000\
\\011\000\146\000\000\000\
\\000\000\
\\000\000\
\\000\000\
\\000\000\
\"
val numstates = 148
val numrules = 69
val s = ref "" and index = ref 0
val string_to_int = fn () => 
let val i = !index
in index := i+2; Char.ord(String.sub(!s,i)) + Char.ord(String.sub(!s,i+1)) * 256
end
val string_to_list = fn s' =>
    let val len = String.size s'
        fun f () =
           if !index < len then string_to_int() :: f()
           else nil
   in index := 0; s := s'; f ()
   end
val string_to_pairlist = fn (conv_key,conv_entry) =>
     let fun f () =
         case string_to_int()
         of 0 => EMPTY
          | n => PAIR(conv_key (n-1),conv_entry (string_to_int()),f())
     in f
     end
val string_to_pairlist_default = fn (conv_key,conv_entry) =>
    let val conv_row = string_to_pairlist(conv_key,conv_entry)
    in fn () =>
       let val default = conv_entry(string_to_int())
           val row = conv_row()
       in (row,default)
       end
   end
val string_to_table = fn (convert_row,s') =>
    let val len = String.size s'
        fun f ()=
           if !index < len then convert_row() :: f()
           else nil
     in (s := s'; index := 0; f ())
     end
local
  val memo = Array.array(numstates+numrules,ERROR)
  val _ =let fun g i=(Array.update(memo,i,REDUCE(i-numstates)); g(i+1))
       fun f i =
            if i=numstates then g i
            else (Array.update(memo,i,SHIFT (STATE i)); f (i+1))
          in f 0 handle General.Subscript => ()
          end
in
val entry_to_action = fn 0 => ACCEPT | 1 => ERROR | j => Array.sub(memo,(j-2))
end
val gotoT=Array.fromList(string_to_table(string_to_pairlist(NT,STATE),gotoT))
val actionRows=string_to_table(string_to_pairlist_default(T,entry_to_action),actionRows)
val actionRowNumbers = string_to_list actionRowNumbers
val actionT = let val actionRowLookUp=
let val a=Array.fromList(actionRows) in fn i=>Array.sub(a,i) end
in Array.fromList(List.map actionRowLookUp actionRowNumbers)
end
in LrTable.mkLrTable {actions=actionT,gotos=gotoT,numRules=numrules,
numStates=numstates,initialState=STATE 0}
end
end
local open Header in
type pos = int
type arg = unit
structure MlyValue = 
struct
datatype svalue = VOID | ntVOID of unit ->  unit
 | ID of unit ->  (string) | INT of unit ->  (int)
 | STRING of unit ->  (string)
 | tydecs of unit ->  ({ name:A.symbol,ty:A.ty,pos:A.pos }  list)
 | ty of unit ->  (A.ty)
 | funres of unit ->  ( ( A.symbol * A.pos )  option)
 | fmls of unit ->  (A.formals list)
 | fml of unit ->  (A.formals list) | fundec of unit ->  (A.fundec)
 | fundecs of unit ->  (A.fundec list)
 | tfields of unit ->  (A.tfield list) | tfield of unit ->  (A.tfield)
 | seqe of unit ->  ( ( A.exp * A.pos )  list)
 | seqes of unit ->  (A.exp) | dec of unit ->  (A.dec)
 | decs of unit ->  (A.dec list) | efields of unit ->  (A.efield list)
 | args of unit ->  (A.exp list) | lvalue of unit ->  (A.var)
 | e of unit ->  (A.exp) | prog of unit ->  (A.exp)
end
type svalue = MlyValue.svalue
type result = A.exp
end
structure EC=
struct
open LrTable
infix 5 $$
fun x $$ y = y::x
val is_keyword =
fn (T 12) => true | (T 11) => true | (T 10) => true | (T 3) => true | 
(T 8) => true | (T 6) => true | (T 5) => true | (T 2) => true | (T 1)
 => true | (T 0) => true | (T 16) => true | (T 15) => true | (T 14)
 => true | (T 13) => true | (T 9) => true | (T 4) => true | (T 7)
 => true | _ => false
val preferred_change : (term list * term list) list = 
(nil
,nil
 $$ (T 14))::
(nil
,nil
 $$ (T 13))::
(nil
,nil
 $$ (T 36))::
nil
val noShift = 
fn (T 43) => true | _ => false
val showTerminal =
fn (T 0) => "TYPE"
  | (T 1) => "VAR"
  | (T 2) => "FUNCTION"
  | (T 3) => "BREAK"
  | (T 4) => "OF"
  | (T 5) => "END"
  | (T 6) => "IN"
  | (T 7) => "NIL"
  | (T 8) => "LET"
  | (T 9) => "DO"
  | (T 10) => "TO"
  | (T 11) => "FOR"
  | (T 12) => "WHILE"
  | (T 13) => "ELSE"
  | (T 14) => "THEN"
  | (T 15) => "IF"
  | (T 16) => "ARRAY"
  | (T 17) => "ASSIGN"
  | (T 18) => "OR"
  | (T 19) => "AND"
  | (T 20) => "GE"
  | (T 21) => "GT"
  | (T 22) => "LE"
  | (T 23) => "LT"
  | (T 24) => "NEQ"
  | (T 25) => "EQ"
  | (T 26) => "DIVIDE"
  | (T 27) => "TIMES"
  | (T 28) => "MINUS"
  | (T 29) => "PLUS"
  | (T 30) => "DOT"
  | (T 31) => "RBRACE"
  | (T 32) => "LBRACE"
  | (T 33) => "RBRACK"
  | (T 34) => "LBRACK"
  | (T 35) => "RPAREN"
  | (T 36) => "LPAREN"
  | (T 37) => "SEMICOLON"
  | (T 38) => "COLON"
  | (T 39) => "COMMA"
  | (T 40) => "STRING"
  | (T 41) => "INT"
  | (T 42) => "ID"
  | (T 43) => "EOF"
  | (T 44) => "UMINUS"
  | (T 45) => "IDX"
  | (T 46) => "TYX"
  | (T 47) => "FUNX"
  | _ => "bogus-term"
local open Header in
val errtermvalue=
fn (T 42) => MlyValue.ID(fn () => ("bogus")) | 
(T 41) => MlyValue.INT(fn () => (1)) | 
(T 40) => MlyValue.STRING(fn () => ("")) | 
_ => MlyValue.VOID
end
val terms : term list = nil
 $$ (T 47) $$ (T 46) $$ (T 45) $$ (T 44) $$ (T 43) $$ (T 39) $$ (T 38)
 $$ (T 37) $$ (T 36) $$ (T 35) $$ (T 34) $$ (T 33) $$ (T 32) $$ (T 31)
 $$ (T 30) $$ (T 29) $$ (T 28) $$ (T 27) $$ (T 26) $$ (T 25) $$ (T 24)
 $$ (T 23) $$ (T 22) $$ (T 21) $$ (T 20) $$ (T 19) $$ (T 18) $$ (T 17)
 $$ (T 16) $$ (T 15) $$ (T 14) $$ (T 13) $$ (T 12) $$ (T 11) $$ (T 10)
 $$ (T 9) $$ (T 8) $$ (T 7) $$ (T 6) $$ (T 5) $$ (T 4) $$ (T 3) $$ (T 
2) $$ (T 1) $$ (T 0)end
structure Actions =
struct 
exception mlyAction of int
local open Header in
val actions = 
fn (i392,defaultPos,stack,
    (()):arg) =>
case (i392,stack)
of  ( 0, ( ( _, ( MlyValue.e e1, e1left, e1right)) :: rest671)) => let
 val  result = MlyValue.prog (fn _ => let val  (e as e1) = e1 ()
 in (e)
end)
 in ( LrTable.NT 0, ( result, e1left, e1right), rest671)
end
|  ( 1, ( ( _, ( MlyValue.lvalue lvalue1, lvalue1left, lvalue1right))
 :: rest671)) => let val  result = MlyValue.e (fn _ => let val  (
lvalue as lvalue1) = lvalue1 ()
 in (A.VarExp lvalue)
end)
 in ( LrTable.NT 1, ( result, lvalue1left, lvalue1right), rest671)
end
|  ( 2, ( ( _, ( _, NIL1left, NIL1right)) :: rest671)) => let val  
result = MlyValue.e (fn _ => (A.NilExp))
 in ( LrTable.NT 1, ( result, NIL1left, NIL1right), rest671)
end
|  ( 3, ( ( _, ( MlyValue.INT INT1, INT1left, INT1right)) :: rest671))
 => let val  result = MlyValue.e (fn _ => let val  (INT as INT1) = 
INT1 ()
 in (A.IntExp INT)
end)
 in ( LrTable.NT 1, ( result, INT1left, INT1right), rest671)
end
|  ( 4, ( ( _, ( MlyValue.STRING STRING1, (STRINGleft as STRING1left),
 STRING1right)) :: rest671)) => let val  result = MlyValue.e (fn _ =>
 let val  (STRING as STRING1) = STRING1 ()
 in (A.StringExp (STRING, STRINGleft))
end)
 in ( LrTable.NT 1, ( result, STRING1left, STRING1right), rest671)
end
|  ( 5, ( ( _, ( _, _, RPAREN1right)) :: _ :: ( _, ( MlyValue.ID ID1,
 (IDleft as ID1left), _)) :: rest671)) => let val  result = MlyValue.e
 (fn _ => let val  (ID as ID1) = ID1 ()
 in (mkFnApp ID nil IDleft)
end)
 in ( LrTable.NT 1, ( result, ID1left, RPAREN1right), rest671)
end
|  ( 6, ( ( _, ( _, _, RPAREN1right)) :: ( _, ( MlyValue.args args1, _
, _)) :: _ :: ( _, ( MlyValue.ID ID1, (IDleft as ID1left), _)) :: 
rest671)) => let val  result = MlyValue.e (fn _ => let val  (ID as ID1
) = ID1 ()
 val  (args as args1) = args1 ()
 in (mkFnApp ID args IDleft)
end)
 in ( LrTable.NT 1, ( result, ID1left, RPAREN1right), rest671)
end
|  ( 7, ( ( _, ( MlyValue.e e2, _, e2right)) :: ( _, ( _, DIVIDEleft,
 _)) :: ( _, ( MlyValue.e e1, e1left, _)) :: rest671)) => let val  
result = MlyValue.e (fn _ => let val  e1 = e1 ()
 val  e2 = e2 ()
 in (mkOp e1 A.DivideOp e2 DIVIDEleft)
end)
 in ( LrTable.NT 1, ( result, e1left, e2right), rest671)
end
|  ( 8, ( ( _, ( MlyValue.e e2, _, e2right)) :: ( _, ( _, TIMESleft, _
)) :: ( _, ( MlyValue.e e1, e1left, _)) :: rest671)) => let val  
result = MlyValue.e (fn _ => let val  e1 = e1 ()
 val  e2 = e2 ()
 in (mkOp e1 A.TimesOp e2 TIMESleft)
end)
 in ( LrTable.NT 1, ( result, e1left, e2right), rest671)
end
|  ( 9, ( ( _, ( MlyValue.e e2, _, e2right)) :: ( _, ( _, PLUSleft, _)
) :: ( _, ( MlyValue.e e1, e1left, _)) :: rest671)) => let val  result
 = MlyValue.e (fn _ => let val  e1 = e1 ()
 val  e2 = e2 ()
 in (mkOp e1 A.PlusOp e2 PLUSleft)
end)
 in ( LrTable.NT 1, ( result, e1left, e2right), rest671)
end
|  ( 10, ( ( _, ( MlyValue.e e2, _, e2right)) :: ( _, ( _, MINUSleft,
 _)) :: ( _, ( MlyValue.e e1, e1left, _)) :: rest671)) => let val  
result = MlyValue.e (fn _ => let val  e1 = e1 ()
 val  e2 = e2 ()
 in (mkOp e1 A.MinusOp e2 MINUSleft)
end)
 in ( LrTable.NT 1, ( result, e1left, e2right), rest671)
end
|  ( 11, ( ( _, ( MlyValue.e e1, _, e1right)) :: ( _, ( _, (MINUSleft
 as MINUS1left), _)) :: rest671)) => let val  result = MlyValue.e (fn
 _ => let val  (e as e1) = e1 ()
 in (mkOp (A.IntExp 0) A.MinusOp e MINUSleft)
end)
 in ( LrTable.NT 1, ( result, MINUS1left, e1right), rest671)
end
|  ( 12, ( ( _, ( MlyValue.e e2, _, e2right)) :: ( _, ( _, EQleft, _))
 :: ( _, ( MlyValue.e e1, e1left, _)) :: rest671)) => let val  result
 = MlyValue.e (fn _ => let val  e1 = e1 ()
 val  e2 = e2 ()
 in (mkOp e1 A.EqOp e2 EQleft)
end)
 in ( LrTable.NT 1, ( result, e1left, e2right), rest671)
end
|  ( 13, ( ( _, ( MlyValue.e e2, _, e2right)) :: ( _, ( _, NEQleft, _)
) :: ( _, ( MlyValue.e e1, e1left, _)) :: rest671)) => let val  result
 = MlyValue.e (fn _ => let val  e1 = e1 ()
 val  e2 = e2 ()
 in (mkOp e1 A.NeqOp e2 NEQleft)
end)
 in ( LrTable.NT 1, ( result, e1left, e2right), rest671)
end
|  ( 14, ( ( _, ( MlyValue.e e2, _, e2right)) :: ( _, ( _, GEleft, _))
 :: ( _, ( MlyValue.e e1, e1left, _)) :: rest671)) => let val  result
 = MlyValue.e (fn _ => let val  e1 = e1 ()
 val  e2 = e2 ()
 in (mkOp e1 A.GeOp e2 GEleft)
end)
 in ( LrTable.NT 1, ( result, e1left, e2right), rest671)
end
|  ( 15, ( ( _, ( MlyValue.e e2, _, e2right)) :: ( _, ( _, GTleft, _))
 :: ( _, ( MlyValue.e e1, e1left, _)) :: rest671)) => let val  result
 = MlyValue.e (fn _ => let val  e1 = e1 ()
 val  e2 = e2 ()
 in (mkOp e1 A.GtOp e2 GTleft)
end)
 in ( LrTable.NT 1, ( result, e1left, e2right), rest671)
end
|  ( 16, ( ( _, ( MlyValue.e e2, _, e2right)) :: ( _, ( _, LEleft, _))
 :: ( _, ( MlyValue.e e1, e1left, _)) :: rest671)) => let val  result
 = MlyValue.e (fn _ => let val  e1 = e1 ()
 val  e2 = e2 ()
 in (mkOp e1 A.LeOp e2 LEleft)
end)
 in ( LrTable.NT 1, ( result, e1left, e2right), rest671)
end
|  ( 17, ( ( _, ( MlyValue.e e2, _, e2right)) :: ( _, ( _, LTleft, _))
 :: ( _, ( MlyValue.e e1, e1left, _)) :: rest671)) => let val  result
 = MlyValue.e (fn _ => let val  e1 = e1 ()
 val  e2 = e2 ()
 in (mkOp e1 A.LtOp e2 LTleft)
end)
 in ( LrTable.NT 1, ( result, e1left, e2right), rest671)
end
|  ( 18, ( ( _, ( MlyValue.e e2, _, e2right)) :: ( _, ( _, ANDleft, _)
) :: ( _, ( MlyValue.e e1, e1left, _)) :: rest671)) => let val  result
 = MlyValue.e (fn _ => let val  e1 = e1 ()
 val  e2 = e2 ()
 in (mkIf e1 e2 (SOME (A.IntExp 0)) ANDleft)
end)
 in ( LrTable.NT 1, ( result, e1left, e2right), rest671)
end
|  ( 19, ( ( _, ( MlyValue.e e2, _, e2right)) :: ( _, ( _, ORleft, _))
 :: ( _, ( MlyValue.e e1, e1left, _)) :: rest671)) => let val  result
 = MlyValue.e (fn _ => let val  e1 = e1 ()
 val  e2 = e2 ()
 in (mkIf e1 (A.IntExp 1) (SOME e2) ORleft)
end)
 in ( LrTable.NT 1, ( result, e1left, e2right), rest671)
end
|  ( 20, ( ( _, ( _, _, RBRACE1right)) :: _ :: ( _, ( MlyValue.ID ID1,
 (IDleft as ID1left), _)) :: rest671)) => let val  result = MlyValue.e
 (fn _ => let val  (ID as ID1) = ID1 ()
 in (mkRec nil ID IDleft)
end)
 in ( LrTable.NT 1, ( result, ID1left, RBRACE1right), rest671)
end
|  ( 21, ( ( _, ( _, _, RBRACE1right)) :: ( _, ( MlyValue.efields 
efields1, _, _)) :: _ :: ( _, ( MlyValue.ID ID1, (IDleft as ID1left),
 _)) :: rest671)) => let val  result = MlyValue.e (fn _ => let val  (
ID as ID1) = ID1 ()
 val  (efields as efields1) = efields1 ()
 in (mkRec efields ID IDleft)
end)
 in ( LrTable.NT 1, ( result, ID1left, RBRACE1right), rest671)
end
|  ( 22, ( ( _, ( _, _, RPAREN1right)) :: ( _, ( _, LPAREN1left, _))
 :: rest671)) => let val  result = MlyValue.e (fn _ => (A.SeqExp nil))
 in ( LrTable.NT 1, ( result, LPAREN1left, RPAREN1right), rest671)
end
|  ( 23, ( ( _, ( _, _, RPAREN1right)) :: ( _, ( MlyValue.e e1, _, _))
 :: ( _, ( _, LPAREN1left, _)) :: rest671)) => let val  result = 
MlyValue.e (fn _ => let val  (e as e1) = e1 ()
 in (e)
end)
 in ( LrTable.NT 1, ( result, LPAREN1left, RPAREN1right), rest671)
end
|  ( 24, ( ( _, ( _, _, RPAREN1right)) :: ( _, ( MlyValue.seqe seqe1,
 _, _)) :: _ :: ( _, ( MlyValue.e e1, eleft, _)) :: ( _, ( _, 
LPAREN1left, _)) :: rest671)) => let val  result = MlyValue.e (fn _ =>
 let val  (e as e1) = e1 ()
 val  (seqe as seqe1) = seqe1 ()
 in (A.SeqExp ((e, eleft) :: seqe))
end)
 in ( LrTable.NT 1, ( result, LPAREN1left, RPAREN1right), rest671)
end
|  ( 25, ( ( _, ( MlyValue.e e1, _, e1right)) :: ( _, ( _, ASSIGNleft,
 _)) :: ( _, ( MlyValue.lvalue lvalue1, lvalue1left, _)) :: rest671))
 => let val  result = MlyValue.e (fn _ => let val  (lvalue as lvalue1)
 = lvalue1 ()
 val  (e as e1) = e1 ()
 in (mkAs lvalue e ASSIGNleft)
end)
 in ( LrTable.NT 1, ( result, lvalue1left, e1right), rest671)
end
|  ( 26, ( ( _, ( MlyValue.e e2, _, e2right)) :: _ :: ( _, ( 
MlyValue.e e1, _, _)) :: ( _, ( _, (IFleft as IF1left), _)) :: rest671
)) => let val  result = MlyValue.e (fn _ => let val  e1 = e1 ()
 val  e2 = e2 ()
 in (mkIf e1 e2 NONE IFleft)
end)
 in ( LrTable.NT 1, ( result, IF1left, e2right), rest671)
end
|  ( 27, ( ( _, ( MlyValue.e e3, _, e3right)) :: _ :: ( _, ( 
MlyValue.e e2, _, _)) :: _ :: ( _, ( MlyValue.e e1, _, _)) :: ( _, ( _
, (IFleft as IF1left), _)) :: rest671)) => let val  result = 
MlyValue.e (fn _ => let val  e1 = e1 ()
 val  e2 = e2 ()
 val  e3 = e3 ()
 in (mkIf e1 e2 (SOME e3) IFleft)
end)
 in ( LrTable.NT 1, ( result, IF1left, e3right), rest671)
end
|  ( 28, ( ( _, ( MlyValue.e e2, _, e2right)) :: _ :: ( _, ( 
MlyValue.e e1, _, _)) :: ( _, ( _, (WHILEleft as WHILE1left), _)) :: 
rest671)) => let val  result = MlyValue.e (fn _ => let val  e1 = e1 ()
 val  e2 = e2 ()
 in (mkWhile e1 e2 WHILEleft)
end)
 in ( LrTable.NT 1, ( result, WHILE1left, e2right), rest671)
end
|  ( 29, ( ( _, ( MlyValue.e e3, _, e3right)) :: _ :: ( _, ( 
MlyValue.e e2, _, _)) :: _ :: ( _, ( MlyValue.e e1, _, _)) :: _ :: ( _
, ( MlyValue.ID ID1, _, _)) :: ( _, ( _, (FORleft as FOR1left), _)) ::
 rest671)) => let val  result = MlyValue.e (fn _ => let val  (ID as 
ID1) = ID1 ()
 val  e1 = e1 ()
 val  e2 = e2 ()
 val  e3 = e3 ()
 in (mkFor ID e1 e2 e3 FORleft)
end)
 in ( LrTable.NT 1, ( result, FOR1left, e3right), rest671)
end
|  ( 30, ( ( _, ( _, (BREAKleft as BREAK1left), BREAK1right)) :: 
rest671)) => let val  result = MlyValue.e (fn _ => (
A.BreakExp BREAKleft))
 in ( LrTable.NT 1, ( result, BREAK1left, BREAK1right), rest671)
end
|  ( 31, ( ( _, ( _, _, END1right)) :: ( _, ( MlyValue.seqes seqes1, _
, _)) :: _ :: ( _, ( MlyValue.decs decs1, _, _)) :: ( _, ( _, (LETleft
 as LET1left), _)) :: rest671)) => let val  result = MlyValue.e (fn _
 => let val  (decs as decs1) = decs1 ()
 val  (seqes as seqes1) = seqes1 ()
 in (mkLet decs seqes LETleft)
end)
 in ( LrTable.NT 1, ( result, LET1left, END1right), rest671)
end
|  ( 32, ( ( _, ( MlyValue.e e2, _, e2right)) :: _ :: _ :: ( _, ( 
MlyValue.e e1, _, _)) :: _ :: ( _, ( MlyValue.ID ID1, (IDleft as 
ID1left), _)) :: rest671)) => let val  result = MlyValue.e (fn _ =>
 let val  (ID as ID1) = ID1 ()
 val  e1 = e1 ()
 val  e2 = e2 ()
 in (mkAr ID e1 e2 IDleft)
end)
 in ( LrTable.NT 1, ( result, ID1left, e2right), rest671)
end
|  ( 33, ( ( _, ( MlyValue.e e1, e1left, e1right)) :: rest671)) => let
 val  result = MlyValue.args (fn _ => let val  (e as e1) = e1 ()
 in (e :: nil)
end)
 in ( LrTable.NT 3, ( result, e1left, e1right), rest671)
end
|  ( 34, ( ( _, ( MlyValue.args args1, _, args1right)) :: _ :: ( _, ( 
MlyValue.e e1, e1left, _)) :: rest671)) => let val  result = 
MlyValue.args (fn _ => let val  (e as e1) = e1 ()
 val  (args as args1) = args1 ()
 in (e :: args)
end)
 in ( LrTable.NT 3, ( result, e1left, args1right), rest671)
end
|  ( 35, ( ( _, ( MlyValue.ID ID1, (IDleft as ID1left), ID1right)) :: 
rest671)) => let val  result = MlyValue.lvalue (fn _ => let val  (ID
 as ID1) = ID1 ()
 in (A.SimpleVar (sym ID, IDleft))
end)
 in ( LrTable.NT 2, ( result, ID1left, ID1right), rest671)
end
|  ( 36, ( ( _, ( MlyValue.ID ID1, _, ID1right)) :: ( _, ( _, DOTleft,
 _)) :: ( _, ( MlyValue.lvalue lvalue1, lvalue1left, _)) :: rest671))
 => let val  result = MlyValue.lvalue (fn _ => let val  (lvalue as 
lvalue1) = lvalue1 ()
 val  (ID as ID1) = ID1 ()
 in (A.FieldVar (lvalue, sym ID, DOTleft))
end)
 in ( LrTable.NT 2, ( result, lvalue1left, ID1right), rest671)
end
|  ( 37, ( ( _, ( _, _, RBRACK1right)) :: ( _, ( MlyValue.e e1, _, _))
 :: ( _, ( _, LBRACKleft, _)) :: ( _, ( MlyValue.lvalue lvalue1, 
lvalue1left, _)) :: rest671)) => let val  result = MlyValue.lvalue (fn
 _ => let val  (lvalue as lvalue1) = lvalue1 ()
 val  (e as e1) = e1 ()
 in (A.SubscriptVar (lvalue, e, LBRACKleft))
end)
 in ( LrTable.NT 2, ( result, lvalue1left, RBRACK1right), rest671)
end
|  ( 38, ( ( _, ( _, _, RBRACK1right)) :: ( _, ( MlyValue.e e1, _, _))
 :: ( _, ( _, LBRACKleft, _)) :: ( _, ( MlyValue.ID ID1, (IDleft as 
ID1left), _)) :: rest671)) => let val  result = MlyValue.lvalue (fn _
 => let val  (ID as ID1) = ID1 ()
 val  (e as e1) = e1 ()
 in (
A.SubscriptVar (A.SimpleVar (sym ID, IDleft),
                                                 e, LBRACKleft)
)
end)
 in ( LrTable.NT 2, ( result, ID1left, RBRACK1right), rest671)
end
|  ( 39, ( ( _, ( MlyValue.efields efields1, _, efields1right)) :: _
 :: ( _, ( MlyValue.e e1, _, _)) :: _ :: ( _, ( MlyValue.ID ID1, (
IDleft as ID1left), _)) :: rest671)) => let val  result = 
MlyValue.efields (fn _ => let val  (ID as ID1) = ID1 ()
 val  (e as e1) = e1 ()
 val  (efields as efields1) = efields1 ()
 in ((sym ID, e, IDleft) :: efields)
end)
 in ( LrTable.NT 4, ( result, ID1left, efields1right), rest671)
end
|  ( 40, ( ( _, ( MlyValue.e e1, _, e1right)) :: _ :: ( _, ( 
MlyValue.ID ID1, (IDleft as ID1left), _)) :: rest671)) => let val  
result = MlyValue.efields (fn _ => let val  (ID as ID1) = ID1 ()
 val  (e as e1) = e1 ()
 in ((sym ID, e, IDleft) :: nil)
end)
 in ( LrTable.NT 4, ( result, ID1left, e1right), rest671)
end
|  ( 41, ( ( _, ( MlyValue.seqe seqe1, seqe1left, seqe1right)) :: 
rest671)) => let val  result = MlyValue.seqes (fn _ => let val  (seqe
 as seqe1) = seqe1 ()
 in (A.SeqExp seqe)
end)
 in ( LrTable.NT 7, ( result, seqe1left, seqe1right), rest671)
end
|  ( 42, ( rest671)) => let val  result = MlyValue.seqes (fn _ => (
A.SeqExp nil))
 in ( LrTable.NT 7, ( result, defaultPos, defaultPos), rest671)
end
|  ( 43, ( ( _, ( MlyValue.seqe seqe1, _, seqe1right)) :: _ :: ( _, ( 
MlyValue.e e1, (eleft as e1left), _)) :: rest671)) => let val  result
 = MlyValue.seqe (fn _ => let val  (e as e1) = e1 ()
 val  (seqe as seqe1) = seqe1 ()
 in ((e, eleft) :: seqe)
end)
 in ( LrTable.NT 8, ( result, e1left, seqe1right), rest671)
end
|  ( 44, ( ( _, ( MlyValue.e e1, (eleft as e1left), e1right)) :: 
rest671)) => let val  result = MlyValue.seqe (fn _ => let val  (e as 
e1) = e1 ()
 in ((e, eleft) :: nil)
end)
 in ( LrTable.NT 8, ( result, e1left, e1right), rest671)
end
|  ( 45, ( ( _, ( MlyValue.decs decs1, _, decs1right)) :: ( _, ( 
MlyValue.dec dec1, dec1left, _)) :: rest671)) => let val  result = 
MlyValue.decs (fn _ => let val  (dec as dec1) = dec1 ()
 val  (decs as decs1) = decs1 ()
 in (dec :: decs)
end)
 in ( LrTable.NT 5, ( result, dec1left, decs1right), rest671)
end
|  ( 46, ( rest671)) => let val  result = MlyValue.decs (fn _ => (nil)
)
 in ( LrTable.NT 5, ( result, defaultPos, defaultPos), rest671)
end
|  ( 47, ( ( _, ( MlyValue.tydecs tydecs1, tydecs1left, tydecs1right))
 :: rest671)) => let val  result = MlyValue.dec (fn _ => let val  (
tydecs as tydecs1) = tydecs1 ()
 in (A.TypeDec tydecs)
end)
 in ( LrTable.NT 6, ( result, tydecs1left, tydecs1right), rest671)
end
|  ( 48, ( ( _, ( MlyValue.e e1, _, e1right)) :: _ :: ( _, ( 
MlyValue.ID ID1, _, _)) :: ( _, ( _, (VARleft as VAR1left), _)) :: 
rest671)) => let val  result = MlyValue.dec (fn _ => let val  (ID as 
ID1) = ID1 ()
 val  (e as e1) = e1 ()
 in (mkVDec ID NONE e VARleft)
end)
 in ( LrTable.NT 6, ( result, VAR1left, e1right), rest671)
end
|  ( 49, ( ( _, ( MlyValue.e e1, _, e1right)) :: _ :: ( _, ( 
MlyValue.ID ID2, ID2left, _)) :: _ :: ( _, ( MlyValue.ID ID1, _, _))
 :: ( _, ( _, (VARleft as VAR1left), _)) :: rest671)) => let val  
result = MlyValue.dec (fn _ => let val  ID1 = ID1 ()
 val  ID2 = ID2 ()
 val  (e as e1) = e1 ()
 in (mkVDec ID1 (SOME (sym ID2, ID2left)) e VARleft)
end)
 in ( LrTable.NT 6, ( result, VAR1left, e1right), rest671)
end
|  ( 50, ( ( _, ( MlyValue.fundecs fundecs1, fundecs1left, 
fundecs1right)) :: rest671)) => let val  result = MlyValue.dec (fn _
 => let val  (fundecs as fundecs1) = fundecs1 ()
 in (A.FunctionDec fundecs)
end)
 in ( LrTable.NT 6, ( result, fundecs1left, fundecs1right), rest671)

end
|  ( 51, ( ( _, ( MlyValue.ty ty1, _, ty1right)) :: _ :: ( _, ( 
MlyValue.ID ID1, _, _)) :: ( _, ( _, (TYPEleft as TYPE1left), _)) :: 
rest671)) => let val  result = MlyValue.tydecs (fn _ => let val  (ID
 as ID1) = ID1 ()
 val  (ty as ty1) = ty1 ()
 in ({name = sym ID, ty = ty, pos = TYPEleft} :: nil)
end)
 in ( LrTable.NT 17, ( result, TYPE1left, ty1right), rest671)
end
|  ( 52, ( ( _, ( MlyValue.tydecs tydecs1, _, tydecs1right)) :: ( _, (
 MlyValue.ty ty1, _, _)) :: _ :: ( _, ( MlyValue.ID ID1, _, _)) :: ( _
, ( _, (TYPEleft as TYPE1left), _)) :: rest671)) => let val  result = 
MlyValue.tydecs (fn _ => let val  (ID as ID1) = ID1 ()
 val  (ty as ty1) = ty1 ()
 val  (tydecs as tydecs1) = tydecs1 ()
 in ({name = sym ID, ty = ty, pos = TYPEleft} :: tydecs)
end)
 in ( LrTable.NT 17, ( result, TYPE1left, tydecs1right), rest671)
end
|  ( 53, ( ( _, ( MlyValue.ID ID1, (IDleft as ID1left), ID1right)) :: 
rest671)) => let val  result = MlyValue.ty (fn _ => let val  (ID as 
ID1) = ID1 ()
 in (A.NameTy (sym ID, IDleft))
end)
 in ( LrTable.NT 16, ( result, ID1left, ID1right), rest671)
end
|  ( 54, ( ( _, ( _, _, RBRACE1right)) :: ( _, ( _, LBRACE1left, _))
 :: rest671)) => let val  result = MlyValue.ty (fn _ => (
A.RecordTy nil))
 in ( LrTable.NT 16, ( result, LBRACE1left, RBRACE1right), rest671)

end
|  ( 55, ( ( _, ( _, _, RBRACE1right)) :: ( _, ( MlyValue.tfields 
tfields1, _, _)) :: ( _, ( MlyValue.tfield tfield1, _, _)) :: ( _, ( _
, LBRACE1left, _)) :: rest671)) => let val  result = MlyValue.ty (fn _
 => let val  (tfield as tfield1) = tfield1 ()
 val  (tfields as tfields1) = tfields1 ()
 in (A.RecordTy (tfield :: tfields))
end)
 in ( LrTable.NT 16, ( result, LBRACE1left, RBRACE1right), rest671)

end
|  ( 56, ( ( _, ( MlyValue.ID ID1, _, ID1right)) :: _ :: ( _, ( _, (
ARRAYleft as ARRAY1left), _)) :: rest671)) => let val  result = 
MlyValue.ty (fn _ => let val  (ID as ID1) = ID1 ()
 in (A.ArrayTy (sym ID, ARRAYleft))
end)
 in ( LrTable.NT 16, ( result, ARRAY1left, ID1right), rest671)
end
|  ( 57, ( ( _, ( MlyValue.ID ID2, _, ID2right)) :: _ :: ( _, ( 
MlyValue.ID ID1, ID1left, _)) :: rest671)) => let val  result = 
MlyValue.tfield (fn _ => let val  ID1 = ID1 ()
 val  ID2 = ID2 ()
 in ({name = sym ID1, typ = sym ID2, pos = ID1left})
end)
 in ( LrTable.NT 9, ( result, ID1left, ID2right), rest671)
end
|  ( 58, ( rest671)) => let val  result = MlyValue.tfields (fn _ => (
nil))
 in ( LrTable.NT 10, ( result, defaultPos, defaultPos), rest671)
end
|  ( 59, ( ( _, ( MlyValue.tfields tfields1, _, tfields1right)) :: ( _
, ( MlyValue.tfield tfield1, _, _)) :: ( _, ( _, COMMA1left, _)) :: 
rest671)) => let val  result = MlyValue.tfields (fn _ => let val  (
tfield as tfield1) = tfield1 ()
 val  (tfields as tfields1) = tfields1 ()
 in (tfield :: tfields)
end)
 in ( LrTable.NT 10, ( result, COMMA1left, tfields1right), rest671)

end
|  ( 60, ( ( _, ( MlyValue.fundec fundec1, fundec1left, fundec1right))
 :: rest671)) => let val  result = MlyValue.fundecs (fn _ => let val 
 (fundec as fundec1) = fundec1 ()
 in (fundec :: nil)
end)
 in ( LrTable.NT 11, ( result, fundec1left, fundec1right), rest671)

end
|  ( 61, ( ( _, ( MlyValue.fundecs fundecs1, _, fundecs1right)) :: ( _
, ( MlyValue.fundec fundec1, fundec1left, _)) :: rest671)) => let val 
 result = MlyValue.fundecs (fn _ => let val  (fundec as fundec1) = 
fundec1 ()
 val  (fundecs as fundecs1) = fundecs1 ()
 in (fundec :: fundecs)
end)
 in ( LrTable.NT 11, ( result, fundec1left, fundecs1right), rest671)

end
|  ( 62, ( ( _, ( MlyValue.e e1, _, e1right)) :: _ :: ( _, ( 
MlyValue.funres funres1, _, _)) :: ( _, ( MlyValue.fml fml1, _, _)) ::
 ( _, ( MlyValue.ID ID1, _, _)) :: ( _, ( _, (FUNCTIONleft as 
FUNCTION1left), _)) :: rest671)) => let val  result = MlyValue.fundec
 (fn _ => let val  (ID as ID1) = ID1 ()
 val  (fml as fml1) = fml1 ()
 val  (funres as funres1) = funres1 ()
 val  (e as e1) = e1 ()
 in (mkFnD ID fml funres e FUNCTIONleft)
end)
 in ( LrTable.NT 12, ( result, FUNCTION1left, e1right), rest671)
end
|  ( 63, ( rest671)) => let val  result = MlyValue.funres (fn _ => (
NONE))
 in ( LrTable.NT 15, ( result, defaultPos, defaultPos), rest671)
end
|  ( 64, ( ( _, ( MlyValue.ID ID1, IDleft, ID1right)) :: ( _, ( _, 
COLON1left, _)) :: rest671)) => let val  result = MlyValue.funres (fn
 _ => let val  (ID as ID1) = ID1 ()
 in (SOME (sym ID, IDleft))
end)
 in ( LrTable.NT 15, ( result, COLON1left, ID1right), rest671)
end
|  ( 65, ( ( _, ( _, _, RPAREN1right)) :: ( _, ( _, LPAREN1left, _))
 :: rest671)) => let val  result = MlyValue.fml (fn _ => (nil))
 in ( LrTable.NT 13, ( result, LPAREN1left, RPAREN1right), rest671)

end
|  ( 66, ( ( _, ( _, _, RPAREN1right)) :: ( _, ( MlyValue.fmls fmls1,
 _, _)) :: ( _, ( _, LPAREN1left, _)) :: rest671)) => let val  result
 = MlyValue.fml (fn _ => let val  (fmls as fmls1) = fmls1 ()
 in (fmls)
end)
 in ( LrTable.NT 13, ( result, LPAREN1left, RPAREN1right), rest671)

end
|  ( 67, ( ( _, ( MlyValue.ID ID2, _, ID2right)) :: _ :: ( _, ( 
MlyValue.ID ID1, ID1left, _)) :: rest671)) => let val  result = 
MlyValue.fmls (fn _ => let val  ID1 = ID1 ()
 val  ID2 = ID2 ()
 in (mkFml ID1 ID2 ID1left :: nil)
end)
 in ( LrTable.NT 14, ( result, ID1left, ID2right), rest671)
end
|  ( 68, ( ( _, ( MlyValue.fmls fmls1, _, fmls1right)) :: _ :: ( _, ( 
MlyValue.ID ID2, _, _)) :: _ :: ( _, ( MlyValue.ID ID1, ID1left, _))
 :: rest671)) => let val  result = MlyValue.fmls (fn _ => let val  ID1
 = ID1 ()
 val  ID2 = ID2 ()
 val  (fmls as fmls1) = fmls1 ()
 in (mkFml ID1 ID2 ID1left :: fmls)
end)
 in ( LrTable.NT 14, ( result, ID1left, fmls1right), rest671)
end
| _ => raise (mlyAction i392)
end
val void = MlyValue.VOID
val extract = fn a => (fn MlyValue.prog x => x
| _ => let exception ParseInternal
	in raise ParseInternal end) a ()
end
end
structure Tokens : Tiger_TOKENS =
struct
type svalue = ParserData.svalue
type ('a,'b) token = ('a,'b) Token.token
fun TYPE (p1,p2) = Token.TOKEN (ParserData.LrTable.T 0,(
ParserData.MlyValue.VOID,p1,p2))
fun VAR (p1,p2) = Token.TOKEN (ParserData.LrTable.T 1,(
ParserData.MlyValue.VOID,p1,p2))
fun FUNCTION (p1,p2) = Token.TOKEN (ParserData.LrTable.T 2,(
ParserData.MlyValue.VOID,p1,p2))
fun BREAK (p1,p2) = Token.TOKEN (ParserData.LrTable.T 3,(
ParserData.MlyValue.VOID,p1,p2))
fun OF (p1,p2) = Token.TOKEN (ParserData.LrTable.T 4,(
ParserData.MlyValue.VOID,p1,p2))
fun END (p1,p2) = Token.TOKEN (ParserData.LrTable.T 5,(
ParserData.MlyValue.VOID,p1,p2))
fun IN (p1,p2) = Token.TOKEN (ParserData.LrTable.T 6,(
ParserData.MlyValue.VOID,p1,p2))
fun NIL (p1,p2) = Token.TOKEN (ParserData.LrTable.T 7,(
ParserData.MlyValue.VOID,p1,p2))
fun LET (p1,p2) = Token.TOKEN (ParserData.LrTable.T 8,(
ParserData.MlyValue.VOID,p1,p2))
fun DO (p1,p2) = Token.TOKEN (ParserData.LrTable.T 9,(
ParserData.MlyValue.VOID,p1,p2))
fun TO (p1,p2) = Token.TOKEN (ParserData.LrTable.T 10,(
ParserData.MlyValue.VOID,p1,p2))
fun FOR (p1,p2) = Token.TOKEN (ParserData.LrTable.T 11,(
ParserData.MlyValue.VOID,p1,p2))
fun WHILE (p1,p2) = Token.TOKEN (ParserData.LrTable.T 12,(
ParserData.MlyValue.VOID,p1,p2))
fun ELSE (p1,p2) = Token.TOKEN (ParserData.LrTable.T 13,(
ParserData.MlyValue.VOID,p1,p2))
fun THEN (p1,p2) = Token.TOKEN (ParserData.LrTable.T 14,(
ParserData.MlyValue.VOID,p1,p2))
fun IF (p1,p2) = Token.TOKEN (ParserData.LrTable.T 15,(
ParserData.MlyValue.VOID,p1,p2))
fun ARRAY (p1,p2) = Token.TOKEN (ParserData.LrTable.T 16,(
ParserData.MlyValue.VOID,p1,p2))
fun ASSIGN (p1,p2) = Token.TOKEN (ParserData.LrTable.T 17,(
ParserData.MlyValue.VOID,p1,p2))
fun OR (p1,p2) = Token.TOKEN (ParserData.LrTable.T 18,(
ParserData.MlyValue.VOID,p1,p2))
fun AND (p1,p2) = Token.TOKEN (ParserData.LrTable.T 19,(
ParserData.MlyValue.VOID,p1,p2))
fun GE (p1,p2) = Token.TOKEN (ParserData.LrTable.T 20,(
ParserData.MlyValue.VOID,p1,p2))
fun GT (p1,p2) = Token.TOKEN (ParserData.LrTable.T 21,(
ParserData.MlyValue.VOID,p1,p2))
fun LE (p1,p2) = Token.TOKEN (ParserData.LrTable.T 22,(
ParserData.MlyValue.VOID,p1,p2))
fun LT (p1,p2) = Token.TOKEN (ParserData.LrTable.T 23,(
ParserData.MlyValue.VOID,p1,p2))
fun NEQ (p1,p2) = Token.TOKEN (ParserData.LrTable.T 24,(
ParserData.MlyValue.VOID,p1,p2))
fun EQ (p1,p2) = Token.TOKEN (ParserData.LrTable.T 25,(
ParserData.MlyValue.VOID,p1,p2))
fun DIVIDE (p1,p2) = Token.TOKEN (ParserData.LrTable.T 26,(
ParserData.MlyValue.VOID,p1,p2))
fun TIMES (p1,p2) = Token.TOKEN (ParserData.LrTable.T 27,(
ParserData.MlyValue.VOID,p1,p2))
fun MINUS (p1,p2) = Token.TOKEN (ParserData.LrTable.T 28,(
ParserData.MlyValue.VOID,p1,p2))
fun PLUS (p1,p2) = Token.TOKEN (ParserData.LrTable.T 29,(
ParserData.MlyValue.VOID,p1,p2))
fun DOT (p1,p2) = Token.TOKEN (ParserData.LrTable.T 30,(
ParserData.MlyValue.VOID,p1,p2))
fun RBRACE (p1,p2) = Token.TOKEN (ParserData.LrTable.T 31,(
ParserData.MlyValue.VOID,p1,p2))
fun LBRACE (p1,p2) = Token.TOKEN (ParserData.LrTable.T 32,(
ParserData.MlyValue.VOID,p1,p2))
fun RBRACK (p1,p2) = Token.TOKEN (ParserData.LrTable.T 33,(
ParserData.MlyValue.VOID,p1,p2))
fun LBRACK (p1,p2) = Token.TOKEN (ParserData.LrTable.T 34,(
ParserData.MlyValue.VOID,p1,p2))
fun RPAREN (p1,p2) = Token.TOKEN (ParserData.LrTable.T 35,(
ParserData.MlyValue.VOID,p1,p2))
fun LPAREN (p1,p2) = Token.TOKEN (ParserData.LrTable.T 36,(
ParserData.MlyValue.VOID,p1,p2))
fun SEMICOLON (p1,p2) = Token.TOKEN (ParserData.LrTable.T 37,(
ParserData.MlyValue.VOID,p1,p2))
fun COLON (p1,p2) = Token.TOKEN (ParserData.LrTable.T 38,(
ParserData.MlyValue.VOID,p1,p2))
fun COMMA (p1,p2) = Token.TOKEN (ParserData.LrTable.T 39,(
ParserData.MlyValue.VOID,p1,p2))
fun STRING (i,p1,p2) = Token.TOKEN (ParserData.LrTable.T 40,(
ParserData.MlyValue.STRING (fn () => i),p1,p2))
fun INT (i,p1,p2) = Token.TOKEN (ParserData.LrTable.T 41,(
ParserData.MlyValue.INT (fn () => i),p1,p2))
fun ID (i,p1,p2) = Token.TOKEN (ParserData.LrTable.T 42,(
ParserData.MlyValue.ID (fn () => i),p1,p2))
fun EOF (p1,p2) = Token.TOKEN (ParserData.LrTable.T 43,(
ParserData.MlyValue.VOID,p1,p2))
fun UMINUS (p1,p2) = Token.TOKEN (ParserData.LrTable.T 44,(
ParserData.MlyValue.VOID,p1,p2))
fun IDX (p1,p2) = Token.TOKEN (ParserData.LrTable.T 45,(
ParserData.MlyValue.VOID,p1,p2))
fun TYX (p1,p2) = Token.TOKEN (ParserData.LrTable.T 46,(
ParserData.MlyValue.VOID,p1,p2))
fun FUNX (p1,p2) = Token.TOKEN (ParserData.LrTable.T 47,(
ParserData.MlyValue.VOID,p1,p2))
end
end
