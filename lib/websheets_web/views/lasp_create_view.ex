defmodule WebsheetsWeb.LaspCreateView do
  @moduledoc """
  Generates json with the creation info.
  """
  use WebsheetsWeb, :view

  def render("index.json", %{new_table_id: new_table_id}) do
    %{
      new_table_id: new_table_id
    }
  end
end
