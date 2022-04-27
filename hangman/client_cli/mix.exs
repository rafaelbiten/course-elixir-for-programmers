defmodule ClientCli.MixProject do
  use Mix.Project

  def project do
    [
      app: :client_cli,
      version: "0.1.0",
      elixir: "~> 1.12",
      start_permanent: Mix.env() == :prod,
      deps: deps()
    ]
  end

  # Run "mix help compile.app" to learn about applications.
  def application do
    [
      extra_applications: [:logger, :iex]
    ]
  end

  # Run "mix help deps" to learn about dependencies.
  defp deps do
    [
      {:hangman, path: "../hangman"},
      {:credo, "~> 1.6", only: [:dev, :test], runtime: false},
      {:dialyxir, "~> 1.1", only: [:dev, :test], runtime: false}
    ]
  end
end
