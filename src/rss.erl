%% This file is under The MIT License (MIT)
%% Copyright (c) 2014 Tee Teoh (tty.erlang@gmail.com)
%%
%% This file can be found https://github.com/ttyerlsol/rss
%%
-module(rss).

-include_lib("xmerl/include/xmerl.hrl").

-export([init/0, fetch/1, fetch/2, url/1]).

%%
%% @doc Starts the various applications needed by rss
%%
init() ->
  application:ensure_started(crypto),
  application:ensure_started(asn1),
  application:ensure_started(public_key),
  application:ensure_started(ssl),
  application:ensure_started(inets).

%%
%% @doc Fetches and parses the RSS feed
%%
-spec(url(list()) -> {term(), list(), list()}).
url(Url) ->
  case fetch(Url) of
    {ok, Headers, Body} ->
      parse(content_type(Headers), Body);
    Error ->
      Error
  end.

%%
%% @doc Fetches RSS feed returning the header and body
%%
-spec(fetch(list()) -> {ok, term(), term()} | {error, term()}).
fetch(Url) when is_list(Url) ->
  fetch(Url, []).

-spec(fetch(list(), list()) -> {ok, term(), term()} | {error, term()}).
fetch(Url, Headers) when is_list(Url) and is_list(Headers) ->
  case httpc:request(get, {Url, Headers}, [], []) of
    {ok, {Status, Header, Body}} ->
      case http_status(Status) of
	ok ->
	  {ok, Header, Body};
	_ ->
	  {error, Status}
      end;
    Error ->
      {error, Error}
  end.

content_type(Headers) ->
  {"content-type", Value} = lists:keyfind("content-type", 1, Headers),
  content_type_aux(Value).

content_type_aux(V) ->
  case re:run(V, "[application/rss+xml | text/xml]") of
    {match, _} ->
      rss;
    _ ->
      case re:run(V, "[application/atom+xml | application/xml]") of
	{match, _} ->
	  atom;
	_ ->
	  unsupported
      end
  end.

parse(rss, Feed) ->
  rss_parser:parse_feed(Feed);
parse(_, _Feed) ->
  unsupported.

http_status({_Version, 200, _Msg}) ->
  ok;
http_status({_Version, ErrorCode, Msg}) ->
  {error, ErrorCode, Msg}.
