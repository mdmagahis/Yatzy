-module(otp_yatzy_player).
% -export([new/1, fill/3,sheet/1]).
-export([start_link/1, fill/3, sheet/1]).
-export([init/1, handle_call/3, handle_cast/2]).

% -spec new(Name::atom()) -> {ok, pid()}.
-spec start_link(Name::atom()) -> {ok, pid()}.
-spec fill(Name::atom(), yatzy:slot(), yatzy:roll()) -> {ok, Score::integer()}
                                                     | {error, Reason::any()}.
-spec sheet(Name::atom()) -> yatzy_sheet:t().

-behavior(gen_server).

start_link(Player) ->
  gen_server:start_link({local, Player}, ?MODULE, args, []).

% new(Player) ->
%   Pid = spawn(fun() -> loop(yatzy_sheet:new()) end),
%   register(Player,Pid),
%   {ok, Pid}.

fill(Player, Slot, Roll) ->
  gen_server:call(Player, {fill, Slot, Roll}).
  % Player ! {self(), {fill, Slot, Roll}},
  % receive
  %   Reply ->
  %     Reply
  % end.

sheet(Player) ->
  gen_server:call(Player, sheet).
  % Player ! {self(), sheet},
  % receive
  %   Sheet ->
  %     Sheet
  % end.

% loop(Sheet) ->
%   receive
%     {From, sheet} ->
%       From ! Sheet,
%       loop(Sheet);
%     {From, {fill, Slot, Roll}} ->
%       case yatzy_sheet:fill(Slot, Roll, Sheet) of
%         {ok, NewSheet} ->
%           {filled, Score} = yatzy_sheet:get(Slot, NewSheet),
%           From ! {ok, Score},
%           loop(NewSheet);
%         Reason ->
%           From ! {error, Reason},
%           loop(Sheet)
%       end
%   end.

%% Callback Functions
init(args) ->
  {ok, yatzy_sheet:new()}.

handle_cast(stop, Sheet) ->
  {stop, normal, Sheet}.

handle_call(sheet, _From, Sheet) ->
  Reply = Sheet,
  {reply, Reply, Sheet};

handle_call({fill, Slot, Roll}, _From, Sheet) ->
  case yatzy_sheet:fill(Slot, Roll, Sheet) of
    {ok, NewSheet} ->
      {ok, Reply} = yatzy_sheet:get(Slot, NewSheet),
      {reply, Reply, NewSheet};
      % {filled, Score} = yatzy_sheet:get(Slot, NewSheet),
      % From ! {ok, Score},
      % loop(NewSheet);
    Reason ->
      Reply = {error, Reason},
      {reply, Reply, Sheet}
      % From ! {error, Reason},
      % loop(Sheet)
  end.
