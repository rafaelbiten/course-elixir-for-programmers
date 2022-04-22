defmodule Dictionary.Impl.Words do
  @cwd File.cwd!()

  @type t :: list(String.t())

  @spec get_words :: t
  def get_words do
    Path.join(@cwd, "/assets/words.txt")
    |> File.read!()
    |> String.split("\n", trim: true)
  end

  @spec random_word(t) :: String.t()
  def random_word(words), do: Enum.random(words)
end
