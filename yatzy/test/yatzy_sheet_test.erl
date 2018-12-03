-module(yatzy_sheet_test).

-compile(export_all).

-include_lib("eunit/include/eunit.hrl").

new_test_() ->
    [?_assertEqual(#{}, yatzy_sheet:new())].
%      ?_assertEqual(6, yatzy_sheet:calc(twos, [2,4,2,3,2])),
%      ?_assertEqual(12, yatzy_sheet:calc(threes, [3,3,4,3,3])),
%      ?_assertEqual(4, yatzy_sheet:calc(fours, [6,2,4,3,2])),
%      ?_assertEqual(25, yatzy_sheet:calc(fives, [5,5,5,5,5])),
     % ?_assertEqual(0, yatzy_sheet:calc(sixes, [1,2,5,4,3]))].
%
% fill_test_() ->
%     [?_assertEqual(10, yatzy_sheet:fill()),
%      ?_assertEqual(0, yatzy_sheet:calc(one_pair, [1,2,3,4,6])),
%      ?_assertEqual(12, yatzy_sheet:calc(one_pair, [5,5,6,6,5]))].
%
%
get_test_() ->
    [?_assertEqual('empty', yatzy_sheet:get(ones,#{})),
     ?_assertEqual('invalid_slot', yatzy_sheet:get(random, #{}))].
%      ?_assertEqual(0, yatzy_sheet:calc(two_pairs, [5,5,3,5,5]))].
%
% three_of_a_kind_test_() ->
%     [?_assertEqual(0, yatzy_sheet:calc(three_of_a_kind, [5,5,3,2,4])),
%      ?_assertEqual(15, yatzy_sheet:calc(three_of_a_kind, [3,5,4,5,5])),
%      ?_assertEqual(18, yatzy_sheet:calc(three_of_a_kind, [6,6,3,6,6]))].
%
% four_of_a_kind_test_() ->
%     [?_assertEqual(0, yatzy_sheet:calc(four_of_a_kind, [6,6,6,4,5])),
%      ?_assertEqual(20, yatzy_sheet:calc(four_of_a_kind, [5,5,5,3,5])),
%      ?_assertEqual(12, yatzy_sheet:calc(four_of_a_kind, [3,3,3,3,3]))].
%
% small_straight_test_() ->
%     [?_assertEqual(0, yatzy_sheet:calc(small_straight, [2,3,4,5,6])),
%      ?_assertEqual(15, yatzy_sheet:calc(small_straight, [1,4,3,2,5]))].
%
%
% large_straight_test_() ->
%     [?_assertEqual(20, yatzy_sheet:calc(large_straight, [2,3,4,5,6])),
%      ?_assertEqual(0, yatzy_sheet:calc(large_straight, [1,4,3,2,5]))].
%
% full_house_test_() ->
%     [?_assertEqual(23, yatzy_sheet:calc(full_house, [4,5,5,5,4])),
%      ?_assertEqual(0, yatzy_sheet:calc(full_house, [4,4,4,4,4]))].
%
% chance_test_() ->
%     [?_assertEqual(23, yatzy_sheet:calc(chance, [4,5,3,6,5])),
%      ?_assertEqual(13, yatzy_sheet:calc(chance, [2,3,4,1,3]))].
%
% yatzy_test_() ->
%     [?_assertEqual(0, yatzy_sheet:calc(yatzy, [4,5,4,4,4])),
%      ?_assertEqual(50, yatzy_sheet:calc(yatzy, [3,3,3,3,3]))].
