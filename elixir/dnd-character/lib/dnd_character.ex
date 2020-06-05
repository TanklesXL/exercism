defmodule DndCharacter do
  @type t :: %__MODULE__{
          strength: pos_integer(),
          dexterity: pos_integer(),
          constitution: pos_integer(),
          intelligence: pos_integer(),
          wisdom: pos_integer(),
          charisma: pos_integer(),
          hitpoints: pos_integer()
        }

  defstruct ~w[strength dexterity constitution intelligence wisdom charisma hitpoints]a

  @spec modifier(pos_integer()) :: integer()
  def modifier(score) do
    ((score - 10) / 2) |> floor()
  end

  @spec ability :: pos_integer()
  def ability do
    rolls = for _ <- 1..4, do: Enum.random(1..6)
    List.delete(rolls, rolls |> Enum.min()) |> Enum.sum()
  end

  @spec character :: t()
  def character do
    consti = ability()

    %__MODULE__{
      strength: ability(),
      dexterity: ability(),
      constitution: consti,
      intelligence: ability(),
      wisdom: ability(),
      charisma: ability(),
      hitpoints: 10 + modifier(consti)
    }
  end
end
