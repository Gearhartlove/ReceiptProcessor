defmodule ReceiptProcessor.Application do
  use Application

  @impl true
  def start(_type, _args) do
    children = [
      {Bandit, scheme: :http, plug: ReceiptProcessor.Router}
    ]

    opts = [strategy: :one_for_one, name: ReceiptProcessor.Supervisor]
    Supervisor.start_link(children, opts)
  end
end
