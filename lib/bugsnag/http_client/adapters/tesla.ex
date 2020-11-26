defmodule Bugsnag.HTTPClient.Adapters.Tesla do
  @moduledoc """
  Tesla adapter for Bugsnag.HTTPClient
  """
  @behaviour Bugsnag.HTTPClient

  # We don't want any method expansion here as we'll be using request/1
  # directly, that's why we use `only: []`.
  use Tesla, only: [], docs: false

  alias Bugsnag.HTTPClient.Request
  alias Bugsnag.HTTPClient.Response

  plug Tesla.Middleware.JSON

  @impl Bugsnag.HTTPClient
  def post(%Request{} = request) do
    [
      method: :post,
      url: request.url,
      body: request.body,
      headers: request.headers,
      opts: request.opts
    ]
    |> request()
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
