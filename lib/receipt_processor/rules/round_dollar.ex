defmodule ReceiptProcessor.Rules.RoundDollar do
  @name :round_dollar

  def handle({receipt, scoreboard}) do
    result = receipt_handler(receipt)
    points_awarded = points_handler(result)

    {
      receipt,
      ReceiptProcessor.Scoreboard.update(scoreboard, @name, result, points_awarded)
    }
  end

  defp points_handler(true), do: 50
  defp points_handler(false), do: 0

  defp receipt_handler(%{total: total}) do
    [_, cents] = String.split(total, ".")
    cents == "00"
  end
end
