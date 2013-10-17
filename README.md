WPath - word transformer

Basic usage:

```erlang

erl -pa ebin

> wpath_example:find("abaca", "black").
[<<"abaca">>,<<"aback">>,<<"alack">>,<<"black">>]

```

The current wpath_example file is built from the priv/words.short dictionary and contains only 2000 words.

To build a full dictionary, use the build_module script (be careful, the complexity is O(N^2), where N is file size):

```
./build_module.escript priv/words.full src/graph.erl.template && make
```

To build a dictionary from your own source do the following (again, beware of complexity):

```
./make_dict.sh /path/to/your/words/file && make
```

Some notes:

* Possible race conditions, since path searching is asynchronous. Can be solved by acquiring all the results first and picking the shortest one afterwards.

* A dumb tombstone with an additional receive instruction at the end of the find/2 function. Probably can be solved fairly quickly.

* In theory, it's possible to run out of ETS tables
