-module(yatzy_sheet).
-type t() :: map().

-export([new/0,
         fill/3,
         get/2,
         upper_total/1,
         bonus/1,
         lower_total/1,
         total/1]).

-spec new() -> t().
-spec fill(yatzy:slot(), yatzy:roll(), t()) -> {'ok', t()}
                                             | 'already_filled'
                                             | 'invalid_slot'.
-spec get(yatzy:slot(), t()) -> {'filled', non_neg_integer()}
                              | 'invalid_slot'
                              | 'empty'.
-spec upper_total(t()) -> non_neg_integer().
-spec bonus(to()) -> 0 | 50.
-spec lower_total(t()) -> non_neg_integer().
-spec total(t()) -> non_neg_integer().

% definitions--
slot_list() -> ['ones', 'twos', 'threes', 'fours', 'fives', 'sixes', 'one_pair', 'two_pairs', 'three_of_a_kind',  'four_of_a_kind', 'small_straight', 'large_straight', 'full_house', 'chance', 'yatzy'].
upper_slot_list() -> ['ones', 'twos', 'threes', 'fours', 'fives', 'sixes'].

new() ->
  maps:new().

fill(Slot,Roll,Sheet) ->
  case lists:member(Slot,slot_list()) of
    true ->
      case get(Slot, Sheet, empty) of
        empty ->
          {ok, maps:put(Slot,Roll,Sheet)};
        Value ->
          already_filled
      end;
    false ->
      invalid_slot
  end.

get(Slot,Sheet) ->
  case lists:member(Slot,slot_list()) of
    true ->
      case maps:get(Slot, Sheet, empty) of
        empty ->
          empty;
        Value ->
          {filled, Value}
      end;
    false ->
      invalid_slot
  end.

total(Sheet) ->
  lists:sum(maps:values(Sheet)).
