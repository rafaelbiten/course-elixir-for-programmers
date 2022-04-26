defmodule Hangman.Runtime.Application do
  @moduledoc false

  use Application

  @name Hangman.Runtime.DynamicSupervisor

  def start(_type, _args) do
    supervisor_spec = [
      {
        DynamicSupervisor,
        name: @name, strategy: :one_for_one
      }
    ]

    Supervisor.start_link(supervisor_spec, strategy: :one_for_one)
  end

  def start_game do
    DynamicSupervisor.start_child(@name, {Hangman.Runtime.Server, nil})
  end
end
