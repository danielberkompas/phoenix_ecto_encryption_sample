defmodule Encryption.User do
  use Encryption.Web, :model

  schema "users" do
    field :name, Encryption.EncryptedField
    field :email, Encryption.EncryptedField
    field :email_hash, Encryption.HashField

    timestamps
  end

  # Ensure that hashed fields never get out of date
  before_insert :set_hashed_fields
  before_update :set_hashed_fields

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
    |> set_hashed_fields
    |> validate_unique(:email_hash, on: Encryption.Repo)
  end

  defp set_hashed_fields(changeset) do
    changeset
    |> put_change(:email_hash, get_field(changeset, :email))
  end
end
