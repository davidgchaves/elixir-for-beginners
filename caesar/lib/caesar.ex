defmodule Caesar do
  def main(argv) do
    argv
      |> parse_args
    System.halt(0)
  end

  def parse_args(argv) do
    parse = OptionParser.parse(argv, switches: [help: :boolean])
    case parse do
      {[help: true], _, _} -> {:help}
      {_           , _, _} -> {:help}
    end
  end
end
