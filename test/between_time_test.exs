defmodule BetweenTimeTest do
  use ExUnit.Case, async: true
  alias ReceiptProcessor.Scoreboard
  alias ReceiptProcessor.Rules.BetweenTime

  test "out of range lower" do
    scoreboard = BetweenTime.handle(
      %{purchaseTime: "1:00"},
      Scoreboard.empty()
    )

    assert {:between_time, false, 0} == hd(scoreboard[:rules])
  end

  test "out of range upper" do
    scoreboard = BetweenTime.handle(
      %{purchaseTime: "21:28"},
      Scoreboard.empty()
    )

    assert {:between_time, false, 0} == hd(scoreboard[:rules])
  end

  test "exactly at 14:00" do
    scoreboard = BetweenTime.handle(
      %{purchaseTime: "14:00"},
      Scoreboard.empty()
    )

    assert {:between_time, false, 0} == hd(scoreboard[:rules])
  end

  test "14:01" do
    scoreboard = BetweenTime.handle(
      %{purchaseTime: "14:01"},
      Scoreboard.empty()
    )

    assert {:between_time, true, 10} == hd(scoreboard[:rules])
  end

  test "15:01" do
    scoreboard = BetweenTime.handle(
      %{purchaseTime: "15:01"},
      Scoreboard.empty()
    )

    assert {:between_time, true, 10} == hd(scoreboard[:rules])
  end

  test "15:59" do
    scoreboard = BetweenTime.handle(
      %{purchaseTime: "15:59"},
      Scoreboard.empty()
    )

    assert {:between_time, true, 10} == hd(scoreboard[:rules])
  end

  test "16:00" do
    scoreboard = BetweenTime.handle(
      %{purchaseTime: "16:00"},
      Scoreboard.empty()
    )

    assert {:between_time, false, 0} == hd(scoreboard[:rules])
  end
end
