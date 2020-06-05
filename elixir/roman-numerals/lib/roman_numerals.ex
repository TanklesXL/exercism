defmodule RomanNumerals do
  @mapping [
    {1000, "M"},
    {900, "CM"},
    {500, "D"},
    {400, "CD"},
    {100, "C"},
    {90, "XC"},
    {50, "L"},
    {40, "XL"},
    {10, "X"},
    {9, "IX"},
    {5, "V"},
    {4, "IV"},
    {1, "I"}
  ]

  @doc """
  Convert the number to a roman number.
  """
  @spec numeral(pos_integer) :: String.t()
  def numeral(number) do
    number
    |> translate()
    |> Enum.join()
  end

  defp translate(number), do: translate(number, @mapping)
  defp translate(_, []), do: []
  defp translate(num, [{k, _v} | t]) when num < k, do: translate(num, t)

  defp translate(num, [{k, v} | t]) do
    mul = div(num, k)
    [String.duplicate(v, mul) | translate(rem(num, k), t)]
  end
end
