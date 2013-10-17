-module(wpath_example_tests).

-include_lib("eunit/include/eunit.hrl").

basic_test() ->
    ?assertEqual(
        [<<"abaca">>, <<"aback">>, <<"alack">>],
        wpath_example:find(<<"abaca">>, <<"alack">>)
    ),
    ?assertEqual(
        [<<"alack">>, <<"aback">>, <<"abaca">>],
        wpath_example:find(<<"alack">>, <<"abaca">>)
    ).

basic2_test() ->
    ?assertEqual(
        [<<"black">>, <<"alack">>, <<"aback">>, <<"abaca">>],
        wpath_example:find("black", "abaca")
    ),
    ?assertEqual(
        [<<"abaca">>,<<"aback">>,<<"alack">>,<<"black">>],
        wpath_example:find("abaca", "black")
    ).
