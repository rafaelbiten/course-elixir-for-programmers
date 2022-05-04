defmodule ClientHtml.Application do
  # See https://hexdocs.pm/elixir/Application.html
  # for more information on OTP Applications
  @moduledoc false

  use Application

  @impl true
  def start(_type, _args) do
    children = [
      # Start the Telemetry supervisor
      ClientHtmlWeb.Telemetry,
      # Start the PubSub system
      {Phoenix.PubSub, name: ClientHtml.PubSub},
      # Start the Endpoint (http/https)
      ClientHtmlWeb.Endpoint
      # Start a worker by calling: ClientHtml.Worker.start_link(arg)
      # {ClientHtml.Worker, arg}
    ]

    # See https://hexdocs.pm/elixir/Supervisor.html
    # for other strategies and supported options
    opts = [strategy: :one_for_one, name: ClientHtml.Supervisor]
    Supervisor.start_link(children, opts)
  end

  # Tell Phoenix to update the endpoint configuration
  # whenever the application is updated.
  @impl true
  def config_change(changed, _new, removed) do
    ClientHtmlWeb.Endpoint.config_change(changed, removed)
    :ok
  end
end
