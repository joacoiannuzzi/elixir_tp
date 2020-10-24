defprotocol JsonEncoder do
  def to_json(value)
end

defmodule Text do
  def to_json(value) do
    JsonEncoder.to_json(value)
  end
end

defimpl JsonEncoder, for: List do
  def to_json(list) do
    list
    |> Enum.reduce("[ ", fn value, acc ->
      acc <>
        "#{JsonEncoder.to_json(value)}, "
    end)
    |> String.replace_suffix(", ", " ]")
  end
end

defimpl JsonEncoder, for: Map do
  def to_json(map) do
    map
    |> Enum.reduce("{ ", fn {k, v}, acc ->
      acc <>
        "\"#{to_string(k)}\": #{JsonEncoder.to_json(v)}, "
    end)
    |> String.replace_suffix(", ", " }")
  end
end

defimpl JsonEncoder, for: Integer do
  def to_json(number) do
    "#{number}"
  end
end

defimpl JsonEncoder, for: Float do
  def to_json(number) do
    "#{number}"
  end
end

defimpl JsonEncoder, for: BitString do
  def to_json(str) do
    "\"#{to_string(str)}\""
  end
end

defimpl JsonEncoder, for: String do
  def to_json(str) do
    "\"#{to_string(str)}\""
  end
end

defimpl JsonEncoder, for: Atom do
  def to_json(atom) do
    "\"#{to_string(atom)}\""
  end
end
