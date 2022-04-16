defmodule HangmanGameTest do
  use ExUnit.Case
  alias Hangman.Impl.Game

  describe "new_game" do
    test "returns a valid initial Hangman game struct" do
      assert %Game{
               state: :initial,
               turns_left: 7,
               used_letters: %MapSet{},
               letters: ~w(s e c r e t)
             } = Game.new_game("secret")
    end

    test "letters uses only lower-case ASCII characters" do
      Game.new_game()
      |> Map.get(:letters)
      |> Enum.map(fn letter -> String.to_charlist(letter) |> hd end)
      |> Enum.each(fn character -> assert character in ?a..?z end)
    end
  end

  describe "make_move" do
    test "won't change state if state is :won or :lost" do
      for state <- [:won, :lost] do
        Game.new_game("secret")
        |> Map.put(:state, state)
        |> tap(fn end_game ->
          end_game
          |> Game.make_move("z")
          |> tap(fn attempted_move -> assert ^end_game = attempted_move end)
        end)
      end
    end

    test "set state to :repeated_guess on duplicated guesses" do
      Game.new_game()
      |> Game.make_move("x")
      |> tap(fn game -> refute game.state === :repeated_guess end)
      |> Game.make_move("z")
      |> tap(fn game -> refute game.state === :repeated_guess end)
      |> Game.make_move("x")
      |> tap(fn game -> assert game.state === :repeated_guess end)
    end

    test "set state to :bad_guess on bad guesses" do
      Game.new_game("secret")
      |> Game.make_move("e")
      |> tap(fn game -> refute game.state === :bad_guess end)
      |> Game.make_move("y")
      |> tap(fn game -> assert game.state === :bad_guess end)
      |> Game.make_move("t")
      |> tap(fn game -> refute game.state === :bad_guess end)
      |> Game.make_move("z")
      |> tap(fn game -> assert game.state === :bad_guess end)
    end

    test "set state to :good_guess on good guesses" do
      Game.new_game("secret")
      |> Game.make_move("y")
      |> tap(fn game -> refute game.state === :good_guess end)
      |> Game.make_move("e")
      |> tap(fn game -> assert game.state === :good_guess end)
      |> Game.make_move("z")
      |> tap(fn game -> refute game.state === :good_guess end)
      |> Game.make_move("t")
      |> tap(fn game -> assert game.state === :good_guess end)
    end

    test "set state to :lost when turns_left reaches 0 on a :bad_guess" do
      Game.new_game("secret")
      |> tap(fn initial_game ->
        initial_game
        |> Game.make_move("a")
        |> tap(fn game -> assert game.turns_left === initial_game.turns_left - 1 end)
        |> Map.put(:turns_left, 1)
        |> Game.make_move("z")
        |> tap(fn game -> assert %{state: :lost, turns_left: 0} = game end)
      end)
    end

    test "set state to :won when all letters are discovered on a :good_guess" do
      Game.new_game("win")
      |> Game.make_move("w")
      |> Game.make_move("i")
      |> Game.make_move("n")
      |> tap(fn game -> assert %{state: :won, turns_left: 7} = game end)
    end

    test "keep track of guesses within used_letters" do
      Game.new_game()
      |> Game.make_move("x")
      |> Game.make_move("y")
      |> Game.make_move("x")
      |> Game.make_move("z")
      |> tap(fn game -> assert MapSet.equal?(game.used_letters, MapSet.new(["x", "y", "z"])) end)
    end
  end

  describe "to_public_tally" do
    test "omits the game letters to be guessed" do
      Game.new_game("secret")
      |> Game.to_public_tally()
      |> tap(fn tally -> refute Map.has_key?(tally, :letters) end)
    end

    test "only reveals the letters already guessed" do
      Game.new_game("secret")
      |> Game.make_move("x")
      |> Game.make_move("e")
      |> Game.make_move("z")
      |> Game.make_move("r")
      |> Game.to_public_tally()
      |> tap(fn tally -> assert ~w(_ e _ r e _) = tally.hangman end)
    end

    test "returns the expected tally for a :won game" do
      Game.new_game("secret")
      |> Game.make_move("x")
      |> Game.make_move("e")
      |> Game.make_move("z")
      |> Game.make_move("r")
      |> Game.make_move("s")
      |> Game.make_move("e")
      |> Game.make_move("a")
      |> Game.make_move("c")
      |> Game.make_move("t")
      |> Game.to_public_tally()
      |> tap(fn tally ->
        assert %{
                 state: :won,
                 turns_left: 4,
                 used_letters: ~w(a c e r s t x z),
                 hangman: ~w(s e c r e t)
               } === tally
      end)
    end

    test "returns the expected tally for a :lost game" do
      Game.new_game("secret")
      |> Game.make_move("a")
      |> Game.make_move("b")
      |> Game.make_move("c")
      |> Game.make_move("d")
      |> Game.make_move("e")
      |> Game.make_move("f")
      |> Game.make_move("g")
      |> Game.make_move("h")
      |> Game.make_move("i")
      |> Game.make_move("j")
      |> Game.make_move("h")
      |> Game.to_public_tally()
      |> tap(fn tally ->
        assert %{
                 state: :lost,
                 turns_left: 0,
                 used_letters: ~w(a b c d e f g h i),
                 hangman: ~w(_ e c _ e _)
               } === tally
      end)
    end
  end
end
