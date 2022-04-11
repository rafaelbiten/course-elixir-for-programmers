defmodule Hangman.Impl.Game do
  @moduledoc """
  The implementation of the Hangman game
  """

  # Types
  # --------------------------------------------------

  @type state :: :initial | :won | :lost | :good_guess | :bad_guess | :already_used

  @type tally :: %{
          state: Game.state(),
          turns_left: integer,
          letters: list(String.t()),
          used: list(String.t())
        }

  @opaque t :: %__MODULE__{
            state: state,
            turns_left: integer,
            letters: list(String.t()),
            used: MapSet.t(String.t())
          }

  defstruct state: :initial,
            turns_left: 7,
            letters: [],
            used: MapSet.new()

  # New Game
  # --------------------------------------------------

  @spec new_game() :: t
  def new_game do
    new_game(Dictionary.random_word())
  end

  @spec new_game(String.t()) :: t
  def new_game(word) do
    %__MODULE__{letters: word |> String.codepoints()}
  end

  # Make Move
  # --------------------------------------------------
  @spec make_move(t, String.t()) :: {t, tally()}
  def make_move(game = %{state: state}, _guess) when state in [:won, :lost] do
    {game, tally(game)}
  end

  @spec tally(t) :: tally()
  defp tally(game) do
    %{
      state: game.state,
      turns_left: game.turns_left,
      letters: [],
      used: game.used |> MapSet.to_list() |> Enum.sort()
    }
  end
end
