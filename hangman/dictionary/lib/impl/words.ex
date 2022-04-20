defmodule Dictionary.Impl.Words do
  @type t :: list(binary)

  @spec get_words :: t
  def get_words do
    "assets/words.txt"
    |> File.read!()
    |> String.split("\n", trim: true)
  end

  @spec random_word(t) :: binary
  def random_word(words), do: Enum.random(words)
end
