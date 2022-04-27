defmodule Hangman.Runtime.Server do
  @moduledoc false

  use GenServer

  alias Hangman.Impl.Game

  @type t :: pid()
  @type public_tally :: Game.public_tally()
  @typep game_pid :: t

  # Client

  @spec start_link(any) :: {:error, any} | {:ok, t}
  def start_link(_args) do
    IO.puts("Starting a new game!")
    GenServer.start_link(__MODULE__, nil)
  end

  @spec make_move(game_pid, String.t()) :: public_tally
  def make_move(game_pid, guess) do
    GenServer.call(game_pid, {:make_move, guess})
  end

  @spec get_tally(game_pid) :: public_tally
  def get_tally(game_pid) do
    GenServer.call(game_pid, {:get_tally})
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

  @impl true
  def handle_call({:get_tally}, _from, game) do
    {:reply, Game.to_public_tally(game), game}
  end
end
