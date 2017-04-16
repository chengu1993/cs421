#!/bin/sh
sml <<EOF 2> /dev/null | egrep -v '\- |val it = |val use = |Standard|\[(linking|library|loading|scanning)'  
    CM.make "sources.cm";
    val (fgraph, nodes) = MakeGraph.instrs2graph(MakeGraph.fake_input ());
    val (igraph, tableMapping) = Liveness.interferenceGraph(fgraph);
    val out = TextIO.openOut "/Users/chengu/git/cs421/as/as6/igraph.dot";
    Liveness.show(out, igraph)

EOF
