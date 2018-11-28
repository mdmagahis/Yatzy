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
new() ->
  maps:new().

% fill(yatzy,Roll,Map) ->

get(Slot,Sheet) ->
  case lists:member(Slot,yatzy:slot()) of
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

total(map) ->
  0.
