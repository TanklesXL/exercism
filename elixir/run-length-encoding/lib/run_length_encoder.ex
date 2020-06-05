defmodule RunLengthEncoder do
  @doc """
  Generates a string where consecutive elements are represented as a data value and count.
  "AABBBCCCC" => "2A3B4C"
  For this example, assume all input are strings, that are all uppercase letters.
  It should also be able to reconstruct the data into its original form.
  "2A3B4C" => "AABBBCCCC"
  """
  @spec encode(String.t()) :: String.t()
  def encode(string) do
    string
    |> String.graphemes()
    |> Enum.reduce([], &accumulate/2)
    |> Enum.reduce("", &transcribe/2)
  end

  defp accumulate(next, []), do: [{next, 1}]
  defp accumulate(next, [{next, count} | t]), do: [{next, count + 1} | t]
  defp accumulate(next, acc), do: [{next, 1} | acc]

  defp transcribe({letter, 1}, acc), do: letter <> acc
  defp transcribe({letter, count}, acc), do: "#{count}" <> letter <> acc

  @spec decode(String.t()) :: String.t()
  def decode(string) do
    string
    |> String.graphemes()
    |> Enum.reverse()
    |> Enum.reduce([], &group_by_count/2)
    |> Enum.map(&expand/1)
    |> Enum.join()
  end

  defp group_by_count(char, []), do: [{char}]

  defp group_by_count(char, list = [h | t]) do
    case Integer.parse(char) do
      :error -> [{char} | list]
      {i, _} -> [Tuple.append(h, i) | t]
    end
  end

  defp expand({letter}), do: letter

  defp expand(group) do
    letter = elem(group, 0)

    count =
      group
      |> Tuple.to_list()
      |> Enum.slice(1..-1)
      |> Enum.reverse()
      |> Integer.undigits()

    String.duplicate(letter, count)
  end
end
