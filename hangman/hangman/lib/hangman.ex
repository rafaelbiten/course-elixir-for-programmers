defmodule Hangman do
  @moduledoc false

  alias Hangman.Runtime.Server

  @type game :: Server.t()
  @type tally :: Server.public_tally()

  @spec new_game :: game
  def new_game do
    {:ok, game} = Hangman.Runtime.Application.start_game()
    game
  end

  @spec make_move(game, String.t()) :: tally
  defdelegate make_move(game, guess), to: Server

  @spec get_tally(game) :: tally
  defdelegate get_tally(game), to: Server

  @spec end_game(game) :: :ok
  defdelegate end_game(game), to: Server
end
