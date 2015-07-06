use Mix.Config

# We don't run a server during test. If one is required,
# you can enable the server option below.
config :encryption, Encryption.Endpoint,
  http: [port: 4001],
  server: false

# Print only warnings and errors during test
config :logger, level: :warn

# Configure your database
config :encryption, Encryption.Repo,
  adapter: Ecto.Adapters.Postgres,
  database: "encryption_test",
  pool: Ecto.Adapters.SQL.Sandbox, # Use a sandbox for transactional testing
  size: 1
