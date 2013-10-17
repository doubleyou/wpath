#!/usr/bin/env escript

main([File, Output]) ->
    {ok, Words} = file:read_file(File),

    io:format("Processing a total of ~p words...~n", [round(byte_size(Words)/5)]),
    put(cnt, 1),

    Graph = list_to_tuple([begin
        A = get(cnt),
        io:format("~p ", [A]),
        put(cnt, A+1),
        find_nearest(Word, Words)
     end
        || <<Word:5/binary>> <= Words]),

    Index = dict:from_list(lists:zip(
        [W || <<W:5/binary>> <= Words],
        lists:seq(1, round(byte_size(Words) / 5))
    )),

    file:write_file(Output, [io_lib:format("words_graph() ->~n~p.~nwords_index() ->~n~p.words() -> ~p.~n", [Graph, Index, Words])]).

find_nearest(Word, Words) ->
    find_nearest(Word, Words, [], 1).

find_nearest(_Word, <<>>, Acc, _WordNum) ->
    Acc;
find_nearest(Word, <<Word2:5/binary, Rest/binary>>, Acc, WordNum) ->
    case close_words(Word, Word2) of
        true ->
            find_nearest(Word, Rest, [WordNum | Acc], WordNum + 1);
        false ->
            find_nearest(Word, Rest, Acc, WordNum + 1)
    end.

close_words(W1, W2) ->
    close_words(W1, W2, false).

close_words(<<C, Rest1/binary>>, <<C, Rest2/binary>>, HaveDiffChar) ->
    close_words(Rest1, Rest2, HaveDiffChar);
close_words(<<_, Rest1/binary>>, <<_, Rest2/binary>>, false) ->
    close_words(Rest1, Rest2, true);
close_words(<<>>, <<>>, true) ->
    true;
%% Words are identical, skip
close_words(<<>>, <<>>, false) ->
    false;
close_words(_, _, true) ->
    false.
