defmodule Raindrops do
  @doc """
  Returns a string based on raindrop factors.

  - If the number contains 3 as a prime factor, output 'Pling'.
  - If the number contains 5 as a prime factor, output 'Plang'.
  - If the number contains 7 as a prime factor, output 'Plong'.
  - If the number does not contain 3, 5, or 7 as a prime factor,
    just pass the number's digits straight through.
  """
  @spec convert(pos_integer) :: String.t()
  def convert(number) do
    number |> conv() |> Enum.join()
  end

  defguardp can_div(dividend, divisor) when rem(dividend, divisor) === 0
  defp conv(num), do: conv(num, false)
  defp conv(num, _) when can_div(num, 3), do: ["Pling" | conv(divide_out(num, 3), true)]
  defp conv(num, _) when can_div(num, 5), do: ["Plang" | conv(divide_out(num, 5), true)]
  defp conv(num, _) when can_div(num, 7), do: ["Plong" | conv(divide_out(num, 7), true)]
  defp conv(num, false), do: [Integer.to_string(num)]
  defp conv(_, true), do: []

  defp divide_out(dividend, divisor) when not can_div(dividend, divisor), do: dividend
  defp divide_out(dividend, divisor), do: divide_out(div(dividend, divisor), divisor)
end
