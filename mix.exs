defmodule BugsnagTesla.MixProject do
  use Mix.Project

  def project do
    [
      app: :bugsnag_tesla,
      version: "1.0.1",
      elixir: "~> 1.10",
      start_permanent: Mix.env() == :prod,
      deps: deps(),
      package: package(),
      source_url: "https://github.com/team-telnyx/bugsnag_tesla",
      description: description()
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
      {:bugsnag, "~> 3.0"},
      {:tesla, "~> 1.3"},
      {:jason, "~> 1.0", optional: true}
    ]
  end

  defp description do
    """
    Bugsnag Tesla adapter
    """
  end

  defp package do
    [
      maintainers: ["Guilherme Balena Versiani <guilherme@telnyx.com>"],
      licenses: ["Apache 2.0"],
      links: %{"GitHub" => "https://github.com/team-telnyx/bugsnag_tesla"},
      files: ~w"lib mix.exs README.md LICENSE"
    ]
  end
end
