defmodule AlphanumericTest do
  use ExUnit.Case, async: true
  alias ReceiptProcessor.Scoreboard
  alias ReceiptProcessor.Rules.Alphanumeric

  test "alphas" do
    lowercase = ?a..?z |> Enum.to_list() |> to_string()
    uppercase = ?A..?Z |> Enum.to_list() |> to_string()
    alphas = lowercase <> uppercase
    count = String.length(alphas)

    {_, scoreboard} = Alphanumeric.handle(
      {
        %{retailer: alphas},
        Scoreboard.empty()
      }
    )

    assert {:alphanumeric, count, count} == hd(scoreboard[:rules])
  end

  test "numbers" do
    {_, scoreboard} = Alphanumeric.handle(
      {
        %{retailer: "0123456789"},
        Scoreboard.empty()
      }
    )

    assert {:alphanumeric, 10, 10} == hd(scoreboard[:rules])
  end

  test "symbols" do
    symbols = "`~!@#$%^&*()_-+={[}}|\:;\"'<,>.?/"
    s = symbols

    {_, scoreboard} = Alphanumeric.handle(
      {
        %{retailer: s},
        Scoreboard.empty()
      }
    )

    assert {:alphanumeric, 0, 0} == hd(scoreboard[:rules])
  end

  test "numbers and alphas" do
    lowercase = ?a..?z |> Enum.to_list() |> to_string()
    uppercase = ?A..?Z |> Enum.to_list() |> to_string()
    alphas = lowercase <> uppercase
    numbers = "0123456789"
    s = numbers <> alphas
    count = String.length(s)

    {_, scoreboard} = Alphanumeric.handle(
      {
        %{retailer: s},
        Scoreboard.empty()
      }
    )

    assert {:alphanumeric, count, count} == hd(scoreboard[:rules])
  end

  test "number and alphas and symbols" do
    lowercase = ?a..?z |> Enum.to_list() |> to_string()
    uppercase = ?A..?Z |> Enum.to_list() |> to_string()
    alphas = lowercase <> uppercase
    numbers = "0123456789"
    symbols = "`~!@#$%^&*()_-+={[}}|\:;\"'<,>.?/"
    s = numbers <> alphas <> symbols
    count = String.length(numbers <> alphas)

    {_, scoreboard} = Alphanumeric.handle(
      {
        %{retailer: s},
        Scoreboard.empty()
      }
    )

    assert {:alphanumeric, count, count} == hd(scoreboard[:rules])
  end
end
