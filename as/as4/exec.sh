#!/bin/sh
sml <<EOF 2> /dev/null | egrep -v '\- |val it = |val use = |Standard|\[(linking|library|loading|scanning)'  
    CM.make "sources.cm";
    val a = Parse.parse "$1";
    Parse.writeFile ("$2", PP.pp(a))
EOF
