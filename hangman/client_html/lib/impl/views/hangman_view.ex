defmodule ClientHtml.Impl.HangmanView do
  use ClientHtml.Impl, :view

  @hangman_figures [
    ~S(
    +---+
    |   |
    O   |
   /|\  |
   / \  |
        |
  ========= 7),
    ~S(
    +---+
    |   |
    O   |
   /|\  |
   /    |
        |
  ========= 6),
    ~S(
    +---+
    |   |
    O   |
   /|\  |
        |
        |
  ========= 5),
    ~S(
    +---+
    |   |
    O   |
   /|   |
        |
        |
  ========= 4),
    ~S(
    +---+
    |   |
    O   |
    |   |
        |
        |
  ========= 3),
    ~S(
    +---+
    |   |
    O   |
        |
        |
        |
  ========= 2),
    ~S(
    +---+
    |   |
        |
        |
        |
        |
  ========= 1),
    ~S(
    +---+
        |
        |
        |
        |
        |
  ========= 0)
  ]

  def draw_hangman(turns_left) when turns_left >= 0 and turns_left <= 7 do
    Enum.at(@hangman_figures, turns_left)
  end
end
