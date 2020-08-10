defmodule IdenticonTest do
  use ExUnit.Case
  doctest Identicon

  test "generates hashed array" do
    assert Identicon.hash_input("watermelon") === %Identicon.Image{
             hex: [
               65,
               252,
               163,
               162,
               154,
               173,
               221,
               154,
               0,
               79,
               208,
               21,
               106,
               69,
               66,
               107
             ]
           }
  end

  test "returns r g b values for rgba color value" do
    assert Identicon.main("watermelon") == [65, 252, 163]
  end
end
