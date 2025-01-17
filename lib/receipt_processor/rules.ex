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
    |> reverseScoreboardRules()
    |> logBreakdown()
  end

  defp reverseScoreboardRules({_, %{rules: rules} = scoreboard}) do
    scoreboard
    |> Map.put(:rules, Enum.reverse(rules))
  end

  defp logBreakdown({receipt, %{rules: rules} = scoreboard}) do
    breakdown = rules
      |> Enum.map(fn {name, result, points} -> 
        "name=[#{name}] points=[#{points}] result=[#{result}]"
      end)
      |> Enum.join(" | ")

    total = rules 
      |> Enum.map(fn {_, _, points} -> points end)
      |> Enum.sum()

    IO.puts("total=[#{total}] breakdown=[#{breakdown}] receipt=[#{inspect(receipt)}]")
    scoreboard
  end

end
