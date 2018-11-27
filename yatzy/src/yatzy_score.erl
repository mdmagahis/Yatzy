-module(yatzy_score).
-export([calc/2]).
-spec calc(yatzy:slot(), yatzy:roll()) -> non_neg_integer().

calc(chance,Roll) ->
  lists:sum(Roll);

calc(ones,Roll) ->
  ones_test(lists:sort(Roll));

calc(twos,Roll) ->
  twos_test(lists:sort(Roll));

calc(threes,Roll) ->
  threes_test(lists:sort(Roll));

calc(fours,Roll) ->
  fours_test(lists:sort(Roll));

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

ones_test([1,1,1,1,1]) ->
  1*5;
ones_test([1,1,1,1,_]) ->
  1*4;
ones_test([1,1,1,_,_]) ->
  1*3;
ones_test([1,1,_,_,_]) ->
  1*2;
ones_test([1,_,_,_,_]) ->
  1*1.

twos_test([2,2,2,2,2]) ->
  2*5;
twos_test([_,2,2,2,2])->
  2*4;
twos_test([2,2,2,2,_]) ->
  2*4;
twos_test([2,2,2,_,_]) ->
  2*3;
twos_test([_,2,2,2,_]) ->
  2*3;
twos_test([_,_,2,2,2]) ->
  2*3;
twos_test([2,2,_,_,_]) ->
  2*2;
twos_test([_,2,2,_,_]) ->
  2*2;
twos_test([_,_,2,2,_]) ->
  2*2;
twos_test([_,_,_,2,2]) ->
  2*2;
twos_test([2,_,_,_,_]) ->
  2*1;
twos_test([_,2,_,_,_]) ->
  2*1;
twos_test([_,_,2,_,_]) ->
  2*1;
twos_test([_,_,_,2,_]) ->
  2*1;
twos_test([_,_,_,_,2]) ->
  2*1.

threes_test([3,3,3,3,3]) ->
  3*5;
threes_test([3,3,3,3,_]) ->
  3*4;
threes_test([3,3,3,_,_]) ->
  3*3;
threes_test([3,3,_,_,_]) ->
  3*2;
threes_test([3,_,_,_,_]) ->
  3*1.

fours_test([4,4,4,4,4]) ->
  4*5;
fours_test([4,4,4,4,_]) ->
  4*4;
fours_test([4,4,4,_,_]) ->
  4*3;
fours_test([4,4,_,_,_]) ->
  4*2;
fours_test([4,_,_,_,_]) ->
  4*1.

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
