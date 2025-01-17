defmodule ReceiptProcessor.Rules do
  alias ReceiptProcessor.Schemas.Receipt
  alias ReceiptProcessor.Scoreboard

  def score(receipt = %Receipt{}) do
    {receipt, Scoreboard.empty()} 
    |> ReceiptProcessor.Rules.Alphanumeric.handle()
    |> ReceiptProcessor.Rules.BetweenTime.handle()
    |> ReceiptProcessor.Rules.CountPairs.handle()
    |> ReceiptProcessor.Rules.DescMultipleOf3.handle()
    |> ReceiptProcessor.Rules.MultipleOf25.handle()
    |> ReceiptProcessor.Rules.OddPurchaseDate.handle()
    |> ReceiptProcessor.Rules.RoundDollar.handle()
    |> total()
    |> reverseScoreboardRules()
    |> logBreakdown()
  end

  defp total({receipt, %{rules: rules} = scoreboard}) do
    total = rules 
      |> Enum.map(fn {_, _, points} -> points end)
      |> Enum.sum()

    scoreboard = Map.put(scoreboard, :total, total)

    {receipt, scoreboard}
  end

  defp reverseScoreboardRules({receipt, %{rules: rules} = scoreboard}) do
    {
      receipt, 
      scoreboard
      |> Map.put(:rules, Enum.reverse(rules))
    }
  end

  defp logBreakdown({receipt, %{rules: rules, total: total} = scoreboard}) do
    breakdown = rules
      |> Enum.map(fn {name, result, points} -> 
        "name=[#{name}] points=[#{points}] result=[#{result}]"
      end)
      |> Enum.join(" | ")

    IO.puts("total=[#{total}] breakdown=[#{breakdown}] receipt=[#{inspect(receipt)}]")
    scoreboard
  end

end
