defmodule Hangman do
  @moduledoc """
  The public API of the Hangman game
  """

  alias Hangman.Impl.Game

  @spec new_game() :: Game.t()
  defdelegate new_game, to: Game

  @spec make_move(Game.t(), String.t()) :: Game.t()
  defdelegate make_move(game, guess), to: Game
end
