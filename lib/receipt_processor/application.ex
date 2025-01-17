defmodule ReceiptProcessor.Application do
  use Application
  
  @moduledoc """
  This module contains the application supervision tree logic for ReceiptProcessor.
  The only spawned process is Bandit.
  """

  @impl true
  def start(_type, _args) do
    children = [
      {Bandit, scheme: :http, plug: ReceiptProcessor.Router}
    ]

    opts = [strategy: :one_for_one, name: ReceiptProcessor.Supervisor]
    Supervisor.start_link(children, opts)
  end
end
