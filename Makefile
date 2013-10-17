.PHONY: all up test

all:
	cat src/wpath.erl.template > src/wpath.erl
	cat src/graph.erl.template >> src/wpath.erl
	./rebar compile

test:
	./rebar eunit
