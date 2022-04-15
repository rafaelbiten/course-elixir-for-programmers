defmodule Hangman.Impl.Game do
  @moduledoc """
  The implementation of the Hangman game
  """

  # Types
  # ===

  @type state :: :initial | :won | :lost | :good_guess | :bad_guess | :repeated_guess

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

  # ===

  @spec new_game() :: t
  def new_game do
    new_game(Dictionary.random_word())
  end

  @spec new_game(String.t()) :: t
  def new_game(word) do
    %__MODULE__{letters: word |> String.codepoints()}
  end

  # ===

  @spec make_move(t, String.t()) :: {t, tally()}
  def make_move(%{state: state} = game, _guess)
      when state in [:won, :lost],
      do: return_game_with_tally(game)

  def make_move(game, guess) do
    repeated_guess? = MapSet.member?(game.used, guess)
    accept_move(game, guess, repeated_guess?)
  end

  # Private fns

  # ===

  @spec accept_move(t, String.t(), boolean()) :: {t, tally()}
  defp accept_move(game, _guess, true = _repeated_guess?) do
    return_game_with_tally(%{game | state: :repeated_guess})
  end

  defp accept_move(game, guess, false = _repeated_guess?) do
    score_move(game, guess)
  end

  # ===

  defp score_move(game, guess) do
    return_game_with_tally(%{game | used: MapSet.put(game.used, guess)})
  end

  # ===

  @spec return_game_with_tally(t) :: tally()
  defp return_game_with_tally(game) do
    {game,
     %{
       state: game.state,
       turns_left: game.turns_left,
       letters: [],
       used: game.used |> MapSet.to_list() |> Enum.sort()
     }}
  end
end
