%% This file is under The MIT License (MIT)
%% Copyright (c) 2014 Tee Teoh (tty.erlang@gmail.com)
%%
%% This file can be found https://github.com/ttyerlsol/rss
%%
-module(delicious_SUITE).

-compile(export_all).

-include_lib("common_test/include/ct.hrl").

init_per_suite(Config) ->
  rss:init(),
  Config.

end_per_suite(_Config) ->
  ok.

all() -> 
  [delicious].

delicious(_Config) -> 
  L = delicious:popular("pies"),
  erlang:is_list(L) == true.
