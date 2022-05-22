defmodule ClientHtml.Impl.HangmanController do
  use ClientHtml.Impl, :controller

  def index(conn, _params) do
    render(conn, "index.html", page_title: "Hangman Game")
  end

  def new(conn, _params) do
    game = Hangman.new_game()
    tally = Hangman.get_tally(game)

    conn
    |> put_session(:game, game)
    |> render("game.html", page_title: "New Hangman Game", tally: tally)
  end

  def update(conn, params) do
    tally =
      conn
      |> get_session(:game)
      |> Hangman.make_move(params["make_move"]["guess"])

    put_in(conn.params["make_move"]["guess"], "")
    |> render("game.html", page_title: "New Hangman Game", tally: tally)
  end

  @spec redirect_to_hangman(Plug.Conn.t(), any) :: Plug.Conn.t()
  def redirect_to_hangman(conn, _params) do
    redirect(conn, to: Routes.hangman_path(conn, :index))
  end
end
