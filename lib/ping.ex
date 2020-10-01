defmodule Ping do
  use GenServer

  defmodule State do
    defstruct msg_count: 0
  end

  def init(stack) do
    {:ok, stack}
  end

  def start_link(a) do
    GenServer.start_link(__MODULE__, a, name: __MODULE__)
  end

  def handle_call(:ball, _from, state) do
    {:reply, :ball, state}
  end

  def handle_cast({:play, n}, state) do
    Enum.each(1..n, fn _ ->
      Pong.send()
    end)
  end

  def play(n) do
    GenServer.call(__MODULE__, {:play, n})
  end
end
