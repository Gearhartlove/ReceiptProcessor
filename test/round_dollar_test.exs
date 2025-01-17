defmodule RoundDollarTest do
  use ExUnit.Case, async: true
  alias ReceiptProcessor.Scoreboard
  alias ReceiptProcessor.Rules.RoundDollar

  test "not round dollar" do
    scoreboard = RoundDollar.handle(
      %{total: "35.35"},
      Scoreboard.empty()
    )

    assert {:round_dollar, false, 0} == hd(scoreboard[:rules])
  end

  test "round dollar" do
    scoreboard = RoundDollar.handle(
      %{total: "35.00"},
      Scoreboard.empty()
    )

    assert {:round_dollar, true, 50} == hd(scoreboard[:rules])
  end
end
