defmodule Strain do
  @doc """
  Given a `list` of items and a function `fun`, return the list of items where
  `fun` returns true.

  Do not use `Enum.filter`.
  """
  @spec keep(list :: list(any), fun :: (any -> boolean)) :: list(any)
  def keep(list, fun) do
    pseudo_filter(list, fun)
  end

  @doc """
  Given a `list` of items and a function `fun`, return the list of items where
  `fun` returns false.

  Do not use `Enum.reject`.
  """
  @spec discard(list :: list(any), fun :: (any -> boolean)) :: list(any)
  def discard(list, fun) do
    pseudo_filter(list, fn item -> !fun.(item) end)
  end

  defp pseudo_filter([], _), do: []

  defp pseudo_filter([h | t], fun) do
    cond do
      fun.(h) -> [h | pseudo_filter(t, fun)]
      true -> pseudo_filter(t, fun)
    end
  end
end
