-module(encode_uri_rfc3986).
-author('Renato Albano <renatoalbano@gmail.com>').

-export([encode/1]).

%% Taken from <http://erlangexamples.com/>,
%% from <http://github.com/CapnKernul/httparadise>
%% and <http://www.erlang.org/doc/man/edoc_lib.html>

encode([C | Cs]) when C >= $a, C =< $z ->
  [C | encode(Cs)];
encode([C | Cs]) when C >= $A, C =< $Z ->
  [C | encode(Cs)];
encode([C | Cs]) when C >= $0, C =< $9 ->
  [C | encode(Cs)];

%%encode([C | Cs]) when C == 16#20 -> % space to +
%%  [$+ | encode(Cs)];

% unreserved
encode([C = $- | Cs]) ->
  [C | encode(Cs)];
encode([C = $_ | Cs]) ->
  [C | encode(Cs)];
encode([C = 46 | Cs]) -> % .
  [C | encode(Cs)];
encode([C = $! | Cs]) ->
  [C | encode(Cs)];
encode([C = $~ | Cs]) ->
  [C | encode(Cs)];
encode([C = $* | Cs]) ->
  [C | encode(Cs)];
encode([C = 39 | Cs]) -> % '
  [C | encode(Cs)];
encode([C = $( | Cs]) ->
  [C | encode(Cs)];
encode([C = $) | Cs]) ->
  [C | encode(Cs)];

encode([C | Cs]) when C =< 16#7f ->
  escape_byte(C)
  ++ encode(Cs);
  
encode([C | Cs]) when (C >= 16#7f) and (C =< 16#07FF) ->
  escape_byte((C bsr 6) + 16#c0)
  ++ escape_byte(C band 16#3f + 16#80)
  ++ encode(Cs);

encode([C | Cs]) when (C > 16#07FF) ->
  escape_byte((C bsr 12) + 16#e0) % (0xe0 | C >> 12)
  ++ escape_byte((16#3f band (C bsr 6)) + 16#80) % 0x80 | ((C >> 6) & 0x3f)
  ++ escape_byte(C band 16#3f + 16#80) % 0x80 | (C >> 0x3f)
  ++ encode(Cs);

encode([C | Cs]) ->
  escape_byte(C) ++ encode(Cs);

encode([]) -> [].

% from edoc_lib source
hex_octet(N) when N =< 9 ->
    [$0 + N];
hex_octet(N) when N > 15 ->
    hex_octet(N bsr 4) ++ hex_octet(N band 15);
hex_octet(N) ->
    [N - 10 + $a].

escape_byte(C) ->
  H = hex_octet(C),
  normalize(H).

%% Append 0 if length == 1
normalize(H) when length(H) == 1 ->
  "%0" ++ H;

normalize(H) ->
  "%" ++ H.
