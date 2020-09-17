defmodule BugsnagTesla.MixProject do
  use Mix.Project

  def project do
    [
      app: :bugsnag_tesla,
      version: "0.1.0",
      elixir: "~> 1.10",
      start_permanent: Mix.env() == :prod,
      deps: deps()
    ]
  end

  # Run "mix help compile.app" to learn about applications.
  def application do
    [
      extra_applications: [:logger]
    ]
  end

  # Run "mix help deps" to learn about dependencies.
  defp deps do
    [
      {:bugsnag,
       github: "bugsnag-elixir/bugsnag-elixir", tag: "84b8491e5a74fd667c707d2ecb918c746cf4d16d"},
      {:tesla, "~> 1.3"},
      {:jason, "~> 1.0", optional: true}
    ]
  end
end
