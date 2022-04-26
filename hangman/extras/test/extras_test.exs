defmodule ExtrasTest do
  use ExUnit.Case
  doctest Extras

  test "greets the world" do
    assert Extras.hello() == :world
  end
end
