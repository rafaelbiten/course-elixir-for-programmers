defmodule Hangman do
  @moduledoc """
  The public API of the Hangman game
  """

  use Agent
  alias Hangman.Impl.Game

  @type tally :: Game.public_tally()

  @spec new_game() :: {:error, any} | {:ok, pid()}
  def new_game, do: Agent.start_link(fn -> Game.new_game() end)

  @spec make_move(pid(), String.t()) :: tally
  def make_move(pid, guess) do
    Agent.update(pid, fn game -> Game.make_move(game, guess) end)
    get_tally(pid)
  end

  @spec get_tally(pid()) :: tally
  def get_tally(pid) do
    Agent.get(pid, fn game -> Game.to_public_tally(game) end)
  end

  @spec end_game(pid()) :: :ok
  def end_game(pid), do: Agent.stop(pid)
end
