signature TEST =
sig
  val comp : string -> unit
  val testit : unit -> unit
end

structure Test : TEST =
struct
  fun comp fname = (Semant.transprog (Parse.parse fname); ())
  val num_of_tests = 57;
  fun testit () =
    let fun h (k) =
          if (k <= num_of_tests) then
            (let val name = Format.format "test%d.tig" [Format.INT (k)]
                 val dirname = "testcases/"
              in print "\n";
                 print "------------------parsing ";
                 print name;
                 print "------------------------\n";
                 comp (dirname^name)
             end; h (k + 1))
          else ()
     in h (1)
    end
end
