# Bugsnag/Tesla

This module implements a `Bugsnag.HTTPClient` adapter for `Tesla`.

## Installation

```elixir
# mix.exs
defp deps do
  [
    {:bugsnag, "~> 2.1.0"},
    ...
    # add bugsnag_tesla here:
    {:bugsnag_tesla, "~> 1.0"},
  ]
end
```

Then, while configuring `Bugsnag`, set `Bugsnag.HTTPClient.Adapters.Tesla` as a `http_client` adapter:

```elixir
# config/config.exs
config :bugsnag,
  api_key: ...,
  ...
  http_client: Bugsnag.HTTPClient.Adapters.Tesla
```

So far, the only way to configure `bugsnag_tesla` adapter is globally through a config like:

```elixir
# config/config.exs

config :tesla, adapter: Tesla.Adapter.Hackney
```
