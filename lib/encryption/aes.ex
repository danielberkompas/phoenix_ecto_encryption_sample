defmodule Encryption.AES do
  @moduledoc """
  Encrypt values with AES in CTR mode, using random IVs for each encryption.
  See `encrypt/1` and `decrypt/1` for more details.
  """

  @config  Application.get_env(:encryption, Encryption.AES)
  @keys    @config[:keys]
  @default @config[:default]

  @type key_id :: binary

  @doc """
  Encrypt a value. Uses a random IV for each call, and prepends the IV to the
  ciphertext.  This means that `encrypt/1` will never return the same ciphertext
  for the same value.

  ## Parameters

  - `plaintext`: Any type. Will be converted to a string using `to_string`
    before encryption.

  ## Examples

      iex> Encryption.AES.encrypt("test") != Encryption.AES.encrypt("test")
      true

      iex> ciphertext = Encryption.AES.encrypt(123)
      ...> is_binary(ciphertext)
      true

      iex> ciphertext = Encryption.AES.encrypt(123, <<2>>)
      ...> is_binary(ciphertext)
      true
  """
  @spec encrypt(any, key_id) :: String.t
  def encrypt(plaintext, key_id \\ @default) do
    iv    = :crypto.strong_rand_bytes(16)
    state = :crypto.stream_init(:aes_ctr, @keys[key_id], iv)
    {_state, ciphertext} = :crypto.stream_encrypt(state, to_string(plaintext))
    key_id <> iv <> ciphertext
  end

  @doc """
  Decrypt a binary. 
  
  ## Parameters

  - `ciphertext`: a binary to decrypt, assuming that the first byte is the ID
    of the key that was used to encrypt, the next 16 bytes are the IV, and the
    remainder is the ciphertext.

  ## Example

      iex> Encryption.AES.encrypt("test") |> Encryption.AES.decrypt
      "test"
  """
  @spec decrypt(String.t) :: String.t
  def decrypt(ciphertext) do
    <<key_id::binary-1, iv::binary-16, ciphertext::binary>> = ciphertext
    state = :crypto.stream_init(:aes_ctr, @keys[key_id], iv)
    {_state, plaintext} = :crypto.stream_decrypt(state, ciphertext)
    plaintext
  end

  def key_id do
    @default
  end
end
