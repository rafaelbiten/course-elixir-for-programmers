defmodule Dictionary do
  alias Dictionary.Impl.Words

  @opaque t :: Words.t()

  @spec start :: t
  defdelegate start, to: Words, as: :get_words

  @spec random_word(t) :: binary
  defdelegate random_word(words), to: Words
end
