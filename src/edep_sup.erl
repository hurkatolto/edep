%% -*- erlang-indent-level: 4;indent-tabs-mode: nil -*-
%% ex: ts=4 sw=4 et
-module(edep_sup).
-behaviour(supervisor).

-export([start_link/0, new/1]).
-export([init/1]).

start_link() ->
    supervisor:start_link({local, ?MODULE}, ?MODULE, []).

new(Name) ->
    io:format("~p ~p Name: '~p' ~n", [?MODULE, ?LINE, Name]),
    supervisor:start_child(?MODULE, {Name, {person, start_link, [Name]}, permanent, 2000, worker, [person]}).

init([]) ->
%    CSIServer = {?CSI_SERVICE_NAME, {csi, start_link, []},
%                  permanent, 2000, worker, [csi]},
    Procs = [],
    {ok, {{one_for_one, 3, 10}, Procs}}.
