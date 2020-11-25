# Bugsnag/Tesla

This module implements a `Bugsnag.HTTPClient` adapter for `Tesla`.

## Installation

```elixir
# mix.exs
defp deps do
  [
    {:bugsnag, "~> 3.0"},
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

## Configuring Tesla adapters

You have two ways to configure `Tesla` adapters:
* Using per module configuration;
* Using global `Tesla` configuration.

If you want to use a specific `Tesla` adapter for `Bugsnag`, do:

```elixir
# config/config.exs
config :tesla, Bugsnag.HTTPClient.Adapters.Tesla,
  adapter: Tesla.Adapter.Httpc
```

If you prefer to use a single adapter for every `Tesla` use on your app, do as usual:

```elixir
# config/config.exs
config :tesla, adapter: Tesla.Adapter.Httpc
```
