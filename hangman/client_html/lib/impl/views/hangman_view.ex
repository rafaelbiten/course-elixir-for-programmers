defmodule ClientHtml.Impl.HangmanView do
  use ClientHtml.Impl, :view

  @hangman_figures_by_turns_left %{
    7 => ~S(
    +---+
        |
        |
        |
        |
        |
  =========),
    6 => ~S(
    +---+
    |   |
        |
        |
        |
        |
  =========),
    5 => ~S(
    +---+
    |   |
    O   |
        |
        |
        |
  =========),
    4 => ~S(
    +---+
    |   |
    O   |
    |   |
        |
        |
  =========),
    3 => ~S(
    +---+
    |   |
    O   |
   /|   |
        |
        |
  =========),
    2 => ~S(
    +---+
    |   |
    O   |
   /|\  |
        |
        |
  =========),
    1 => ~S(
    +---+
    |   |
    O   |
   /|\  |
   /    |
        |
  =========),
    0 => ~S(
    +---+
    |   |
    O   |
   /|\  |
   / \  |
        |
  =========)
  }

  def draw_hangman(turns_left) when turns_left >= 0 and turns_left <= 7 do
    @hangman_figures_by_turns_left[turns_left]
  end
end
