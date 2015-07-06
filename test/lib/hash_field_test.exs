defmodule Encryption.HashFieldTest do
  use ExUnit.Case
  alias Encryption.HashField, as: Type

  test ".type is :binary" do
    assert Type.type == :binary
  end

  test ".cast converts a value to a string" do
    assert {:ok, "123"} == Type.cast(123)
  end

  test ".dump converts a value to a sha256 hash" do
    {:ok, hash} = Type.dump("hello")
    assert hash == <<44, 242, 77, 186, 95, 176, 163, 14, 38, 232, 59, 42, 197, 185, 226, 158, 27, 22, 30, 92, 31, 167, 66, 94, 115, 4, 51, 98, 147, 139, 152, 36>>
  end

  test ".load does not modify the hash, since the value cannot be reconstructed" do
    hash = <<44, 242, 77, 186, 95, 176, 163, 14, 38, 232, 59, 42, 197, 185, 226, 158, 27, 22, 30, 92, 31, 167, 66, 94, 115, 4, 51, 98, 147, 139, 152, 36>>
    assert {:ok, ^hash} = Type.load(hash)
  end
end

