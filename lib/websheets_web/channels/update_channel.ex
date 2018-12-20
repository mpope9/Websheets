defmodule ClientUpdate do
  defstruct [:body, :input_id]
end

defmodule WebsheetsWeb.UpdateChannel do
  use Phoenix.Channel
  require Logger

  def join("spreadsheet:" <> spreadsheet_id, _message, socket) do
    Logger.info "Recieved connection for table: #{spreadsheet_id}"
    ## TODO: send current status to connected client.
    {:ok, socket}
  end

  @spec handle_in(String.t, ClientUpdate.t, Phoenix.Socket.t) :: {atom, Phoenix.Socket.t}
  def handle_in("client_update", payload, socket) do
    client_update = struct(ClientUpdate, payload)
    Logger.info "Recieved body: #{client_update.body}"
    # TODO: Write to lasp here.
    {:noreply, socket}
  end
end
