defmodule ReceiptProcessor.Rules.Alphanumeric do
  @name :alphanumeric

  def handle(receipt, scoreboard) do
    count = receipt_handler(receipt)
    points_awarded = points_handler(count)
    
    scoreboard
    |> ReceiptProcessor.Scoreboard.update(@name, count, points_awarded)
  end

  defp points_handler(points), do: points

  defp receipt_handler(%{retailer: retailer}) do 
    retailer 
    |> String.to_charlist()
    |> receipt_handler(0) 
  end

  defp receipt_handler([], count), do: count

  defp receipt_handler([h | t], count) 
    when h in ?a..?z or h in ?A..?Z or h in ?0..?9,
    do: receipt_handler(t, count + 1)

  defp receipt_handler([_ | t], count), do: receipt_handler(t, count)
end

