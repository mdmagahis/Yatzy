-module(yatzy_score).
-export([calc/2]).
-spec calc(yatzy:slot(), yatzy:roll()) -> non_neg_integer().

% calc functions--
calc(chance,Roll) ->
  lists:sum(Roll);

calc(ones,Roll) ->
  score_upper(Roll,1);

calc(twos,Roll) ->
  score_upper(Roll,2);

calc(threes,Roll) ->
  score_upper(Roll,3);

calc(fours,Roll) ->
  score_upper(Roll,4);

calc(fives,Roll) ->
  score_upper(Roll,5);

calc(sixes,Roll) ->
  score_upper(Roll,6);

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

% helper functions--
score_upper(Roll,N) ->
  lists:sum(lists:filter(fun(X) -> X==N end,Roll)).

one_pair_test([_,_,_,X,X]) ->
  X*2;
one_pair_test([_,_,X,X,_]) ->
  X*2;
one_pair_test([_,X,X,_,_]) ->
  X*2;
one_pair_test([X,X,_,_,_]) ->
  X*2;
one_pair_test(_) ->
  0.

two_pair_test([_,X,X,Y,Y]) when X/=Y ->
  X*2 + Y*2;
two_pair_test([X,X,_,Y,Y]) when X/=Y ->
  X*2 + Y*2;
two_pair_test([X,X,Y,Y,_]) when X/=Y ->
  X*2 + Y*2;
two_pair_test(_) ->
  0.

three_of_a_kind_test([_,_,X,X,X]) ->
  X*3;
three_of_a_kind_test([_,X,X,X,_]) ->
  X*3;
three_of_a_kind_test([X,X,X,_,_]) ->
  X*3;
three_of_a_kind_test(_) ->
  0.

four_of_a_kind_test([_,X,X,X,X]) ->
  X*4;
four_of_a_kind_test([X,X,X,X,_]) ->
  X*4;
four_of_a_kind_test(_) ->
  0.

small_straight_test([1,2,3,4,5]) ->
  1+2+3+4+5;
small_straight_test(_) ->
  0.

large_straight_test([2,3,4,5,6]) ->
  2+3+4+5+6;
large_straight_test(_) ->
  0.

full_house_test([X,X,Y,Y,Y]) when X/=Y ->
  X*2 + Y*3;
full_house_test([Y,Y,Y,X,X]) when X/=Y ->
  Y*3 + X*2;
full_house_test(_) ->
  0.

yatzy_score([X,X,X,X,X]) ->
  50;
yatzy_score(_) ->
  0.
