%%%-------------------------------------------------------------------
%% @doc yatzy top level supervisor.
%% @end
%%%-------------------------------------------------------------------

-module(yatzy_sup).

-behaviour(supervisor).

%% API
-export([start_link/0]).
% -export([start_link/2]).

%% Supervisor callbacks
-export([init/1]).

-define(SERVER, ?MODULE).

%%====================================================================
%% API functions
%%====================================================================

start_link() ->
    supervisor:start_link({local, ?SERVER}, ?MODULE, []).
% start_link(john, ChildTurnName) ->
  % supervisor:start_link({local, ?SERVER}, ?MODULE, [john, ChildTurnName]).

%%====================================================================
%% Supervisor callbacks
%%====================================================================

%% Child :: #{id => Id, start => {M, F, A}}
%% Optional keys are restart, shutdown, type, modules.
%% Before OTP 18 tuples must be used to specify a child. e.g.
%% Child :: {Id,StartFunc,Restart,Shutdown,Type,Modules}
init([]) ->
  % {ok, {{one_for_all, 0, 1}, []}}.
  ChildPlayer = {john, {otp_yatzy_player, start_link, [john]}, permanent, 2000, worker, [otp_yatzy_player]},
  % ChildTurn = {ChildTurnName, {otp_yatzy_turn, start_link, []}, permanent, 2000, worker, [otp_yatzy_turn]},
  {ok, {{one_for_one, 0, 1}, [ChildPlayer]}}.

%%====================================================================
%% Internal functions
%%====================================================================
