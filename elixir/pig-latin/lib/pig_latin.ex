defmodule PigLatin do
  @doc """
  Given a `phrase`, translate it a word at a time to Pig Latin.

  Words beginning with consonants should have the consonant moved to the end of
  the word, followed by "ay".

  Words beginning with vowels (aeiou) should have "ay" added to the end of the
  word.

  Some groups of letters are treated like consonants, including "ch", "qu",
  "squ", "th", "thr", and "sch".

  Some groups are treated like vowels, including "yt" and "xr".
  """
  @spec translate(phrase :: String.t()) :: String.t()
  def translate(phrase) do
    phrase
    |> String.split()
    |> Enum.map(&pigify/1)
    |> Enum.join(" ")
  end

  @vowels ["a", "e", "i", "o", "u", "yt", "xr", "xb", "yd"]
  @consonant_groups ["sch", "thr", "squ", "ch", "th", "qu"]

  defp pigify(word) do
    prefix =
      Enum.concat(@vowels, @consonant_groups)
      |> Enum.find(&String.starts_with?(word, &1))

    cond do
      prefix in @vowels ->
        word <> "ay"

      prefix in @consonant_groups ->
        rest = word |> String.trim_leading(prefix)
        rest <> prefix <> "ay"

      true ->
        prefix = word |> String.split("") |> get_leading_consonants() |> to_string()
        rest = word |> String.trim_leading(prefix)
        rest <> prefix <> "ay"
    end
  end

  defp get_leading_consonants([]), do: []

  defp get_leading_consonants([h | t]) do
    cond do
      h not in @vowels -> [h | get_leading_consonants(t)]
      true -> []
    end
  end
end
