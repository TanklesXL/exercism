defmodule BeerSong do
  @doc """
  Get a single verse of the beer song
  """

  @spec verse(integer) :: String.t()
  def verse(number) do
    "#{first_line(number)}\n#{second_line(number)}\n"
  end

  defp first_line(num) do
    "#{current(num, false)} of beer on the wall, #{current(num, true)} of beer."
  end

  defp second_line(num) do
    second_line_start(num) <> ", #{next(num)} of beer on the wall."
  end

  defp second_line_start(0), do: "Go to the store and buy some more"
  defp second_line_start(1), do: "it" |> take_and_pass()
  defp second_line_start(_num), do: "one" |> take_and_pass()

  defp take_and_pass(num), do: "Take #{num} down and pass it around"

  defp next(0), do: current(99, true)
  defp next(num), do: current(num - 1, true)

  defp current(num, downcase) do
    num
    |> case do
      0 -> "No more bottles"
      1 -> "1 bottle"
      _ -> to_string(num) <> " bottles"
    end
    |> (&((!downcase && &1) || String.downcase(&1))).()
  end

  @doc """
  Get the entire beer song for a given range of numbers of bottles.
  """

  @spec lyrics() :: String.t()
  def lyrics(), do: lyrics(99..0)

  @spec lyrics(Range.t()) :: String.t()
  def lyrics(range) do
    range
    |> Enum.map(&verse/1)
    |> Enum.join("\n")
  end
end
