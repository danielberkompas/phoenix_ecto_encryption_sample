defmodule Mix.Tasks.Encryption.Migrate do
  use Mix.Task

  import Ecto.Query
  import Logger, only: [info: 1]

  alias Encryption.Repo

  @key_id Encryption.AES.key_id

  def run(args) do
    Mix.Task.run "app.start", args
    migrate Encryption.User
  end

  defp migrate(model) do
    info "=== Migrating #{model} Model ==="
    ids = ids_for(model) 
    info "#{length(ids)} records found needing migration"

    for id <- ids do 
      Repo.get(model, id) |> migrate_record
    end

    info "=== Migration Complete ==="
  end

  defp ids_for(model) do
    query = from m in model, where:  m.encryption_key_id != ^@key_id, 
                             select: m.id
    Repo.all(query)
  end

  # Do nothing if the record has been migrated by app usage since 
  # we queried for ids.
  defp migrate_record(%{encryption_key_id: @key_id}), do: nil
  defp migrate_record(record), do: Repo.update!(record)
end
