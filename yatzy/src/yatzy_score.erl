-module(yatzy_score).
-export([calc/2]).
-spec calc(yatzy:slot(), yatzy:roll()) -> non_neg_integer().

calc(chance,Roll) ->
  lists:sum(Roll);

calc(ones,Roll) ->
  lists:sum(lists:filter(fun(X) -> X==1 end,Roll));

calc(twos,Roll) ->
  lists:sum(lists:filter(fun(X) -> X==2 end,Roll));

calc(threes,Roll) ->
  lists:sum(lists:filter(fun(X) -> X==3 end,Roll));

calc(fours,Roll) ->
  lists:sum(lists:filter(fun(X) -> X==4 end,Roll));

calc(fives,Roll) ->
  lists:sum(lists:filter(fun(X) -> X==5 end,Roll));

calc(sixes,Roll) ->
  lists:sum(lists:filter(fun(X) -> X==6 end,Roll));

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

calc(large_straight,Roll) ->
  large_straight_test(lists:sort(Roll));

calc(full_house,Roll) ->
  full_house_test(lists:sort(Roll));

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
  X*2 + Y*2;
two_pair_test([X,X,X,X,_]) ->
  X*4;
two_pair_test([_,X,X,X,X]) ->
  X*4.

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

large_straight_test([2,3,4,5,6]) ->
  2+3+4+5+6.

full_house_test([X,X,Y,Y,Y]) ->
  X*2 + Y*3;
full_house_test([Y,Y,Y,X,X]) ->
  Y*3 + X*2;
full_house_test([X,X,X,X,X]) ->
  X*5.

yatzy_score([X,X,X,X,X]) ->
  50.
