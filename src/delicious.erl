%% This file is under The MIT License (MIT)
%% Copyright (c) 2014 Tee Teoh (tty.erlang@gmail.com)
%%
%% This file can be found https://github.com/ttyerlsol/rss
%%
-module(delicious).

-export([popular/1]).

-spec(popular(list()) -> list()).
popular(Topic) ->
  URL = base_url() ++ Topic,
  {ok, Items, _} = rss:url(URL),
  Items.

base_url() ->
  "http://del.icio.us/rss/popular/".
