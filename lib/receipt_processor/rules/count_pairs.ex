defmodule ReceiptProcessor.Rules.CountPairs do
  @name :count_pairs

  @moduledoc """
  rule: 5 points for every two items on the receipt.
  """

  def handle({receipt, scoreboard}) do
    result = receipt_handler(receipt)
    points_awarded = points_handler(result)

    {
      receipt,
      ReceiptProcessor.Scoreboard.update(scoreboard, @name, result, points_awarded)
    }
  end

  defp points_handler(count), do: count * 5

  defp receipt_handler(%{items: items}) do
    items
    |> Enum.chunk_every(2, 2, :discard)
    |> Enum.count()
  end
end
