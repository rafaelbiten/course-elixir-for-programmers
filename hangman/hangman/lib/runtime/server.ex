defmodule Hangman.Runtime.Server do
  use GenServer

  alias Hangman.Impl.Game

  @type t :: pid()
  @type public_tally :: Game.public_tally()
  @typep game_pid :: t

  # Client

  def start_link do
    GenServer.start_link(__MODULE__, nil)
  end

  @spec make_move(game_pid, String.t()) :: term
  def make_move(game_pid, guess) do
    GenServer.call(game_pid, {:make_move, guess})
  end

  @spec end_game(game_pid) :: :ok
  def end_game(game_pid) do
    GenServer.stop(game_pid)
  end

  # Server (callbacks)

  @impl true
  def init(_args) do
    {:ok, Game.new_game()}
  end

  @impl true
  def handle_call({:make_move, guess}, _from, game) do
    game = Game.make_move(game, guess)
    {:reply, Game.to_public_tally(game), game}
  end
end