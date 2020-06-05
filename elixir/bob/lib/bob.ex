defmodule Bob do
  def hey(input) do
    input = String.trim(input)

    cond do
      "" === input ->
        "Fine. Be that way!"

      upcase?(input) and question?(input) ->
        "Calm down, I know what I'm doing!"

      question?(input) ->
        "Sure."

      upcase?(input) ->
        "Whoa, chill out!"

      true ->
        "Whatever."
    end
  end

  defp question?(input), do: String.ends_with?(input, "?")
  defp upcase?(input), do: input === String.upcase(input) and input !== String.downcase(input)
end
