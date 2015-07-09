use Mix.Config

# For development, we disable any cache and enable
# debugging and code reloading.
#
# The watchers configuration can be used to run external
# watchers to your application. For example, we use it
# with brunch.io to recompile .js and .css sources.
config :encryption, Encryption.Endpoint,
  http: [port: 4000],
  debug_errors: true,
  code_reloader: true,
  cache_static_lookup: false,
  watchers: [node: ["node_modules/brunch/bin/brunch", "watch"]]

# Watch static and templates for browser reloading.
config :encryption, Encryption.Endpoint,
  live_reload: [
    patterns: [
      ~r{priv/static/.*(js|css|png|jpeg|jpg|gif)$},
      ~r{web/views/.*(ex)$},
      ~r{web/templates/.*(eex)$}
    ]
  ]

# Do not include metadata nor timestamps in development logs
config :logger, :console, format: "[$level] $message\n"

# Configure your database
config :encryption, Encryption.Repo,
  adapter: Ecto.Adapters.Postgres,
  database: "encryption_dev",
  size: 10 # The amount of database connections in the pool

config :encryption, Encryption.AES,
  keys: %{
    <<1>> => :base64.decode("vA/K/7K6Z3obnTxlPx6fDuy/tiPj4FS7dDtUpfvRbG4="),
    <<2>> => :base64.decode("Vnx9YGmqSHx9nTc3lVQxRwYS0A8Fks7fGzuMLZISl30=")
  },
  default: <<1>>
