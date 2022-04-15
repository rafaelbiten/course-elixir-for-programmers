defmodule HangmanGameTest do
  use ExUnit.Case
  alias Hangman.Impl.Game

  describe "new_game" do
    test "returns a valid initial Hangman game struct" do
      game = Game.new_game("secret")

      assert %Game{
               state: :initial,
               turns_left: 7,
               used_letters: %MapSet{},
               letters: ~w(s e c r e t)
             } = game
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
        end_game = Game.new_game("secret") |> Map.put(:state, state)
        {attempted_move, _tally} = Game.make_move(end_game, "z")
        assert ^end_game = attempted_move
      end
    end

    test "set state to :repeated_guess on duplicated guesses" do
      game = Game.new_game()

      {game, _tally} = Game.make_move(game, "x")
      assert game.state != :repeated_guess
      {game, _tally} = Game.make_move(game, "z")
      assert game.state != :repeated_guess
      {game, _tally} = Game.make_move(game, "x")
      assert game.state == :repeated_guess
    end

    test "set state to :bad_guess on bad guesses" do
      game = Game.new_game("secret")
      {game, _tally} = Game.make_move(game, "e")
      assert game.state != :bad_guess
      {game, _tally} = Game.make_move(game, "y")
      assert game.state == :bad_guess
      {game, _tally} = Game.make_move(game, "t")
      assert game.state != :bad_guess
      {game, _tally} = Game.make_move(game, "z")
      assert game.state == :bad_guess
    end

    test "set state to :good_guess on good guesses" do
      game = Game.new_game("secret")
      {game, _tally} = Game.make_move(game, "y")
      assert game.state != :good_guess
      {game, _tally} = Game.make_move(game, "e")
      assert game.state == :good_guess
      {game, _tally} = Game.make_move(game, "z")
      assert game.state != :good_guess
      {game, _tally} = Game.make_move(game, "t")
      assert game.state == :good_guess
    end

    test "set state to :lost when turns_left reaches 0" do
      game = Game.new_game("secret")
      {game_after_one_move, _tally} = Game.make_move(game, "a")
      assert game_after_one_move.turns_left == game.turns_left - 1
      {end_game, _tally} = game |> Map.put(:turns_left, 1) |> Game.make_move("z")
      assert %{state: :lost, turns_left: 0} = end_game
    end

    test "keep track of guesses within used_letters" do
      game = Game.new_game()

      {game, _tally} = Game.make_move(game, "x")
      {game, _tally} = Game.make_move(game, "y")
      {game, _tally} = Game.make_move(game, "x")
      {game, _tally} = Game.make_move(game, "z")

      assert MapSet.equal?(game.used_letters, MapSet.new(["x", "y", "z"]))
    end
  end
end
