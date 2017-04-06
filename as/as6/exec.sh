#!/bin/sh
sml <<EOF 2> /dev/null | egrep -v '\- |val it = |val use = |Standard|\[(linking|library|loading|scanning)'  
    CM.make "sources.cm";
    MakeGraph.instrs2graph(MakeGraph.fake_input ());
EOF
