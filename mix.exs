defmodule BugsnagTesla.MixProject do
  use Mix.Project

  def project do
    [
      app: :bugsnag_tesla,
      version: "1.0.0",
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
      {:bugsnag,
       github: "bugsnag-elixir/bugsnag-elixir", tag: "84b8491e5a74fd667c707d2ecb918c746cf4d16d"},
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
