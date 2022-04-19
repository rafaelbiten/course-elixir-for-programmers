defmodule ClientCli do
  @spec start() :: :ok
  defdelegate start, to: ClientCli.Impl.Player
end
