-module(yatzy_player).
-export([new/1, fill/3,sheet/1]).
-spec new(Name::atom()) -> {ok, pid()}.
-spec fill(Name::atom(), yatzy:slot(), yatzy:roll()) -> {ok, Score::integer()}
                                                     | {error, Reason::any()}.
-spec sheet(Name::atom()) -> yatzy_sheet:t().

new(Player) ->
  Pid = spawn(fun() -> loop(yatzy_sheet:new()) end),
  register(Player,Pid),
  {ok, Pid}.

fill(Player, Slot, Roll) ->
  Player ! {self(), {fill, Slot, Roll}},
  receive
    Reply ->
      Reply
  end.

sheet(Player) ->
  Player ! {self(), sheet},
  receive
    Sheet ->
      Sheet
  end.

loop(Sheet) ->
  receive
    {From, sheet} ->
      From ! Sheet,
      loop(Sheet);
    {From, {fill, Slot, Roll}} ->
      case yatzy_sheet:fill(Slot, Roll, Sheet) of
        {ok, NewSheet} ->
          {filled, Score} = yatzy_sheet:get(Slot, NewSheet),
          From ! {ok, Score},
          loop(NewSheet);
        Reason ->
          From ! {error, Reason},
          loop(Sheet)
      end
  end.
