defmodule PingPongSupervisor do
  def start_link(init_arg) do
    Supervisor.start_link(__MODULE__, init_arg, name: __MODULE__)
  end

  def init(_init_arg) do
    children = [
      Ping,
      Pong
    ]

    Supervisor.init(children, strategy: :one_for_one)
  end

  def start do
    start_link(:ok)
  end
end
