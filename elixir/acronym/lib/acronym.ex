defmodule Acronym do
  @doc """
  Generate an acronym from a string.
  "This is a string" => "TIAS"
  """
  @spec abbreviate(String.t()) :: String.t()
  def abbreviate(string) do
    string
    |> to_charlist()
    |> add_spaces()
    |> to_string()
    |> String.split([" ", "-", "_"], trim: true)
    |> Enum.map(&String.at(&1, 0))
    |> to_string()
    |> String.upcase()
  end

  defguardp is_upcase(char) when char in ?A..?Z

  defp add_spaces(charlist, prev_upcase \\ false)
  defp add_spaces([], _), do: []
  defp add_spaces([h | t], true) when is_upcase(h), do: [h, add_spaces(t, true)]
  defp add_spaces([h | t], false) when is_upcase(h), do: [?\s, h, add_spaces(t, true)]
  defp add_spaces([h | t], _), do: [h, add_spaces(t, false)]
end
