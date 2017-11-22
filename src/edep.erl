%% -*- erlang-indent-level: 4;indent-tabs-mode: nil -*-
%% ex: ts=4 sw=4 et
-module(edep).

-behaviour(application).

-export([start/2,
         stop/1,
         new/1]).

start(Type, Args) ->
    io:format("~p ~p Type: '~p' ~n", [?MODULE, ?LINE, Type]),
    io:format("~p ~p Args: '~p' ~n", [?MODULE, ?LINE, Args]),
    edep_sup:start_link().

stop(State)->
    io:format("~p ~p State: '~p' ~n", [?MODULE, ?LINE, State]),
    ok.

new(Name) ->
   edep_sup:new(Name).
