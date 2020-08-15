defmodule Identicon do
  @moduledoc """
  Documentation for `Identicon`.
  """
  def main(input) do
    input
    |> hash_input
    |> pick_color
    |> build_grid
    |> filter_odd_squares
    |> build_pixel_map
  end

  @doc """
  Returns hashed string as an array
  ## Examples
      iex> Identicon.hash_input("watermelonqwe")
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

  def pick_color(%Identicon.Image{hex: [r, g, b | _tail]} = image_struct) do
    %Identicon.Image{image_struct | color: {r, g, b}}
  end

  def build_grid(%Identicon.Image{hex: hex} = image_struct) do
    grid =
      hex
      |> Enum.chunk(3)
      |> Enum.map(&mirror_row/1)
      |> List.flatten()
      |> Enum.with_index()

    %Identicon.Image{image_struct | grid: grid}
  end

  def mirror_row([first, second | _tail] = row) do
    row ++ [second, first]
  end

  def filter_odd_squares(%Identicon.Image{grid: grid} = image_struct) do
    filtered =
      grid
      |> Enum.filter(fn {value, _index} = _square ->
        rem(value, 2) == 0
      end)

    %Identicon.Image{image_struct | grid: filtered}
  end

  def build_pixel_map(%Identicon.Image{grid: grid} = image_struct) do
    pixel_map =
      grid
      |> Enum.map(fn {_value, index} = _tuple ->
        horizontal = rem(index, 5) * 50
        vertical = div(index, 5) * 50
        top_left = {horizontal, vertical}
        bottom_right = {horizontal + 50, vertical + 50}

        {top_left, bottom_right}
      end)

    %Identicon.Image{image_struct | pixel_map: pixel_map}
  end
end
