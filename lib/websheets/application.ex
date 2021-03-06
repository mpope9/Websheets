defmodule Websheets.Application do
  use Application

  # See https://hexdocs.pm/elixir/Application.html
  # for more information on OTP Applications
  def start(_type, _args) do
    import Supervisor.Spec

    # Define workers and child supervisors to be supervised
    children = [
      # Start the endpoint when the application starts
      supervisor(WebsheetsWeb.Endpoint, [])
    ]

    #create_database()

    # See https://hexdocs.pm/elixir/Supervisor.html
    # for other strategies and supported options
    opts = [strategy: :one_for_one, name: Websheets.Supervisor]
    Supervisor.start_link(children, opts)
  end

  # Tell Phoenix to update the endpoint configuration
  # whenever the application is updated.
  def config_change(changed, _new, removed) do
    WebsheetsWeb.Endpoint.config_change(changed, removed)
    :ok
  end

  # TODO: make this more robust?
  def create_database() do
    :mnesia.create_schema([node()])
    :mnesia.start()
    :mnesia.create_table(:lasp_table, [attributes: [:table_id, :table]])
  end
end
