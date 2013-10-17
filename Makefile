.PHONY: all up test

all:
	./build_module.escript priv/words.short src/graph.erl.template
	cat src/wpath.erl.template > src/wpath.erl
	cat src/graph.erl.template >> src/wpath.erl
	./rebar compile

up:
	cat src/wpath.erl.template > src/wpath.erl
	cat src/graph.erl.template >> src/wpath.erl
	./rebar compile

test:
	./rebar eunit
