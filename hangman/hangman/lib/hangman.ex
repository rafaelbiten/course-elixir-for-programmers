defmodule Hangman do
  @moduledoc """
  The public API of the Hangman game
  """

  alias Hangman.Impl.Game

  defdelegate new_game, to: Game

  defdelegate make_move(game, guess), to: Game
end
