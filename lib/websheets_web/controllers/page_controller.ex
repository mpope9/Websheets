defmodule WebsheetsWeb.PageController do
  use WebsheetsWeb, :controller

  def index(conn, _params) do
    render conn, "index.html"
  end
end
