defmodule WordCount do

  def sanitize_word(word), do: String.downcase(word) |> String.trim(",") |> String.trim(".")

  def update_count(word, acc) do
    # Parametros de Map.update(1, 2, 3, 4)
    # 1 Mapa target a actualizar
    # 2 Key del mapa a la cual le queremos actualizar su value
    # 3 valor por defecto, si no encuentra la key, la inserta y le pone este valor por defecto
    # 4 funcion que describe como se va a actualizar el valor de la key encontrada
    Map.update(acc, word, 1, fn curr -> curr + 1 end)
  end
  def count(path) do
    {_, body} = File.read(path)
    String.split(body, ~r{[^A-Za-z0-9_]}, trim: true) |>
    Enum.reduce([], fn x, acc -> [sanitize_word(x) | acc] end) |>
    Enum.reduce(%{}, fn x, acc -> update_count(x, acc) end)
  end
end
