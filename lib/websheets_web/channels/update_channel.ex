defmodule ClientUpdate do
  defstruct [:body, :input_id, :table_id]
end

defmodule WebsheetsWeb.UpdateChannel do
  use Phoenix.Channel
  require Logger

  @lasp_table :lasp_table
  @gmap_type {:state_gmap, [:state_lwwregister]}

  def join("spreadsheet:" <> spreadsheet_id, _message, socket) do
    Logger.info "Recieved connection for table: #{spreadsheet_id}"
    ## TODO: send current status to connected client.
    {:ok, socket}
  end

  @spec handle_in(String.t, ClientUpdate.t, Phoenix.Socket.t) :: {atom, Phoenix.Socket.t}
  def handle_in("client_update", payload, socket) do
    ## TODO: move to struct, and get the table id a different day
    %{"body" => test_body, "input_id" => test_input_id, "table_id" => test_table_id} = payload
    Logger.info "Recieved body: #{test_body}"

    timestamp = :erlang.unique_integer([:monotonic, :positive])
    ##table = {<<"#{client_update.table_id}">>, @gmap_type}
    table = {<<"#{test_table_id}">>, @gmap_type}
    {:ok, {updated_table, _, _, _}} = :lasp.update(table, {:apply, test_input_id,
                                                  {:set, timestamp, test_body}}, self())
    broadcast!(socket, "server_update", %{input_id: test_input_id, body: test_body})
    {:noreply, socket}
  end
end
