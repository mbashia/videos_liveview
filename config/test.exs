import Config

# Configure your database
#
# The MIX_TEST_PARTITION environment variable can be used
# to provide built-in test partitioning in CI environment.
# Run `mix help test` for more information.
config :videos_liveview, VideosLiveview.Repo,
  username: "root",
  password: "",
  database: "videos_liveview_test#{System.get_env("MIX_TEST_PARTITION")}",
  hostname: "localhost",
  pool: Ecto.Adapters.SQL.Sandbox,
  pool_size: 10

# We don't run a server during test. If one is required,
# you can enable the server option below.
config :videos_liveview, VideosLiveviewWeb.Endpoint,
  http: [ip: {127, 0, 0, 1}, port: 4002],
  secret_key_base: "LXYSn82MkyImI4akS/VNgVn11X2NMjzJRuxkuc8ldMq7Q7MKHlNsH7Me1IVKrjdS",
  server: false

# In test we don't send emails.
config :videos_liveview, VideosLiveview.Mailer, adapter: Swoosh.Adapters.Test

# Print only warnings and errors during test
config :logger, level: :warn

# Initialize plugs at runtime for faster test compilation
config :phoenix, :plug_init_mode, :runtime
