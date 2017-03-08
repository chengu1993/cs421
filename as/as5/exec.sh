#!/bin/sh
sml <<EOF 2> /dev/null | egrep -v '\- |val it = |val use = |Standard|\[(linking|library|loading|scanning)'  
    CM.make "sources.cm";
    print "Parsing\n";
    Main.comp "tests/test01.tig";
 print "Parsing\n";
    Main.comp "tests/test02.tig";
 print "Parsing\n";
    Main.comp "tests/test03.tig";
 print "Parsing\n";
    Main.comp "tests/test04.tig";
     print "Parsing\n";
    Main.comp "tests/test05.tig";
     print "Parsing\n";
    Main.comp "tests/test06.tig";
     print "Parsing\n";
    Main.comp "tests/test07.tig";
     print "Parsing\n";
    Main.comp "tests/test08.tig";
     print "Parsing\n";
    Main.comp "tests/test09.tig";
     print "Parsing\n";
    Main.comp "tests/test10.tig";
EOF
