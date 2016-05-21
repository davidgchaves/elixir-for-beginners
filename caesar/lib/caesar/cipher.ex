defmodule Caesar.Cipher do
  require Logger

  @alphabet_size Application.get_env(:caesar, :alphabet_size)

  @moduledoc """
  Caesar Cipher module, encrypting your messages FTW!
  """

  @doc """
  Encrypt the message by applying a mapping that shifts the alphabet `shift` times.

  ## Examples

      iex> Caesar.Cipher.encrypt "Hello World!", 1
      "Gdkkn Vnqkc!"
  """
  def encrypt(msg, shift) do
    Logger.debug "encrypting \"#{msg}\" with a shift number of: #{shift}"

    msg
      |> to_char_list
      |> Enum.map(&shift_char(&1, shift))
      |> List.to_string
  end

  defp shift_char(char, shift) do
    case char do
      c when c in (?a..?z) -> calculate_mapping(?a, c, shift)
      c when c in (?A..?Z) -> calculate_mapping(?A, c, shift)
      c                    -> c
    end
  end

  defp calculate_mapping(base_letter, char, shift) do
    normalize = &(&1 - @alphabet_size)
    shift_num = rem(shift, @alphabet_size)

    base_letter + rem(char - normalize.(base_letter) - shift_num, @alphabet_size)
  end
end
