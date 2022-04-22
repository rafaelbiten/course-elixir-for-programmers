defmodule Dictionary.Runtime.Server do
  use Agent
  @agent __MODULE__

  alias Dictionary.Impl.Words

  @type t :: pid()

  @spec start_link :: {:error, any} | {:ok, t}
  def start_link do
    Agent.start_link(&Words.get_words/0, name: @agent)
  end

  @spec random_word() :: String.t()
  def random_word() do
    Agent.get(@agent, &Words.random_word/1)
  end
end
