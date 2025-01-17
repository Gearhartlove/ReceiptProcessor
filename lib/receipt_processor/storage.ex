defmodule ReceiptProcessor.Storage do
  use Agent

  def start_link(initial_value) do
    Agent.start_link(fn -> initial_value end, name: __MODULE__)
  end

  def save(receiptId, {receipt, scoreboard}) do
    storage()
    |> Map.put(receiptId, {receipt, scoreboard})
  end

  def get(receiptId) do
    storage()
    |> Map.get(receiptId)
  end

  defp storage(), do: Agent.get(__MODULE__, & &1)
end
