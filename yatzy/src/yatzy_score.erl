-module(yatzy_score).
-export([calc/2]).
-spec calc(yatzy:slot(), yatzy:roll()) -> non_neg_integer().

calc(chance,Roll) ->
  lists:sum(Roll);

calc(one_pair,Roll) ->
  one_pair_test(lists:sort(Roll));

calc(two_pairs,Roll) ->
  two_pair_test(lists:sort(Roll));

calc(three_of_a_kind,Roll) ->
  three_of_a_kind_test(lists:sort(Roll));

calc(four_of_a_kind,Roll) ->
  four_of_a_kind_test(lists:sort(Roll));

calc(small_straight,Roll) ->
  small_straight_test(lists:sort(Roll));

calc(yatzy,Roll) ->
  yatzy_score(Roll).

one_pair_test([_,_,_,X,X]) ->
  X*2;
one_pair_test([_,_,X,X,_]) ->
  X*2;
one_pair_test([_,X,X,_,_]) ->
  X*2;
one_pair_test([X,X,_,_,_]) ->
  X*2.

two_pair_test([_,X,X,Y,Y]) ->
  X*2 + Y*2;
two_pair_test([X,X,_,Y,Y]) ->
  X*2 + Y*2;
two_pair_test([X,X,Y,Y,_]) ->
  X*2 + Y*2.

three_of_a_kind_test([_,_,X,X,X]) ->
  X*3;
three_of_a_kind_test([_,X,X,X,_]) ->
  X*3;
three_of_a_kind_test([X,X,X,_,_]) ->
  X*3.

four_of_a_kind_test([_,X,X,X,X]) ->
  X*4;
four_of_a_kind_test([X,X,X,X,_]) ->
  X*4.

small_straight_test([1,2,3,4,5]) ->
  1+2+3+4+5.

yatzy_score([X,X,X,X,X]) ->
  50.
