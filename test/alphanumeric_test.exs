defmodule ReceiptProcessor.Rules.AlphanumericTest do
  use ExUnit.Case, async: true
  alias ReceiptProcessor.Scoreboard
  alias ReceiptProcessor.Rules.Alphanumeric

  test "count alpha test" do
    lowercase = ?a..?z |> Enum.to_list() |> to_string()
    uppercase = ?A..?Z |> Enum.to_list() |> to_string()
    alphas = lowercase <> uppercase
    count = String.length(alphas)

    scoreboard = Alphanumeric.handle(
      %{retailer: alphas},
      Scoreboard.empty()
    )

    assert {:alphanumeric, nil, count} == hd(scoreboard[:rules])
    assert count == scoreboard[:score]
  end

  test "count number test" do
    scoreboard = Alphanumeric.handle(
      %{retailer: "0123456789"},
      Scoreboard.empty()
    )

    assert {:alphanumeric, nil, 10} == hd(scoreboard[:rules])
    assert 10 == scoreboard[:score]
  end

  test "test symbols" do
    symbols = "`~!@#$%^&*()_-+={[}}|\:;\"'<,>.?/"
    s = symbols
    count = String.length(s)

    scoreboard = Alphanumeric.handle(
      %{retailer: s},
      Scoreboard.empty()
    )

    assert {:alphanumeric, nil, 0} == hd(scoreboard[:rules])
    assert 0 == scoreboard[:score]
  end

  test "test numbers and chars" do
    lowercase = ?a..?z |> Enum.to_list() |> to_string()
    uppercase = ?A..?Z |> Enum.to_list() |> to_string()
    alphas = lowercase <> uppercase
    numbers = "0123456789"
    s = numbers <> alphas
    count = String.length(s)

    scoreboard = Alphanumeric.handle(
      %{retailer: s},
      Scoreboard.empty()
    )

    assert {:alphanumeric, nil, count} == hd(scoreboard[:rules])
    assert count == scoreboard[:score]
  end

  test "test number and chars and symbols" do
    lowercase = ?a..?z |> Enum.to_list() |> to_string()
    uppercase = ?A..?Z |> Enum.to_list() |> to_string()
    alphas = lowercase <> uppercase
    numbers = "0123456789"
    symbols = "`~!@#$%^&*()_-+={[}}|\:;\"'<,>.?/"
    s = numbers <> alphas <> symbols
    count = String.length(numbers <> alphas)

    scoreboard = Alphanumeric.handle(
      %{retailer: s},
      Scoreboard.empty()
    )

    assert {:alphanumeric, nil, count} == hd(scoreboard[:rules])
    assert count == scoreboard[:score]
  end

end
