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

  test "parse_args encrypt" do
    argv = ["encrypt", "abcd", "--shift", "1"]
    assert Caesar.parse_args(argv) == {:encrypt, "abcd", 1}
  end
end
