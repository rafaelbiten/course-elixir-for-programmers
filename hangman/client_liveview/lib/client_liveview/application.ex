defmodule ClientLiveview.Application do
  # See https://hexdocs.pm/elixir/Application.html
  # for more information on OTP Applications
  @moduledoc false

  use Application

  @impl true
  def start(_type, _args) do
    children = [
      # Start the Telemetry supervisor
      ClientLiveviewWeb.Telemetry,
      # Start the PubSub system
      {Phoenix.PubSub, name: ClientLiveview.PubSub},
      # Start the Endpoint (http/https)
      ClientLiveviewWeb.Endpoint
      # Start a worker by calling: ClientLiveview.Worker.start_link(arg)
      # {ClientLiveview.Worker, arg}
    ]

    # See https://hexdocs.pm/elixir/Supervisor.html
    # for other strategies and supported options
    opts = [strategy: :one_for_one, name: ClientLiveview.Supervisor]
    Supervisor.start_link(children, opts)
  end

  # Tell Phoenix to update the endpoint configuration
  # whenever the application is updated.
  @impl true
  def config_change(changed, _new, removed) do
    ClientLiveviewWeb.Endpoint.config_change(changed, removed)
    :ok
  end
end
