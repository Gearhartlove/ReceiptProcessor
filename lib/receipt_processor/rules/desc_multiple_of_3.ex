defmodule ReceiptProcessor.Rules.DescMultipleOf3 do
  @name :desc_multiple_of_3

  def handle(receipt, scoreboard) do
    result = receipt_handler(receipt)
    points_awarded = points_handler(result)
    
    scoreboard
    |> ReceiptProcessor.Scoreboard.update(
      @name,
      result |> Enum.count(),
      points_awarded
    )
  end

  defp points_handler(items) do
    items 
    |> Enum.map(fn %{price: price} ->
      price
      |> Float.parse()
      |> then(fn {number, _} -> number * 0.2 end)
      |> round()
    end)
    |> Enum.sum()
  end

  defp receipt_handler(%{items: items}) do 
    items 
    |> Enum.filter(fn %{shortDescription: shortDescription} ->
      shortDescription
      |> String.trim()
      |> String.length()
      |> then(fn length -> rem(length, 3) == 0 end)
    end)
  end
end
