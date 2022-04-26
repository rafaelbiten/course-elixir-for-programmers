defmodule Chain do
  @moduledoc """
  Module to play with a chain of nodes

  Usage (in 4 different terminal sessions):
  iex --sname one chain.ex # iex(one@raflocal)>
  iex --sname two chain.ex # iex(two@raflocal)>
  iex --sname three chain.ex # iex(three@raflocal)>
  iex --sname four chain.ex # iex(four@raflocal)>

  iex(one@raflocal)> Chain.start_link :two@raflocal
  iex(two@raflocal)> Chain.start_link :three@raflocal
  iex(three@raflocal)> Chain.start_link :four@raflocal
  iex(four@raflocal)> Chain.start_link :one@raflocal

  iex(one@raflocal)> Node.list
  iex(one@raflocal)> send :chainer, { :trigger, [] }
  """

  defstruct next_node: nil,
            max_runs: 4

  def start_link(next_node) do
    pid = spawn_link(Chain, :message_loop, [%Chain{next_node: next_node}])
    Process.register(pid, :chainer)
  end

  def message_loop(%{max_runs: 0}) do
    IO.puts("reached max number of runs")
  end

  def message_loop(state) do
    receive do
      {:trigger, list} ->
        IO.inspect("--- Runs left: #{state.max_runs}")
        IO.inspect(list)
        IO.inspect("---")
        :timer.sleep(500)

        send({:chainer, state.next_node}, {:trigger, [node() | list]})
        message_loop(%{state | max_runs: state.max_runs - 1})
    end
  end
end
