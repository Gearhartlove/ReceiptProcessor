defmodule ReceiptProcessor.MixProject do
  use Mix.Project

  def project do
    [
      app: :receipt_processor,
      version: "0.1.0",
      elixir: "~> 1.18",
      start_permanent: Mix.env() == :prod,
      deps: deps()
    ]
  end

  # Run "mix help compile.app" to learn about applications.
  def application do
    [
      extra_applications: [:logger],
      mod: {ReceiptProcessor.Application, []}
    ]
  end

  # Run "mix help deps" to learn about dependencies.
  defp deps do
    [
      {:bandit, "~> 1.0"}, # HTTP server
      {:jason, "~> 1.4"} # JSON decoder and encoder
    ]
  end
end
