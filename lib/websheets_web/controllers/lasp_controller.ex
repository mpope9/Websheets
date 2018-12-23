defmodule WebsheetsWeb.LaspController do
  use WebsheetsWeb, :controller

  @gmap_type {:state_gmap, [:state_lwwregister]}

  def create(conn, _params) do
    new_table_id = Ksuid.generate()
  
    {:ok, _} = :lasp.declare({<<"#{new_table_id}">>, @gmap_type}, @gmap_type)

    json conn, %{new_table_id: new_table_id} ## TODO: move to a struct
  end
end
