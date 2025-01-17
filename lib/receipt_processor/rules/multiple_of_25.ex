defmodule ReceiptProcessor.Rules.MultipleOf25 do
  @name :multiple_of_25

  def handle({receipt, scoreboard}) do
    result = receipt_handler(receipt)
    points_awarded = points_handler(result)
    
    {
      receipt, 
      ReceiptProcessor.Scoreboard.update(scoreboard, @name, result, points_awarded)
    }
  end

  defp points_handler(true), do: 25
  defp points_handler(false), do: 0

  defp receipt_handler(%{total: total}) do 
    {total, _} = Float.parse(total)
    :math.fmod(total, 0.25) == 0.0
  end
end
