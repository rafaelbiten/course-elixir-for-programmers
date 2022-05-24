import Config

# We don't run a server during test. If one is required,
# you can enable the server option below.
config :client_liveview, ClientLiveViewWeb.Impl.Endpoint,
  http: [ip: {127, 0, 0, 1}, port: 4002],
  secret_key_base: "iENJh/ZZsdHrC8iunT1l3fURbHvogcJQ5/u1A7VC9cigS7ZnqxpsROM4m6odN/Uf",
  server: false

# Print only warnings and errors during test
config :logger, level: :warn

# Initialize plugs at runtime for faster test compilation
config :phoenix, :plug_init_mode, :runtime
