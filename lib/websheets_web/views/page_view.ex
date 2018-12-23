defmodule WebsheetsWeb.PageView do
  @moduledoc """
  Generates HTML.  DO NOT INCLUDE USER DATA HERE.
  """
  use WebsheetsWeb, :view

  @ascii_a 0
  @row_id_prefix "r"
  @input_id_prefix "i"

  ## TODO pass a keywork list like [class: "test"]
  def generate_front_cap(type, id_prefix, number) do
    id_string = cond do
      id_prefix != nil -> " id=#{id_prefix}#{number}"
      true -> ""
    end

    << "<" >> <> type <> id_string <> << ">" >>
  end

  def generate_front_cap(type) do
    << "<" >> <> type <> << ">" >>
  end

  def generate_end_cap(type) do
    << "</" >> <> type <> << ">" >>
  end

  def generate_rows(type, amount, id_prefix) do
    rows = for key <- 0..amount, into: "" do
      front_cap = generate_front_cap(type, @row_id_prefix <> id_prefix, key)
      input_boxes = << "<input class=\"text_input\" id=\"#{@input_id_prefix}#{id_prefix}#{key}\" type=\"text\"/>" >>
      end_cap = generate_end_cap(type)

      front_cap <> input_boxes <> end_cap
    end
  end

  def generate_rows_incramental_data(type, amount, id_prefix, first_element) do
    rows = for key <- 0..amount, into: "" do
      generate_front_cap(type, id_prefix, key) <>
        << first_element + key >> <>
        generate_end_cap(type)
    end
  end

  def generate_header() do
    front_cap = generate_front_cap("tr")
    rows = generate_rows_incramental_data("th", 4, "head", 97)
    end_cap = generate_end_cap("tr")

    front_cap <> rows <> end_cap
  end

end
