defmodule OddPurchaseDateTest do
  use ExUnit.Case, async: true
  alias ReceiptProcessor.Scoreboard
  alias ReceiptProcessor.Rules.OddPurchaseDate

  test "even date" do
    {_, scoreboard} =
      OddPurchaseDate.handle({
        %{purchaseDate: "2025-01-16"},
        Scoreboard.empty()
      })

    assert {:odd_purchase_date, false, 0} == hd(scoreboard[:rules])
  end

  test "odd date" do
    {_, scoreboard} =
      OddPurchaseDate.handle({
        %{purchaseDate: "2025-01-15"},
        Scoreboard.empty()
      })

    assert {:odd_purchase_date, true, 6} == hd(scoreboard[:rules])
  end
end
