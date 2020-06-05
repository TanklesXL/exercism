defmodule RobotSimulator do
  @type t :: %{dir: atom, pos: {integer, integer}}

  @directions [:north, :south, :east, :west]

  @instructions ["A", "R", "L"]

  defguardp valid_direction?(dir) when dir in @directions

  defguardp valid_position?(pos)
            when is_tuple(pos) and
                   tuple_size(pos) === 2 and
                   is_integer(elem(pos, 0)) and
                   is_integer(elem(pos, 1))

  @doc """
  Create a Robot Simulator given an initial direction and position.

  Valid directions are: `:north`, `:east`, `:south`, `:west`
  """
  @spec create(dir :: atom, pos :: {integer, integer}) :: t | {:error, String.t()}
  def create(dir \\ :north, pos \\ {0, 0})

  def create(_dir, pos) when not valid_position?(pos) do
    {:error, "invalid position"}
  end

  def create(dir, _pos) when not valid_direction?(dir) do
    {:error, "invalid direction"}
  end

  def create(dir, pos) do
    %{
      dir: dir,
      pos: pos
    }
  end

  @doc """
  Simulate the robot's movement given a string of instructions.

  Valid instructions are: "R" (turn right), "L", (turn left), and "A" (advance)
  """
  @spec simulate(robot :: t, instructions :: String.t()) :: t
  def simulate(robot, instructions) do
    instructions
    |> String.graphemes()
    |> Enum.reduce_while(robot, &exec/2)
  end

  defp exec(instruction, _robot) when instruction not in @instructions do
    {:halt, {:error, "invalid instruction"}}
  end

  defp exec("A", robot) do
    {:cont, advance(robot)}
  end

  defp exec(left_or_right, robot) do
    {:cont, turn(robot, left_or_right)}
  end

  defp advance(robot = %{dir: :north, pos: {x, y}}), do: %{robot | pos: {x, y + 1}}
  defp advance(robot = %{dir: :south, pos: {x, y}}), do: %{robot | pos: {x, y - 1}}
  defp advance(robot = %{dir: :east, pos: {x, y}}), do: %{robot | pos: {x + 1, y}}
  defp advance(robot = %{dir: :west, pos: {x, y}}), do: %{robot | pos: {x - 1, y}}

  defp turn(robot = %{dir: :north}, l_or_r), do: %{robot | dir: new_dir({:west, :east}, l_or_r)}
  defp turn(robot = %{dir: :south}, l_or_r), do: %{robot | dir: new_dir({:east, :west}, l_or_r)}
  defp turn(robot = %{dir: :east}, l_or_r), do: %{robot | dir: new_dir({:north, :south}, l_or_r)}
  defp turn(robot = %{dir: :west}, l_or_r), do: %{robot | dir: new_dir({:south, :north}, l_or_r)}

  defp new_dir({_l, r}, "R"), do: r
  defp new_dir({l, _r}, "L"), do: l

  @doc """
  Return the robot's direction.

  Valid directions are: `:north`, `:east`, `:south`, `:west`
  """
  @spec direction(robot :: t) :: atom
  def direction(robot), do: robot.dir

  @doc """
  Return the robot's position.
  """
  @spec position(robot :: t) :: {integer, integer}
  def position(robot), do: robot.pos
end
