defmodule ReceiptProcessor.Rules.CountPairs do
  @name :count_pairs

  def handle(receipt, scoreboard) do
    result = receipt_handler(receipt)
    points_awarded = points_handler(result)
    
    scoreboard
    |> ReceiptProcessor.Scoreboard.update(@name, result, points_awarded)
  end

  defp points_handler(count), do: count * 5

  defp receipt_handler(%{items: items}) do 
    items
    |> Enum.chunk_every(2, 2, :discard)
    |> Enum.count()
  end
end
