defmodule Dictionary.Runtime.Application do
  @moduledoc false

  use Application

  def start(_type, _args) do
    children = [{Dictionary.Runtime.Server, []}]

    options = [
      name: Dictionary.Runtime.Supervisor,
      strategy: :one_for_one,
      max_restarts: 1,
      max_seconds: 5
    ]

    Supervisor.start_link(children, options)
  end
end
