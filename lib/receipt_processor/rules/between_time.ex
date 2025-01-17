defmodule ReceiptProcessor.Rules.BetweenTime do
  @name :between_time

  def handle({receipt, scoreboard}) do
    result = receipt_handler(receipt)
    points_awarded = points_handler(result)
    
    {
      receipt,
      ReceiptProcessor.Scoreboard.update(scoreboard, @name, result, points_awarded)
    }
  end

  defp points_handler(true), do: 10
  defp points_handler(false), do: 0

  defp receipt_handler(%{purchaseTime: purchase_time}) do 
    [hour, seconds] = String.split(purchase_time, ":")
    {seconds, _} = Integer.parse(seconds)
    hour in ["14", "15"] and seconds != 0
  end
end
