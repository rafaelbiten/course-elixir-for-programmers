defmodule ClientHtml.Impl.HangmanController do
  use ClientHtml.Impl, :controller

  def index(conn, _params) do
    render(conn, "index.html", page_title: "Hangman Game")
  end

  def redirect_to_hangman(conn, _params) do
    redirect(conn, to: Routes.hangman_path(conn, :index))
  end
end
