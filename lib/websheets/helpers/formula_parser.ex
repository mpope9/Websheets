defmodule FormulaParser do
   @moduledoc """
   A parser for spreadsheets.
   """

   # TODO: Error handling
   @spec parse(binary) :: tuple
   def parse(input) do
      {:ok, tokens, _} = 
        input 
        |> to_charlist
        |> :formula_lexer.string

      {:ok, formula} = :formula_parser.parse(tokens)
      formula
   end
end
