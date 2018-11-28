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

-export([uppoer_total/1]).
-spec upper_total(t()) -> non_neg_integer().

-export([bonus/1]).
-spec bonus(to()) -> 0 | 50.

-export([lower_total/1]).
-spec lower_total(t()) -> non_neg_integer().

-export([total/1]).
-spec total(t()) -> non_neg_integer().

% definitions--
new() ->
  map.

total(map) ->
  0.
