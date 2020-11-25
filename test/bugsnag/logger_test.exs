defmodule Bugsnag.LoggerTest do
  use ExUnit.Case, async: false

  @receive_timeout 2_000

  setup_all do
    Application.put_env(:bugsnag, :release_stage, "test")
    Application.put_env(:bugsnag, :notify_release_stages, ["test"])
    Application.put_env(:bugsnag, :http_client, Bugsnag.HTTPClient.Adapters.Tesla)

    on_exit(fn ->
      Application.delete_env(:bugsnag, :release_stage)
      Application.delete_env(:bugsnag, :notify_release_stages)
      Application.delete_env(:bugsnag, :http_client)
    end)
  end

  test "logging a crash" do
    parent = self()
    ref = make_ref()

    Tesla.Mock.mock_global(fn %{method: :post, body: body} ->
      if exception?(body, "Elixir.RuntimeError", "Oh noes") do
        send(parent, {:post, ref})
      end

      %Tesla.Env{status: 200, body: "body"}
    end)

    :proc_lib.spawn(fn ->
      raise RuntimeError, "Oh noes"
    end)

    assert_receive {:post, ^ref}, @receive_timeout
  end

  test "crashes do not cause recursive logging" do
    parent = self()
    ref = make_ref()

    Tesla.Mock.mock_global(fn %{method: :post, body: body} ->
      if exception?(body, "Elixir.RuntimeError", "Oops") do
        send(parent, {:post, ref})
      end

      %Tesla.Env{status: 500, body: "body"}
    end)

    error_report = [[error_info: {:error, %RuntimeError{message: "Oops"}, []}], []]
    :error_logger.error_report(error_report)

    assert_receive {:post, ^ref}, @receive_timeout
  end

  test "log levels lower than :error_report are ignored" do
    parent = self()
    ref = make_ref()

    Tesla.Mock.mock_global(fn %{method: :post} ->
      send(parent, {:post, ref})
      {:error, :just_no}
    end)

    message_types = [:info_msg, :info_report, :warning_msg, :error_msg]

    Enum.each(message_types, fn type ->
      apply(:error_logger, type, ["Ignore me"])
    end)

    refute_receive {:post, ^ref}, @receive_timeout
  end

  test "logging exceptions from special processes" do
    parent = self()
    ref = make_ref()

    Tesla.Mock.mock_global(fn %{method: :post, body: body} ->
      if exception?(body, "Elixir.ArgumentError", "argument error") do
        send(parent, {:post, ref})
      end

      %Tesla.Env{status: 200, body: "body"}
    end)

    :proc_lib.spawn(fn ->
      Float.parse("12.345e308")
    end)

    assert_receive {:post, ^ref}, @receive_timeout
  end

  test "logging exceptions from Tasks" do
    parent = self()
    ref = make_ref()

    Tesla.Mock.mock_global(fn %{method: :post, body: body} ->
      if exception?(body, "Elixir.ArgumentError", "argument error") do
        send(parent, {:post, ref})
      end

      %Tesla.Env{status: 200, body: "body"}
    end)

    Task.start(fn ->
      Float.parse("12.345e308")
    end)

    assert_receive {:post, ^ref}, @receive_timeout
  end

  defp exception?(body, error_class, message) do
    %{
      "events" => [
        %{
          "exceptions" => [
            %{
              "errorClass" => exception_error_class,
              "message" => exception_message
            }
          ]
        }
      ]
    } = Jason.decode!(body)

    exception_error_class =~ error_class and exception_message =~ message
  end
end
