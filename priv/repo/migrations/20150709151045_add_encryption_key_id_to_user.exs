defmodule Encryption.Repo.Migrations.AddEncryptionKeyIdToUser do
  use Ecto.Migration

  def change do
    alter table(:users) do
      add :encryption_key_id, :binary
    end

    create index(:users, [:encryption_key_id])
  end
end
