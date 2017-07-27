(* Test.comp fname : compile <fname> and write Itree code to standard output *)
(* Test.compf (fname, outfile) : write to <outfile> instead *)
(* Test.testit () : run comp on all test files in cs421/as/testcases *)
(* Test.testitf () : run compf on all test files in cs421/as/testcases *)

signature TEST = sig
  val comp : string -> unit
  val compf : string * string -> unit
  val testit : unit -> unit
  val testitf : unit -> unit
end

structure Test : TEST = struct
  structure Semant = SemantGen (Register)
  fun comp0 (s, outfile) =
    let fun say s = TextIO.output (outfile, s)
        fun prFrag (Frame.PROC {name, body,...}) =
            (say ("\n ****** FUNCTION " ^ Symbol.name name ^ "\n");
             Printtree.printtree (outfile, body);
             say (" ****** END of FUNCTION " ^ Symbol.name name ^ "\n"))
          | prFrag (Frame.DATA s) = say (" *** STRING: " ^ #s s ^ "\n")
     in app prFrag (Semant.transprog (Parse.parse s))
    end
  fun comp s = comp0 (s, TextIO.stdOut)
  fun compf (infile, outfile) =
    let val outs = TextIO.openOut outfile
     in comp0(infile, outs);
        TextIO.closeOut outs
    end
  val num_of_tests = 49
  fun testit () =
    let fun say s = TextIO.output(TextIO.stdOut,s)
        fun h k =
          if k <= num_of_tests then
            let val name = Format.format "test%d.tig" [Format.INT k]
                val dirname = "/c/cs421/as/testcases/"
             in say "\n\n";
                say "------------------parsing ";
                say name;
                say "------------------------\n";
                comp (dirname ^ name);
                h (k + 1)
            end
          else ()
     in h 1
    end
  fun testitf () =
    let fun say s = TextIO.output (TextIO.stdOut, s)
        fun h k =
          if (k <= num_of_tests) then
            let val name = Format.format "test%d.tig" [Format.INT k]
                val dirname = "/c/cs421/as/testcases/"
             in say "\n\n";
                say "------------------parsing ";
                say name;
                say "------------------------\n";
                compf (dirname ^ name, name ^ ".i");
                h (k + 1)
             end
          else ()
     in h 1
    end
end
