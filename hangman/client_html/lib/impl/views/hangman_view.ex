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

  def render_hangman(turns_left) when turns_left >= 0 and turns_left <= 7 do
    @hangman_figures_by_turns_left[turns_left]
  end

  def render_controls(conn, state) when state in [:won, :lost] do
    button("Play Again", to: Routes.hangman_path(conn, :new))
  end

  def render_controls(conn, _state) do
    form_for(
      conn,
      Routes.hangman_path(conn, :update),
      [as: "make_move", method: :put],
      fn form ->
        [
          text_input(form, :guess,
            autofocus: true,
            pattern: "^[a-zA-Z]{1}$",
            placeholder: "enter a single letter",
            oninvalid: "setCustomValidity('enter a single letter')",
            oninput: "setCustomValidity('')",
            class: "hangman_input_letter"
          ),
          submit("Submit guess")
        ]
      end
    )
  end
end
