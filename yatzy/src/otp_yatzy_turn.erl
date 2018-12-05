-module(otp_yatzy_turn).
-export([start/0, roll/2, dice/1, rolls_left/1, stop/1]).
-export([first_roll/3, second_roll/3, third_roll/3]).
-export([init/1, callback_mode/0]).

-spec start() -> {'ok', TurnPid::pid()}.

% -spec roll(TurnPid::pid(), Keep::[1..6]) -> {'ok', yatzy:roll()} | 'invalid_keepers' | 'finished'.
-spec roll(TurnPid::pid(), Keep::[1..6]) -> 'ok' | 'invalid_keepers' | 'finished'.
%% Once the player has selected which dice to keep roll the remaining dice unless they
%%have already been rolled twice.

-spec dice(TurnPid::pid()) -> yatzy:roll().
%% Just the rolled dice as it stands at this point.

-spec rolls_left(TurnPid::pid()) -> 0..2.

-spec stop(TurnPid::pid()) -> yatzy:roll().
%% Just stop the procees and get out what was rolled.

-behavior(gen_statem).

start() ->
  Roll = [rand:uniform(6) || _ <- lists:seq(1,5)],
  gen_statem:start_link(?MODULE, Roll, []).

roll(TurnPid, Keep) ->
  gen_statem:call(TurnPid, {roll, Keep}).

dice(TurnPid) ->
  gen_statem:call(TurnPid, dice).

rolls_left(TurnPid) ->
  gen_statem:call(TurnPid, rolls_left).

stop(TurnPid) ->
  gen_statem:call(TurnPid, stop).

%% First Roll State
first_roll({call, From}, {roll, Keep}, Roll) ->
  TestRoll = new_roll(Roll, Keep),
  case TestRoll of
    {ok, NewRoll} ->
      {next_state, second_roll, NewRoll, {reply, From, NewRoll}};
    _ ->
      {keep_state_and_data, {reply, From, invalid_keepers}}
  end;
first_roll({call, From}, dice, Roll) ->
  {keep_state_and_data, {reply, From, Roll}};
first_roll({call, From}, rolls_left, _Roll) ->
  {keep_state_and_data, {reply, From, 2}};
first_roll({call, From}, stop, Roll) ->
  {stop_and_reply, normal, {reply, From, Roll}}.

%% Second Roll State
second_roll({call, From}, {roll, Keep}, Roll) ->
  TestRoll = new_roll(Roll, Keep),
  case TestRoll of
    {ok, NewRoll} ->
      {next_state, third_roll, NewRoll, {reply, From, NewRoll}};
    _ ->
      {keep_state_and_data, {reply, From, invalid_keepers}}
  end;
second_roll({call, From}, dice, Roll) ->
  {keep_state_and_data, {reply, From, Roll}};
second_roll({call, From}, rolls_left, _Roll) ->
  {keep_state_and_data, {reply, From, 1}};
second_roll({call, From}, stop, Roll) ->
  {stop_and_reply, normal, {reply, From, Roll}}.

%% Third Roll State
third_roll({call, From}, {roll, _Keep}, _Roll) ->
  {keep_state_and_data, {reply, From, finished}};
third_roll({call, From}, dice, Roll) ->
  {keep_state_and_data, {reply, From, Roll}};
third_roll({call, From}, rolls_left, _Roll) ->
  {keep_state_and_data, {reply, From, 0}};
third_roll({call, From}, stop, Roll) ->
  {stop_and_reply, normal, {reply, From, Roll}}.

new_roll(Roll, Keep) ->
  case lists:subtract(Keep, Roll) of
    [] ->
      ReducedRoll = lists:filter(fun (Elem) -> not lists:member(Elem,Keep) end, Roll),
      TempRoll = [rand:uniform(6) || _ <- lists:seq(1,length(ReducedRoll))],
      NewRoll = Keep ++ TempRoll,
      {ok, NewRoll};
    _ ->
      invalid_keepers
  end.

%% Callback Functions
init(Roll) ->
  {ok, first_roll, Roll}.

callback_mode() ->
  state_functions.
