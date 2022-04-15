defmodule Hangman.Impl.Game do
  @moduledoc """
  The implementation of the Hangman game
  """

  defstruct state: :initial,
            turns_left: 7,
            letters: [],
            used_letters: MapSet.new()

  # Types
  # ===

  @type state :: :initial | :won | :lost | :good_guess | :bad_guess | :repeated_guess

  @opaque t :: %__MODULE__{
            state: state,
            turns_left: integer,
            used_letters: MapSet.t(String.t()),
            letters: list(String.t())
          }

  @type public_tally :: %{
          state: state,
          turns_left: integer,
          used_letters: list(String.t()),
          hangman: list(String.t())
        }

  # ===

  @spec new_game() :: t
  def new_game do
    new_game(Dictionary.random_word())
  end

  @spec new_game(String.t()) :: t
  def new_game(word) do
    %__MODULE__{letters: String.codepoints(word)}
  end

  # ===

  @spec make_move(t, String.t()) :: t
  def make_move(%{state: state} = game, _guess)
      when state in [:lost, :won],
      do: return_game_with_state(game, state)

  def make_move(game, guess) do
    case _repeated_guess? = MapSet.member?(game.used_letters, guess) do
      true -> return_game_with_state(game, :repeated_guess)
      false -> accept_move(game, guess)
    end
  end

  # ===

  @spec to_public_tally(t) :: public_tally
  def to_public_tally(game) do
    %{
      state: game.state,
      turns_left: game.turns_left,
      used_letters: game.used_letters |> MapSet.to_list() |> Enum.sort(),
      hangman: []
    }
  end

  # Private fns

  # ===

  @spec accept_move(t, String.t()) :: t
  defp accept_move(game, guess) do
    game_with_accepted_move = %{
      game
      | used_letters: MapSet.put(game.used_letters, guess),
        turns_left: game.turns_left - 1
    }

    case _good_guess? = Enum.member?(game.letters, guess) do
      true -> return_game_with_state(game_with_accepted_move, :good_guess)
      false -> return_game_with_state(game_with_accepted_move, :bad_guess)
    end
  end

  # ===

  @spec return_game_with_state(t, atom) :: t

  defp return_game_with_state(game, :good_guess) do
    case all_letters_discovered?(game) do
      true -> %{game | state: :won}
      false -> %{game | state: :good_guess}
    end
  end

  defp return_game_with_state(%{turns_left: 0} = game, :bad_guess) do
    %{game | state: :lost}
  end

  defp return_game_with_state(game, state) do
    %{game | state: state}
  end

  # ===

  @spec all_letters_discovered?(t) :: boolean
  defp all_letters_discovered?(game) do
    MapSet.subset?(MapSet.new(game.letters), game.used_letters)
  end
end
