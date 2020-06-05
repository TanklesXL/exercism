defmodule RotationalCipher do
  @doc """
  Given a plaintext and amount to shift by, return a rotated string.

  Example:
  iex> RotationalCipher.rotate("Attack at dawn", 13)
  "Nggnpx ng qnja"
  """
  @spec rotate(text :: String.t(), shift :: integer) :: String.t()
  def rotate(text, shift) do
    text
    |> to_charlist()
    |> Enum.map(&do_shift(&1, shift))
    |> to_string()
  end

  @upper ?A..?Z
  @lower ?a..?z

  defguardp is_upper(char) when char in @upper
  defguardp is_lower(char) when char in @lower

  defp do_shift(char, shift) when is_upper(char), do: rem(char - ?A + shift, 26) + ?A
  defp do_shift(char, shift) when is_lower(char), do: rem(char - ?a + shift, 26) + ?a
  defp do_shift(char, _), do: char
end
