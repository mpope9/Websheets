Nonterminals root_expression expression sum_expression apply_expression range cell number formula.
Terminals '(' ')' ':' ',' '=' int atom string float.
Rootsymbol root_expression.

%% Parser Generator for formulas.

%%%%%%%%%%%%%%%%%%%%%%%
% Terminals
%%%

cell    -> string : extract_token('$1').
number  -> int    : extract_token('$1').
number  -> float  : extract_token('$1').
formula -> atom   : extract_token('$1').

%%%%%%%%%%%%%%%%%%%%%%%
% Expression Generics
%%%

range -> cell ':' cell     : {'$1', '$3'}.
range -> number ':' number : {'$1', '$3'}.

%%%%%%%%%%%%%%%%%%%%%%%
% Valid Formulas
%%%

sum_expression -> formula '(' range ')' : {'$1', '$3'}.

% TODO: logistics of passing in an a generic expression.
apply_expression -> formula '(' cell ',' range ')'   : {'$1', '$3', '$5'}.
apply_expression -> formula '(' number ',' range ')' : {'$1', '$3', '$5'}.

%%%%%%%%%%%%%%%%%%%%%%%
% Expressions
%%%

expression -> cell              : '$1'.
expression -> number            : '$1'.
expression -> sum_expression    : '$1'.
expression -> apply_expression  : '$1'.

root_expression -> '=' expression : '$2'.

Erlang code.

extract_token({_Token, _Line, Value}) -> Value.
