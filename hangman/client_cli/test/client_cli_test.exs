defmodule ClientCliTest do
  use ExUnit.Case
  doctest ClientCli

  test "greets the world" do
    assert ClientCli.hello() == :world
  end
end
