#!/bin/sh

if [ $# -eq 0 ]; then
    echo "usage: ./compile file target"
    exit 1
fi

sml <<EOF 2> /dev/null | egrep -v '\- |val it = |val use = |Standard|\[(linking|library|loading|scanning|autoloading|attempting|plugin|New)'
    CM.make "sources.cm";
    Main.compile "tests/$1";
EOF
gcc -m32 -ggdb3 -o $2 runtime.c tests/$1.s
# ./prog

# #!/bin/bash
# command="CM.make \"\$smlnj-tdp/back-trace.cm\"; SMLofNJ.Internals.TDP.mode := true; CM.make \"sources.cm\"; Main.compile \"$1\";"
# echo $command;
# sml <<< $command
# gcc -m32 -ggdb3 -o prog runtime.c $1.s
# ./prog
