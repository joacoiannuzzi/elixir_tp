defmodule Ping do
  use GenServer

  def init(init_arg) do
    {:ok, init_arg}
  end

  def start_link(a) do
    GenServer.start_link(__MODULE__, a, name: __MODULE__)
  end

  def handle_call(:ball, _from, state) do
    {:reply, :ball, state}
  end

  def play(n) do
  end
end
