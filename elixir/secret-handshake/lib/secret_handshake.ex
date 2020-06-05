defmodule SecretHandshake do
  @doc """
  Determine the actions of a secret handshake based on the binary
  representation of the given `code`.

  If the following bits are set, include the corresponding action in your list
  of commands, in order from lowest to highest.

  1 = wink
  10 = double blink
  100 = close your eyes
  1000 = jump

  10000 = Reverse the order of the operations in the secret handshake
  """

  @spec commands(code :: integer) :: list(String.t())
  def commands(code) do
    actions = ["wink", "double blink", "close your eyes", "jump", "reverse"]

    code
    |> Integer.digits(2)
    |> Enum.reverse()
    |> Enum.zip(actions)
    |> Enum.filter(fn {dig, _} -> dig === 1 end)
    |> Enum.map(fn {_, action} -> action end)
    |> reverse_if_present("reverse")
  end

  defp reverse_if_present(handshake, reversal_string) do
    cond do
      Enum.member?(handshake, reversal_string) ->
        handshake
        |> Enum.reverse()
        |> List.delete(reversal_string)

      true ->
        handshake
    end
  end
end
