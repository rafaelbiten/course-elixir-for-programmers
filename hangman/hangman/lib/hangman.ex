defmodule Hangman do
  alias Hangman.Runtime.Server

  @opaque game :: Server.t()
  @type tally :: Server.public_tally()

  @spec new_game :: game
  def new_game do
    {:ok, game} = Server.start_link()
    game
  end

  @spec make_move(game, String.t()) :: tally
  defdelegate make_move(game, guess), to: Server

  @spec end_game(game) :: :ok
  defdelegate end_game(game), to: Server
end
