defmodule Ping do
  use GenServer

  defmodule State do
    defstruct msg_count: 0, start_time: 0

    def new(n) do
      %State{msg_count: n}
    end

    def increment(%State{msg_count: n} = state) do
      %{state | msg_count: n + 1}
    end
  end

  ### GenServer API

  def init(init_arg), do: {:ok, init_arg}

  def handle_call(:stats, _from, state) do
    frecuency = state.msg_count / (System.monotonic_time(:second) - state.start_time)

    response = %{
      msg_count: state.msg_count,
      frecuency: frecuency
    }

    {:reply, response, state}
  end

  def handle_cast(:ball, state) do
    Pong.send()
    new_state = State.increment(state)
    {:noreply, new_state}
  end

  def handle_cast({:play, n}, state) do
    1..n
    |> Enum.each(fn _ -> Pong.send() end)

    time = System.monotonic_time(:second)
    new_state = %{state | start_time: time}

    {:noreply, new_state}
  end

  ### Client API / Helper functions

  alias GenServer, as: Gn
  def start_link(_init_arg), do: GenServer.start_link(__MODULE__, State.new(0), name: __MODULE__)

  def play(n), do: Gn.cast(__MODULE__, {:play, n})

  def send(), do: Gn.cast(__MODULE__, :ball)

  def stats(), do: Gn.call(__MODULE__, :stats)
end
