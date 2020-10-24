defmodule User do
  defstruct name: "ahsdf", age: 3

  defimpl JsonEncoder do
    def to_json(%User{name: name, age: age}) do
      "{ \"name\": #{name}, \"age\": #{age}"
    end
  end
end

defmodule Test do
  def test do
    Text.to_json([
      345,
      %{
        "ffs" => [
          7.234,
          "sdfg",
          :asd
        ],
        "fas" => %User{
          name: "asdf",
          age: 345
        },
        f: "af"
      }
    ])
  end
end
