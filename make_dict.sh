#!/bin/sh

$file=/tmp/words

grep '^.....$' $1 | tr -d '\n' > $file
./build_module.escript $file src/graph.erl.template
