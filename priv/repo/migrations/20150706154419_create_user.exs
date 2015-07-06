defmodule Encryption.Repo.Migrations.CreateUser do
  use Ecto.Migration

  def change do
    create table(:users) do
      add :name, :binary
      add :email, :binary
      add :email_hash, :binary

      timestamps
    end

  end
end
