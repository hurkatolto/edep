%% -*- erlang-indent-level: 4;indent-tabs-mode: nil -*-
%% ex: ts=4 sw=4 et
-module(person).
-behaviour(csi_server).

-record(service_state, {
          name :: string()
        }).

-record(session_state, {
          name :: string()
         }).

-define(SERVICE, person).

-export([start_link/1, get_name/0]).
-export([init_service/1,
         init/2,
         terminate/2,
         get_name/2,
         handle_call/3,
%         handle_cast/2,
         handle_info/2,
         code_change/3,
         terminate_service/2]).

start_link(Name) ->
    io:format("~p ~p start_link: '~p' ~n", [?MODULE, ?LINE, start_link]),
    csi:start_link(?SERVICE, ?SERVICE, [Name]).

get_name() ->
    io:format("~p ~p get_name: '~p' ~n", [?MODULE, ?LINE, get_name]),
    csi:call_s(?SERVICE, get_name).

init_service([Name]) ->
    io:format("~p ~p Name: '~p' ~n", [?MODULE, ?LINE, Name]),
    {ok, #service_state{name = Name}}.

init(Args, #service_state{name = Name} = ServiceState) ->
    io:format("~p ~p {Args, ServiceState}: '~p' ~n", [?MODULE, ?LINE, {Args, ServiceState}]),
    {ok, #session_state{name = Name}}.

get_name(Arg, #session_state{name = Name} = State) ->
    io:format("~p ~p {Arg, State}: '~p' ~n", [?MODULE, ?LINE, {Arg, State}]),
    {Name, State}.

handle_call(Request, _From, State) ->
    io:format("~p ~p {Request, State}: '~p' ~n", [?MODULE, ?LINE, {Request, State}]),
    {noreply, State}.

handle_info(Info, State) ->
    io:format("~p ~p Info, State: '~p' ~n", [?MODULE, ?LINE, {Info, State}]),
    {noreply, State}.

code_change(OldVsn, State, Extra) ->
    io:format("~p ~p {OldVsn, State, Extra}: '~p' ~n", [?MODULE, ?LINE, {OldVsn, State, Extra}]),
    io:format("~p ~p OldVsn: '~p' ~n", [?MODULE, ?LINE, OldVsn]),
    {ok, State}.

terminate_service(Reason, _State) ->
    io:format("~p ~p Reason: '~p' ~n", [?MODULE, ?LINE, Reason]),
    ok.

terminate(Reason, #session_state{} = State) ->
    io:format("~p ~p {Reason, State}: '~p' ~n", [?MODULE, ?LINE, {Reason, State}]),
    ok.

