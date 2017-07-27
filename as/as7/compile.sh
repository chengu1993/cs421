#!/bin/sh

if [ $# -eq 0 ]; then
    echo "usage: ./compile_run.sh file target"
    exit 1
fi

sml <<EOF 2> /dev/null | egrep -v '\- |val it = |val use = |Standard|\[(linking|library|loading|scanning|autoloading|attempting|plugin|New)'
    CM.make "sources.cm";
    Main.compile "tests/$1";
EOF
gcc -m32 -ggdb3 -o tests/$2 runtime.c tests/$1.s
#./tests/$2
