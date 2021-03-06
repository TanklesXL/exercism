defmodule Markdown do
  @doc ~S"""
    Parses a given string with Markdown syntax and returns the associated HTML for that string.

    ## Examples

      iex> Markdown.parse("This is a paragraph")
      "<p>This is a paragraph</p>"

      iex> Markdown.parse("# Header!\n* __Bold Item__\n* _Italic Item_")
      "<h1>Header!</h1><ul><li><strong>Bold Item</strong></li><li><em>Italic Item</em></li></ul>"

      iex> Markdown.parse("## Header2!\n___Bold and italic item___")
      "<h2>Header2!</h2><p><strong><em>Bold and italic item</em></strong></p>"
  """
  @spec parse(String.t()) :: String.t()
  def parse(m) do
    m
    |> String.split("\n")
    |> Task.async_stream(&process_line/1)
    |> Enum.reduce("", fn {:ok, line}, acc -> acc <> line end)
    |> patch_lists()
  end

  defp process_line(t = "#" <> _rest), do: build_header(t)
  defp process_line("* " <> rest), do: format_and_enclose_with_tag(rest, "li")
  defp process_line(t), do: format_and_enclose_with_tag(t, "p")

  defp build_header(header) do
    [h, t] = String.split(header, " ", parts: 2)
    suround_with_tag(t, "h#{String.length(h)}")
  end

  defp format_and_enclose_with_tag(s, tag) do
    s
    |> String.split(" ")
    |> Stream.map(&replace_md_with_tag/1)
    |> Enum.join(" ")
    |> suround_with_tag(tag)
  end

  defp suround_with_tag(s, tag), do: "<#{tag}>#{s}</#{tag}>"

  defp replace_md_with_tag(w) do
    w
    |> format_prefix()
    |> format_suffix()
  end

  defp format_prefix("__" <> rest), do: "<strong>" <> format_prefix(rest)
  defp format_prefix("_" <> rest), do: "<em>" <> format_prefix(rest)
  defp format_prefix(word), do: word

  defp format_suffix(word) do
    word
    |> String.reverse()
    |> format_reversed_suffix()
    |> String.reverse()
  end

  defp format_reversed_suffix("__" <> rest) do
    String.reverse("</strong>") <> format_reversed_suffix(rest)
  end

  defp format_reversed_suffix("_" <> rest) do
    String.reverse("</em>") <> format_reversed_suffix(rest)
  end

  defp format_reversed_suffix(word), do: word

  defp patch_lists(l) do
    l
    |> String.replace("<li>", "<ul>" <> "<li>", global: false)
    |> String.replace_suffix("</li>", "</li>" <> "</ul>")
  end
end
