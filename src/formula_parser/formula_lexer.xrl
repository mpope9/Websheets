Definitions.

INT             = [0-9]+
CELL            = [a-zA-Z][0-9]+
SUM		= SUM
WHITESPACE      = [\s\t\n\r]

Rules.

% Terminals
\=              : {token, {'=', TokenLine}}.
{CELL}         	: {token, {string, TokenLine, TokenChars}}.
{INT}          	: {token, {int, TokenLine, list_to_integer(TokenChars)}}.
\:              : {token, {':', TokenLine}}.
\(              : {token, {'(', TokenLine}}.
\)              : {token, {')', TokenLine}}.
,               : {token, {',', TokenLine}}.

% Formula
{SUM}           : {token, {atom, TokenLine, to_atom(TokenChars)}}.
{ADJ}           : {token, {atom, TokenLine, to_atom(TokenChars)}}.

{WHITESPACE}+  	: skip_token.

Erlang code.

to_atom(Chars) ->
	list_to_atom(string:lowercase(Chars))
