defmodule Bugsnag.HTTPClient.Adapters.Tesla do
  @moduledoc """
  Tesla adapter for Bugsnag.HTTPClient
  """
  alias Bugsnag.HTTPClient
  alias Bugsnag.HTTPClient.Request
  alias Bugsnag.HTTPClient.Response

  @behaviour HTTPClient

  @impl true
  def post(%Request{} = request) do
    middleware = [
      Tesla.Middleware.JSON
    ]

    client = Tesla.client(middleware)

    client
    |> Tesla.post(request.url, request.body, headers: request.headers, opts: request.opts)
    |> case do
      {:ok, %{body: body, headers: headers, status: status}} ->
        {:ok, Response.new(status, headers, body)}

      {:error, reason} ->
        {:error, reason}

      _ ->
        {:error, :unknown}
    end
  end
end
