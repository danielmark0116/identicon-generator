defmodule Identicon do
  @moduledoc """
  Documentation for `Identicon`.
  """
  def main(input) do
    input
    |> hash_input
    |> pick_color
  end

  def pick_color(image_struct) do
    %Identicon.Image{hex: [r, g, b | _tail]} = image_struct

    [r, g, b]
  end

  @doc """
  Returns hashed string as an array
  ## Examples
      iex> Identicon.hash_input("watermelon")
      %Identicon.Image{
        hex: [65, 252, 163, 162, 154, 173, 221, 154, 0, 79, 208, 21, 106, 69,
      66, 107]
      }
  """
  def hash_input(input) do
    hex =
      :crypto.hash(:md5, input)
      |> :binary.bin_to_list()

    %Identicon.Image{hex: hex}
  end
end
