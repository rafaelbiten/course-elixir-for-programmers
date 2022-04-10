defmodule Hangman do
  @moduledoc """
  The public API of the Hangman game
  """

  alias Hangman.Impl.Game

  @type state :: :initial | :won | :lost | :good_guess | :bad_guess | :already_used
  @opaque game :: Game.t()
  @type guess :: String.t()
  @type tally :: %{
          game_state: state,
          turns_left: integer,
          letters: list(String.t()),
          used: list(String.t())
        }

  @spec new_game() :: game
  defdelegate new_game, to: Game

  @spec make_move(game, guess) :: {game, tally}
  def make_move(_game, _guess) do
  end
end
