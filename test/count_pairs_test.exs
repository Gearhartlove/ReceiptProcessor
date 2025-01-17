defmodule CountPairsTest do
  use ExUnit.Case, async: true
  alias ReceiptProcessor.Scoreboard
  alias ReceiptProcessor.Rules.CountPairs

  test "no items" do
    {_, scoreboard} = CountPairs.handle(
      {
        %{items: []},
        Scoreboard.empty()
      }
    )

    assert {:count_pairs, 0, 0} == hd(scoreboard[:rules])
  end

  test "1 item" do
    {_, scoreboard} = CountPairs.handle(
      {
        %{items: [%{shortDescription: "Mountain Dew 12PK", price: 10.00}]},
        Scoreboard.empty()
      }
    )

    assert {:count_pairs, 0, 0} == hd(scoreboard[:rules])
  end

  test "2 item" do
    {_, scoreboard} = CountPairs.handle(
      {
        %{items: 
          [
            %{shortDescription: "Mountain Dew 12PK", price: 10.00},
            %{shortDescription: "Emils Cheese Pizza", price: 12.30},
          ]
        },
        Scoreboard.empty()
      }
    )

    assert {:count_pairs, 1, 5} == hd(scoreboard[:rules])
  end

  test "more than one pair" do
    {_, scoreboard} = CountPairs.handle(
      {
        %{items: 
          [
            %{shortDescription: "Mountain Dew 12PK", price: 10.00},
            %{shortDescription: "Emils Cheese Pizza", price: 12.30},
            %{shortDescription: "Mountain Dew 12PK", price: 10.00},
            %{shortDescription: "Emils Cheese Pizza", price: 12.30},
            %{shortDescription: "Mountain Dew 12PK", price: 10.00},
          ]
        },
        Scoreboard.empty()
      }
    )

    assert {:count_pairs, 2, 10} == hd(scoreboard[:rules])
  end
end
