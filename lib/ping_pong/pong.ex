defmodule Pong do
  use GenServer

  def init(init_arg) do
    {:ok, init_arg}
  end

  def start_link(init_arg) do
    GenServer.start_link(__MODULE__, init_arg, name: __MODULE__)
  end

  def handle_cast(:ball, state) do
    Ping.send()
    {:noreply, state}
  end

  def send() do
    GenServer.cast(__MODULE__, :ball)
  end
end
