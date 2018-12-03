-module(yatzy_turn).
-export([start/0, roll/2, dice/1, rolls_left/1, stop/1]).
-spec start() -> {'ok', TurnPid::pid()}.

-spec roll(TurnPid::pid(), Keep::[1..6]) -> {'ok', yatzy:roll()} | 'invalid_keepers' | 'finished'.
%% Once the player has selected which dice to keep roll the remaining dice unless they
%%have already been rolled twice.

-spec dice(TurnPid::pid()) -> yatzy:roll().
%% Just the rolled dice as it stands at this point.

-spec rolls_left(TurnPid::pid()) -> 0..2.

-spec stop(TurnPid::pid()) -> yatzy:roll().
%% Just stop the procees and get out what was rolled.

start() ->
  Roll = [rand:uniform(6) || _ <- lists:seq(1,5)],
  TurnPid = spawn(fun() -> first_roll(Roll) end),
  {ok, TurnPid}.

roll(TurnPid, Keep) ->
  TurnPid ! {self(), {keep, Keep}},
  receive
    Reply ->
      Reply
  end.

dice(TurnPid) ->
  TurnPid ! {self(), dice},
  receive
    Roll ->
      Roll
  end.

rolls_left(TurnPid) ->
  TurnPid ! {self(), rolls_left},
  receive
    Result ->
      Result
  end.

stop(TurnPid) ->
  TurnPid ! {self(), stop},
  receive
    Roll ->
      Roll
  end.

first_roll(Roll) ->
  receive
    {From, {keep, Keep}} ->
      TestRoll = new_roll(Roll, Keep),
      case TestRoll of
        {ok, NewRoll} ->
          From ! {ok, NewRoll},
          second_roll(NewRoll);
        _ ->
          From ! TestRoll, % this should be invalid_keepers
          first_roll(Roll)
      end;
    {From, dice} ->
      From ! Roll,
      first_roll(Roll);
    {From, rolls_left} ->
      From ! 2,
      first_roll(Roll);
    {From, stop} ->
      From ! Roll
  end.

second_roll(Roll) ->
  receive
    {From, {keep, Keep}} ->
      TestRoll = new_roll(Roll, Keep),
      case TestRoll of
        {ok, NewRoll} ->
          From ! {ok, NewRoll},
          third_roll(NewRoll);
        _ ->
          From ! TestRoll, % this should be invalid_keepers
          second_roll(Roll)
      end;
    {From, dice} ->
      From ! Roll,
      second_roll(Roll);
    {From, rolls_left} ->
      From ! 1,
      second_roll(Roll);
    {From, stop} ->
      From ! Roll
  end.

third_roll(Roll) ->
  receive
    {From, {keep, _Keep}} ->
          From ! finished,
          third_roll(Roll);
    {From, dice} ->
      From ! Roll,
      third_roll(Roll);
    {From, rolls_left} ->
      From ! 0,
      third_roll(Roll);
    {From, stop} ->
      From ! Roll
  end.

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
