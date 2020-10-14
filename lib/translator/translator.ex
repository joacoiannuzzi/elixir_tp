defmodule Translator do
  use GenServer

  def map do
    %{
      "hello" => "hola",
      "world" => "mundo"
    }
  end

  defmodule State do
    defstruct quantity_of_documents: 0,
              quantity_of_translated_words: 0,
              translations: %{},
              translation_frequencies: %{}

    def new(translations) do
      %State{
        translations: translations
      }
    end

    def increase_count_of_documents(state) do
      %{state | quantity_of_documents: state.quantity_of_documents + 1}
    end

    def update_quantity_of_translated_words(state) do
      value =
        state.translation_frequencies
        |> Map.values()
        |> Enum.sum()

      %{state | quantity_of_translated_words: value}
    end

    def update_frequencies(state, new_frequencies) do
      %{state | translation_frequencies: new_frequencies}
    end
  end

  ### GenServer API

  def init(init_arg) do
    {:ok, State.new(init_arg)}
  end

  def handle_call(:stats, _from, state) do
    response = %{
      quantity_of_translated_words: state.quantity_of_translated_words,
      quantity_of_documents: state.quantity_of_documents,
      translation_frequencies: state.translation_frequencies
    }

    {:reply, response, state}
  end

  def handle_call({:translate, words}, _from, state) do
    result =
      words
      |> String.split()
      |> Enum.map(fn word -> Map.get(state.translations, word) end)
      |> Enum.join(" ")

    new_frequencies =
      words
      |> String.split()
      |> Enum.frequencies()
      |> Map.merge(state.translation_frequencies, fn _k, v1, v2 -> v1 + v2 end)

    newState =
      state
      |> State.update_frequencies(new_frequencies)
      |> State.update_quantity_of_translated_words()
      |> State.increase_count_of_documents()

    {:reply, result, newState}
  end

  ### Client API / Helper functions

  alias GenServer, as: GS

  def start_link(init_arg), do: GS.start_link(__MODULE__, init_arg, name: __MODULE__)

  def translate(words), do: GS.call(__MODULE__, {:translate, words})

  def stats(), do: GS.call(__MODULE__, :stats)
end

# map = %{"hello" => "hola", "world" => "mundo"}
# TranslatorSupervisor.start map
# Translator.translate "hello world"
