-module(yatzy_sheet).
-type t() :: map().

-export([new/0]).
-spec new() -> t().

-export([fill/3]).
-spec fill(yatzy:slot(), yatzy:roll(), t()) -> {'ok', t()}
                                             | 'already_filled'
                                             | 'invalid_slot'.

-export([get/2]).
-spec get(yatzy:slot(), t()) -> {'filled', non_neg_integer()}
                              | 'invalid_slot'
                              | 'empty'.

-export([upper_total/1]).
-spec upper_total(t()) -> non_neg_integer().

-export([bonus/1]).
-spec bonus(to()) -> 0 | 50.

-export([lower_total/1]).
-spec lower_total(t()) -> non_neg_integer().

-export([total/1]).
-spec total(t()) -> non_neg_integer().

% definitions--
new() ->
  maps:new().

% fill(yatzy,Roll,Map) ->

get(_,#{}) ->
  'empty'.
get(Slot,_) ->
  case lists:member(Slot,yatzy:slot()) of
    true ->
      % ok;
      case Slot of
        'ones'            -> {'filled', 0}; % MDM
        'twos'            -> ok;
        'threes'          -> ok;
        'fours'           -> ok;
        'fives'           -> ok;
        'sixes'           -> ok;
        'one_pair'        -> ok;
        'two_pairs'       -> ok;
        'three_of_a_kind' -> ok;
        'four_of_a_kind'  -> ok;
        'small_straight'  -> ok;
        'large_straight'  -> ok;
        'full_house'      -> ok;
        'chance'          -> ok;
        'yatzy'           -> ok
      end;
    false ->
      'invalid_slot'
  end.

total(map) ->
  0.
