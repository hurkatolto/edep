%% -*- erlang-indent-level: 4;indent-tabs-mode: nil -*-
%% ex: ts=4 sw=4 et
-module(person).

-behaviour(gen_server).

-record(state, {name :: string()}).

-export([start_link/1, get_name/1]).
-export([init/1,
         handle_call/3,
         handle_cast/2,
         handle_info/2,
         code_change/3,
         terminate/2]).

start_link(Name) ->
    gen_server:start_link(?MODULE, [Name], []).

get_name(Pid) ->
    gen_server:call(Pid, get_name).

init([Name]) ->
    {ok, #state{name = Name}}.

handle_call(get_name, _From, #state{name = Name} = State) ->
    {reply, Name, State}.

handle_cast(_Cast, State) ->
    {noreply, State}.

handle_info(_Info, State) ->
    {noreply, State}.

code_change(_OldVsn, State, _Extra) ->
    {ok, State}.

terminate(_Reason, _State) ->
    ok.
