defmodule Pong do
  use GenServer

  ### GenServer API

  def init(init_arg), do: {:ok, init_arg}

  def handle_cast(:ball, state) do
    Ping.send()
    {:noreply, state}
  end

  ### Client API / Helper functions

  alias GenServer, as: Gn

  def start_link(init_arg), do: Gn.start_link(__MODULE__, init_arg, name: __MODULE__)

  def send(), do: Gn.cast(__MODULE__, :ball)
end
