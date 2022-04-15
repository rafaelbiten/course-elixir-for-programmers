defmodule HangmanGameTest do
  use ExUnit.Case
  alias Hangman.Impl.Game

  describe "new_game" do
    test "returns a valid initial Hangman game struct" do
      game = Game.new_game("secret")

      assert %Game{
               state: :initial,
               turns_left: 7,
               used: %MapSet{},
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

    test "set state to :repeated_guess for a duplicated guess" do
      game = Game.new_game()

      {game, _tally} = Game.make_move(game, "x")
      assert game.state != :repeated_guess
      {game, _tally} = Game.make_move(game, "z")
      assert game.state != :repeated_guess
      {game, _tally} = Game.make_move(game, "x")
      assert game.state == :repeated_guess
    end

    test "keep track of guesses" do
      game = Game.new_game()

      {game, _tally} = Game.make_move(game, "x")
      {game, _tally} = Game.make_move(game, "y")
      {game, _tally} = Game.make_move(game, "x")
      {game, _tally} = Game.make_move(game, "z")

      assert MapSet.equal?(game.used, MapSet.new(["x", "y", "z"]))
    end
  end
end
