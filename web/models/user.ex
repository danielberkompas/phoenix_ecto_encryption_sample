defmodule Encryption.User do
  use Encryption.Web, :model

  schema "users" do
    field :name, Encryption.EncryptedField
    field :email, Encryption.EncryptedField
    field :email_hash, Encryption.HashField
    field :encryption_key_id, :binary

    timestamps
  end

  before_insert :set_defaults
  before_update :set_defaults

  @required_fields ~w(name email)
  @optional_fields ~w()

  @doc """
  Creates a changeset based on the `model` and `params`.

  If no params are provided, an invalid changeset is returned
  with no validation performed.
  """
  def changeset(model, params \\ :empty) do
    model
    |> cast(params, @required_fields, @optional_fields)
    |> set_defaults
    |> validate_unique(:email_hash, on: Encryption.Repo)
  end

  defp set_defaults(changeset) do
    changeset
    |> put_change(:email_hash, get_field(changeset, :email))
    |> put_change(:encryption_key_id, Encryption.AES.key_id)
  end
end
