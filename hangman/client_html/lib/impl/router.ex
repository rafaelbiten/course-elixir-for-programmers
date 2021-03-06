defmodule ClientHtml.Impl.Router do
  use ClientHtml.Impl, :router

  pipeline :browser do
    plug :accepts, ["html"]
    plug :fetch_session
    plug :fetch_live_flash
    plug :put_root_layout, {ClientHtml.Impl.LayoutView, :root}
    plug :protect_from_forgery
    plug :put_secure_browser_headers
  end

  pipeline :api do
    plug :accepts, ["json"]
  end

  scope "/", ClientHtml.Impl do
    pipe_through :browser

    get "/", HangmanController, :redirect_to_hangman
  end

  scope "/hangman", ClientHtml.Impl do
    pipe_through :browser

    get "/", HangmanController, :index
    post "/", HangmanController, :new
    put "/", HangmanController, :update

    get "/ongoing-game", HangmanController, :show
  end

  # Other scopes may use custom stacks.
  # scope "/api", ClientHtml.Impl do
  #   pipe_through :api
  # end
end
