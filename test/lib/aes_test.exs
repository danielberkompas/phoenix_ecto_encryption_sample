defmodule Encryption.AESTest do
  use ExUnit.Case
  alias Encryption.AES

  doctest Encryption.AES

  test ".encrypt can encrypt a value" do
    assert AES.encrypt("hello") != "hello"
  end

  test ".encrypt includes the key id and random IV in the value" do
    <<key_id::binary-1, iv::binary-16, ciphertext::binary>> = AES.encrypt("hello")

    assert String.length(key_id) == 1
    assert String.length(iv) == 16
    assert String.length(ciphertext) == 5
  end

  test ".encrypt does not produce the same ciphertext twice" do
    assert AES.encrypt("hello") != AES.encrypt("hello")
  end

  test ".encrypt can encrypt with a custom key" do
    assert AES.encrypt("hello", <<2>>) != "hello"
  end

  test ".decrypt can decrypt a value" do
    plaintext = "hello" |> AES.encrypt |> AES.decrypt
    assert plaintext == "hello"
  end

  test ".decrypt can decrypt values encrypted with either key" do
    cipher1 = AES.encrypt("hello", <<1>>)
    cipher2 = AES.encrypt("hello", <<2>>)
    assert AES.decrypt(cipher1) == AES.decrypt(cipher2)
  end
end
