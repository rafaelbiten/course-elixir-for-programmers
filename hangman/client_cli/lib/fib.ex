defmodule Cache do
  use Agent

  @type key :: number
  @type value :: number

  @spec init :: {:error, any} | {:ok, pid}
  def init, do: Agent.start_link(fn -> %{0 => 0, 1 => 1} end, name: __MODULE__)

  @spec get(key) :: value | nil
  def get(key), do: Agent.get(__MODULE__, fn cache -> Map.get(cache, key) end)

  @spec put(key, value) :: :ok
  def put(key, value), do: Agent.update(__MODULE__, fn cache -> Map.put(cache, key, value) end)
end

defmodule Fibonacci do
  @moduledoc """

  Module to calculate large Fibonacci sequences without crashing my machine.

  The challenge was:
  Try calculating fib(100).
  If it comes back without crashing your machine, and before the sun has expanded to consume the Earth, then your cache worked...

  Usage:
    > Fib.init
    > Fib.of 500

    cached 2: 1
    cached 3: 2
    ...
    cached 499: 86168291600238450732788312165664788095941068326060883324529903470149056115823592713458328176574447204501
    cached 500: 139423224561697880139724382870407283950070256587697307264108962948325571622863290691557658876222521294125
  """

  @spec init :: {:error, any} | {:ok, pid}
  def init, do: Cache.init()

  @spec of(number) :: number
  def of(0), do: fib(0)
  def of(1), do: fib(1)
  def of(n), do: cache_or_fib(n)

  defp cache_or_fib(n) do
    case Cache.get(n) do
      nil ->
        result = fib(n)
        Cache.put(n, result)
        IO.puts("cached #{n}: #{result}")
        result

      value ->
        value
    end
  end

  defp fib(0), do: 0
  defp fib(1), do: 1
  defp fib(n), do: cache_or_fib(n - 1) + cache_or_fib(n - 2)
end
