defmodule ClientHtml.Impl.HangmanView do
  use ClientHtml.Impl, :view

  defdelegate render_hangman(turns_left), to: ClientHtml.Impl.HangmanHelpers

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
