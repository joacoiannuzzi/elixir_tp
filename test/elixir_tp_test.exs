defmodule ElixirTpTest do
  use ExUnit.Case
  doctest ElixirTp

  test "greets the world" do
    assert ElixirTp.hello() == :world
  end
end
