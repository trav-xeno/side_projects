defmodule Idicon do
  @moduledoc """
  Documentation for `Idicon`.
  5x5 grid of squares 250px x 250px and mirror about the center
  """

  @doc """
  generate an identicon from the input string
  """
  def main(input) do
    input
    |> hash_input
    |> select_color
    |> build_grid
    |> filter_odd_squares
    |> build_pixel_map
    |> draw_image
    |> save_image(input)
  end



@doc """
select the color of the image based on the first three values of the hash
Note: for fuuture me - you can pattern match in the function definition
"""
  def select_color(%Idicon.Image{hex: [r, g, b | _tail]} = imagestruct) do
    # pattern match ignoring rest of the list { [r, g, b | _tail]} = imagestruct
    %Idicon.Image{imagestruct | color: {r, g, b}}
  end


@doc """
  compute the hash of the input string

  ## Example

        iex> Idicon.hash_input("hello")
        %Idicon.Image{hex: [93, 65, 64, 42, 188, 75, 42, 118, 185, 113, 157, 145, 16, 23, 197, 146]}
  """
  def hash_input(input) do
    hex = :crypto.hash(:md5, input)
    |> :binary.bin_to_list

    %Idicon.Image{hex: hex}
  end


def filter_odd_squares(%Idicon.Image{grid: grid } = image) do
  grid = Enum.filter grid, fn ({val, _index}) ->
    rem(val, 2) == 0
  end
  %Idicon.Image{image | grid: grid}
end

@doc """
  convert the grid of squares into index, top_point, bottom_point
"""
def build_pixel_map(%Idicon.Image{grid: grid} = image) do
  pixel_map = Enum.map grid, fn ({_val, index}) ->
    horizontal = rem(index, 5) * 50
    vertical = div(index, 5) * 50
    top_left = {horizontal, vertical}
    bottom_right = {horizontal + 50 , vertical + 50}
    {top_left, bottom_right}
  end

  %Idicon.Image{image | pixel_map: pixel_map}
end

def save_image(image, input) do
  File.write("#{input}.png", image)

end


@doc """
  draw the image
"""
def draw_image(%Idicon.Image{color: color, pixel_map: pixel_map }) do
  image = :egd.create(250, 250)
  fill_color = :egd.color(color)
  Enum.each pixel_map, fn ({top_left, bottom_right}) ->
    :egd.filledRectangle(image, top_left, bottom_right, fill_color)
  end
  :egd.render(image)
end



@doc """
creates the grid of 5x5 squares
"""
def build_grid(%Idicon.Image{hex: hex_list} = image) do
  grid =
    hex_list
  |> Enum.chunk(3)
  |> Enum.map(&mirror_row/1)
  |> List.flatten
  |> Enum.with_index

  %Idicon.Image{image | grid: grid}
end

def mirror_row(row) do
  # [23, 100, 48] -> [23, 100, 48, 100, 23]
  [first, second | _tail] = row
  row ++ [second, first]
end



end
