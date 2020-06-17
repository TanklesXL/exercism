defmodule Zipper do
  defmodule Step do
    @type t :: %__MODULE__{
            direction: :left | :right,
            value: BinTree.value(),
            alternate: BinTree.t() | nil
          }

    @enforce_keys [:direction, :value, :alternate]
    defstruct [:direction, :value, :alternate]
  end

  @type t :: %__MODULE__{focus: BinTree.t(), path: [Step.t()]}
  defstruct focus: nil, path: []

  @doc """
  Get a zipper focused on the root node.
  """
  @spec from_tree(BinTree.t()) :: Zipper.t()
  def from_tree(bin_tree), do: %__MODULE__{focus: bin_tree}

  @doc """
  Get the complete tree from a zipper.
  """
  @spec to_tree(Zipper.t()) :: BinTree.t()
  def to_tree(%__MODULE__{path: [], focus: focus}), do: focus
  def to_tree(zipper), do: zipper |> up() |> to_tree()

  @doc """
  Get the value of the focus node.
  """
  @spec value(Zipper.t()) :: any
  def value(zipper), do: zipper.focus.value

  @doc """
  Get the left child of the focus node, if any.
  """
  @spec left(Zipper.t()) :: Zipper.t() | nil
  def left(%__MODULE__{focus: %BinTree{left: nil}}), do: nil

  def left(%__MODULE__{path: path, focus: focus}) do
    %__MODULE__{
      path: [%Step{direction: :left, value: focus.value, alternate: focus.right} | path],
      focus: focus.left
    }
  end

  @doc """
  Get the right child of the focus node, if any.
  """
  @spec right(Zipper.t()) :: Zipper.t() | nil
  def right(%__MODULE__{focus: %BinTree{right: nil}}), do: nil

  def right(%__MODULE__{path: path, focus: focus}) do
    %__MODULE__{
      path: [%Step{direction: :right, value: focus.value, alternate: focus.left} | path],
      focus: focus.right
    }
  end

  @doc """
  Get the parent of the focus node, if any.
  """
  @spec up(Zipper.t()) :: Zipper.t() | nil
  def up(%__MODULE__{path: []}), do: nil

  def up(%__MODULE__{path: [step = %Step{direction: :left} | t], focus: focus}) do
    %__MODULE__{
      path: t,
      focus: %BinTree{
        value: step.value,
        left: focus,
        right: step.alternate
      }
    }
  end

  def up(%__MODULE__{path: [step = %Step{direction: :right} | t], focus: focus}) do
    %__MODULE__{
      path: t,
      focus: %BinTree{
        value: step.value,
        right: focus,
        left: step.alternate
      }
    }
  end

  @doc """
  Set the value of the focus node.
  """
  @spec set_value(Zipper.t(), any) :: Zipper.t()
  def set_value(zipper = %__MODULE__{focus: focus}, value) do
    %{zipper | focus: %{focus | value: value}}
  end

  @doc """
  Replace the left child tree of the focus node.
  """
  @spec set_left(Zipper.t(), BinTree.t() | nil) :: Zipper.t()
  def set_left(zipper = %__MODULE__{focus: focus}, left) do
    %{zipper | focus: %{focus | left: left}}
  end

  @doc """
  Replace the right child tree of the focus node.
  """
  @spec set_right(Zipper.t(), BinTree.t() | nil) :: Zipper.t()
  def set_right(zipper = %__MODULE__{focus: focus}, right) do
    %{zipper | focus: %{focus | right: right}}
  end
end
