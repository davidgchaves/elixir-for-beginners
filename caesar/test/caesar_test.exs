defmodule CaesarTest do
  use ExUnit.Case
  doctest Caesar

  test "parse_args defaults to help" do
    argv = ["UnkNOWn"]
    assert Caesar.parse_args(argv) == {:help}
  end

  test "parse_args help" do
    argv = ["help"]
    assert Caesar.parse_args(argv) == {:help}
  end
end
