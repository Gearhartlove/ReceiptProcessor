defmodule AlphanumericTest do
  use ExUnit.Case, async: true
  alias ReceiptProcessor.Scoreboard
  alias ReceiptProcessor.Rules.Alphanumeric

  test "alphas" do
    lowercase = ?a..?z |> Enum.to_list() |> to_string()
    uppercase = ?A..?Z |> Enum.to_list() |> to_string()
    alphas = lowercase <> uppercase
    count = String.length(alphas)

    scoreboard = Alphanumeric.handle(
      %{retailer: alphas},
      Scoreboard.empty()
    )

    assert {:alphanumeric, nil, count} == hd(scoreboard[:rules])
  end

  test "numbers" do
    scoreboard = Alphanumeric.handle(
      %{retailer: "0123456789"},
      Scoreboard.empty()
    )

    assert {:alphanumeric, nil, 10} == hd(scoreboard[:rules])
  end

  test "symbols" do
    symbols = "`~!@#$%^&*()_-+={[}}|\:;\"'<,>.?/"
    s = symbols

    scoreboard = Alphanumeric.handle(
      %{retailer: s},
      Scoreboard.empty()
    )

    assert {:alphanumeric, nil, 0} == hd(scoreboard[:rules])
  end

  test "numbers and alphas" do
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
  end

  test "number and alphas and symbols" do
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
  end

end
