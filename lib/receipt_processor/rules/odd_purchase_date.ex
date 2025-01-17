defmodule ReceiptProcessor.Rules.OddPurchaseDate do
  @name :odd_purchase_date

  def handle({receipt, scoreboard}) do
    result = receipt_handler(receipt)
    points_awarded = points_handler(result)

    {
      receipt,
      ReceiptProcessor.Scoreboard.update(scoreboard, @name, result, points_awarded)
    }
  end

  defp points_handler(true), do: 6
  defp points_handler(false), do: 0

  defp receipt_handler(%{purchaseDate: purchase_date}) do
    [_year, _month, day] = String.split(purchase_date, "-")
    {number, _} = Integer.parse(day)
    rem(number, 2) != 0
  end
end
