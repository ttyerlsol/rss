%% This file is under The MIT License (MIT)
%% Copyright (c) 2014 Tee Teoh (tty.erlang@gmail.com)
%%
%% This file can be found https://github.com/ttyerlsol/rss
%%
-module(rss_parser).

-export([parse_feed/1]).

-record(rss_state, {type = other, acc = []}).

parse_feed(Feed) ->
  xmerl_sax_parser:stream(Feed, options()).

options() ->
    [{event_state, []},
     {event_fun, fun rss/3}].

rss(startDocument, _, _) ->
  #rss_state{};
rss(endDocument, _, #rss_state{acc = Acc}) ->
  Acc;
rss({startElement, _, "item", _QName, _Attrs}, _, State) ->
  State#rss_state{type = item};
rss({endElement, _, "item", _QName}, _, State) ->
  State#rss_state{type = other};
rss({startElement, _, "title", _QName, _Attrs}, _, #rss_state{type = item} = State) ->
  State#rss_state{type = title};
rss({endElement, _, "title", _QName}, _, #rss_state{type = title} = State) ->
  State#rss_state{type = other};
rss({characters, Title}, _, #rss_state{type = title, acc = Acc} = State) ->
  State#rss_state{acc = [list_to_binary(Title) | Acc]};
rss(_, _, State) ->
  State.
