import Config

if Mix.env() == :test do
  config :bugsnag, :api_key, "FAKEKEY"

  config :bugsnag_tesla, adapter: Tesla.Mock
end
