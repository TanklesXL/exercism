defmodule TwelveDays do
  @lyrics %{
    1 => {"first", "a Partridge in a Pear Tree"},
    2 => {"second", "two Turtle Doves"},
    3 => {"third", "three French Hens"},
    4 => {"fourth", "four Calling Birds"},
    5 => {"fifth", "five Gold Rings"},
    6 => {"sixth", "six Geese-a-Laying"},
    7 => {"seventh", "seven Swans-a-Swimming"},
    8 => {"eighth", "eight Maids-a-Milking"},
    9 => {"ninth", "nine Ladies Dancing"},
    10 => {"tenth", "ten Lords-a-Leaping"},
    11 => {"eleventh", "eleven Pipers Piping"},
    12 => {"twelfth", "twelve Drummers Drumming"}
  }

  @spec line_start(number :: non_neg_integer) :: String.t()
  defp line_start(number) do
    with {num, _gift} <- Map.get(@lyrics, number) do
      "On the #{num} day of Christmas my true love gave to me: "
    end
  end

  @spec line_end(number :: non_neg_integer) :: String.t()
  defp line_end(number) do
    number..1
    |> Enum.map(fn num -> Map.get(@lyrics, num) |> elem(1) end)
    |> singing_join()
  end

  @spec singing_join([String.t()]) :: String.t()
  defp singing_join([h]), do: h <> "."
  defp singing_join([h | t] = list) when length(list) === 2, do: h <> ", and " <> singing_join(t)
  defp singing_join([h | t]), do: h <> ", " <> singing_join(t)

  @doc """
  Given a `number`, return the song's verse for that specific day, including
  all gifts for previous days in the same line.
  """
  @spec verse(number :: integer) :: String.t()
  def verse(number) do
    line_start(number) <> line_end(number)
  end

  @doc """
  Given a `starting_verse` and an `ending_verse`, return the verses for each
  included day, one per line.
  """
  @spec verses(starting_verse :: integer, ending_verse :: integer) :: String.t()
  def verses(starting_verse, ending_verse) do
    starting_verse..ending_verse
    |> Enum.map(&verse/1)
    |> Enum.join("\n")
  end

  @doc """
  Sing all 12 verses, in order, one verse per line.
  """
  @spec sing() :: String.t()
  def sing do
    verses(1, 12)
  end
end
