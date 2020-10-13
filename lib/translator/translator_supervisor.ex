defmodule TranslatorSupervisor do
  use Supervisor

  def start(init_arg) do
    Supervisor.start_link(__MODULE__, init_arg, name: __MODULE__)
  end

  def init(init_arg) do
    children = [
      {Translator, init_arg}
    ]

    Supervisor.init(children, strategy: :one_for_one)
  end
end
