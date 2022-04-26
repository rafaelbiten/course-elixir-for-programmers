defmodule Dictionary do
  @moduledoc false

  alias Dictionary.Runtime.Server

  @spec random_word() :: String.t()
  defdelegate random_word(), to: Server
end
