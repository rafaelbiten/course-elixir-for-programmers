defmodule ClientCli do
  @moduledoc false

  @spec start() :: :ok
  defdelegate start, to: ClientCli.Impl.Player
end
