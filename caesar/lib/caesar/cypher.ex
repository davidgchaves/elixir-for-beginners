defmodule Caesar.Cypher do
  def encrypt(msg, shift) do
    msg
    |> to_char_list
    |> Enum.map(&shift_char(&1, shift))
    |> List.to_string
  end

  defp shift_char(char, shift) do
    case char do
      c when c in (?a..?z) -> calculate_mapping(?a, c, shift)
      c                    -> c
    end
  end

  defp calculate_mapping(base_letter, char, shift) do
    normalize = &(&1 - 26)
    shift_num = rem(shift, 26)

    base_letter + rem(char - normalize.(base_letter) - shift_num, 26)
  end
end
