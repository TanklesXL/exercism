defmodule ResistorColor do
  @moduledoc false

  @spec colors() :: list(String.t())
  def colors do
    ["black", "brown", "red", "orange", "yellow", "green", "blue", "violet", "grey", "white"]
  end

  @spec code(String.t()) :: integer()
  def code(color) do
    colors() |> Enum.find_index(fn col -> col == color end)
  end
end
