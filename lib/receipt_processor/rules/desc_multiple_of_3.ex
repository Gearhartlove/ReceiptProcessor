defmodule ReceiptProcessor.Rules.DescMultipleOf3 do
  @name :desc_multiple_of_3

  @moduledoc """
  If the trimmed length of the item description is a multiple of 3, multiply the price 
  by 0.2 and round up to the nearest integer. The result is the number of points earned.
  """

  def handle({receipt, scoreboard}) do
    result = receipt_handler(receipt)
    points_awarded = points_handler(result)

    {
      receipt,
      ReceiptProcessor.Scoreboard.update(
        scoreboard,
        @name,
        result |> Enum.count(),
        points_awarded
      )
    }
  end

  defp points_handler(items) do
    items
    |> Enum.map(fn %{price: price} ->
      price
      |> Float.parse()
      |> then(fn {number, _} -> number * 0.2 end)
      |> Float.ceil()
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
