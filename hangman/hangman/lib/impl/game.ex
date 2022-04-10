defmodule Hangman.Impl.Game do
  @moduledoc """
  The implementation of the Hangman game
  """

  @type t :: %__MODULE__{
          game_state: Hangman.state(),
          turns_left: integer,
          letters: list(String.t()),
          used: MapSet.t(String.t())
        }

  defstruct game_state: :initial,
            turns_left: 7,
            letters: [],
            used: MapSet.new()

  def new_game do
    %__MODULE__{letters: Dictionary.random_word() |> String.codepoints()}
  end
end
