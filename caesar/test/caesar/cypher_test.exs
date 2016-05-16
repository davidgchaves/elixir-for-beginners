defmodule Caesar.CypherTest do
  use ExUnit.Case
  doctest Caesar.Cypher

  import Caesar.Cypher

  test "encrypt shifts cipher mapping" do
    assert encrypt("abcd", 1) == "zabc"
  end
end
