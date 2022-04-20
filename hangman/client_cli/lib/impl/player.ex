defmodule ClientCli.Impl.Player do
  @typep tally :: Hangman.tally()

  @spec start() :: :ok
  def start() do
    {:ok, game_pid} = Hangman.new_game()
    interact(game_pid, Hangman.get_tally(game_pid))
    Hangman.end_game(game_pid)
  end

  @spec interact(pid(), tally) :: :ok
  defp interact(_game_pid, tally = %{state: :won}) do
    IO.puts("You won! The word is #{Enum.join(tally.hangman)}!")
  end

  defp interact(_game_pid, _tally = %{state: :lost}) do
    IO.puts("And you lost... :(")
  end

  defp interact(game_pid, tally) do
    IEx.Helpers.clear()
    print_state(tally)
    print_hangman(tally)

    guess = prompt_for_guess()
    tally = Hangman.make_move(game_pid, guess)
    interact(game_pid, tally)
  end

  @spec print_state(tally) :: :ok
  defp print_state(tally) do
    IO.puts(
      case(tally.state) do
        :initial -> "Try to guess this #{Enum.count(tally.hangman)} letters word!"
        :bad_guess -> "Nope, try another letter!"
        :repeated_guess -> "Nope, try a not yet played letter!"
        :good_guess -> "Good guess!"
      end
    )
  end

  @spec print_hangman(tally) :: :ok
  defp print_hangman(tally) do
    IO.puts([
      IO.ANSI.light_green() <> "Hangman: #{Enum.join(tally.hangman)} \n" <> IO.ANSI.reset(),
      "Turns left: #{to_string(tally.turns_left)} \n",
      "Letters used: [#{Enum.join(tally.used_letters, ", ")}]"
    ])
  end

  @spec prompt_for_guess() :: String.t()
  defp prompt_for_guess do
    IO.gets("Enter a letter: ")
    |> String.trim()
    |> String.downcase()
    |> String.slice(0, 1)
  end
end
