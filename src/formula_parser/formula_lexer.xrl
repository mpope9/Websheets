Definitions.

INT        = [0-9]+
FLOAT      = [0-9]\.[0-9]+
CELL       = [a-zA-Z]+[0-9]+
SUM        = SUM|sum
APPLY      = APPLY|apply
WHITESPACE = [\s\t\n\r]

Rules.

% Terminals
\=              : {token, {'=', TokenLine}}.
{CELL}          : {token, {string, TokenLine, TokenChars}}.
{INT}           : {token, {int, TokenLine, list_to_integer(TokenChars)}}.
{FLOAT}         : {token, {float, TokenLine, floatize(TokenChars)}}.
\:              : {token, {':', TokenLine}}.
\(              : {token, {'(', TokenLine}}.
\)              : {token, {')', TokenLine}}.
,               : {token, {',', TokenLine}}.

% Formula
{SUM}           : {token, {atom, TokenLine, atomize(TokenChars)}}.
{APPLY}         : {token, {atom, TokenLine, atomize(TokenChars)}}.

{WHITESPACE}+   : skip_token.

Erlang code.

atomize(Chars) ->
        list_to_atom(string:lowercase(Chars)).

floatize(Chars) ->
        {Float, _} = string:to_float(Chars),
        Float.
