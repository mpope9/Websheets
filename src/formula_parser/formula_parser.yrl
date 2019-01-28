Terminals '(' ')' ':' ',' formula, number, cell.
Nonterminals expression sum_expression adjust_expression range.
Rootsymbol expression.

%% Parser Generator for formulas.

%%%%%%%%%%%%%%%%%%%%%%%
% Terminals
%%%

cell    -> string : extract_token('$1'). %% TODO: Consider making cell a atom?
number  -> int    : extract_token('$1').
formula -> atom   : extract_token('$1').

%%%%%%%%%%%%%%%%%%%%%%%
% Expression Generics
%%%

% TODO: Find row or column range from expression
range -> cell ':' cell : {'$1', '$3'}.

%%%%%%%%%%%%%%%%%%%%%%%
% Valid Formulas
%%%

sum_expression -> formula '(' range ')' : {'$1', '$3'}.

% TODO: logistics of passing in an a generic expression.
adjust_expression -> formula '(' cell ',' range ')'   : {'$1', '$3', '$5'}.
adjust_expression -> formula '(' number ',' range ')' : {'$1', '$3', '$5'}.

%%%%%%%%%%%%%%%%%%%%%%%
% Expressions
%%%

expression -> cell              : '$1'.
expression -> number            : '$1'.
expression -> sum_expression    : '$1'.
expression -> adjust_expression : '$1'.

Erlang code.

extract_token({_Token, _Line, Value}) -> Value.
