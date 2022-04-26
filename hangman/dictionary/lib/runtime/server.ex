defmodule Dictionary.Runtime.Server do
  @moduledoc false

  use Agent

  alias Dictionary.Impl.Words

  @type t :: pid()

  @agent __MODULE__

  @spec start_link(any) :: {:error, any} | {:ok, t}
  def start_link(_args) do
    Agent.start_link(&Words.get_words/0, name: @agent)
  end

  @spec random_word() :: String.t()
  def random_word() do
    Agent.get(@agent, &Words.random_word/1)
  end

  @spec falty_random_word() :: String.t()
  def falty_random_word() do
    if :rand.uniform() < 0.33 do
      Agent.get(@agent, fn _ -> exit(:meeh) end)
    end

    random_word()
  end
end
