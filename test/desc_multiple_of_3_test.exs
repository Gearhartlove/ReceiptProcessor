defmodule DescMultipleOf3Test do
  use ExUnit.Case, async: true
  alias ReceiptProcessor.Scoreboard
  alias ReceiptProcessor.Rules.DescMultipleOf3

  test "no items" do
    {_, scoreboard} =
      DescMultipleOf3.handle({
        %{items: []},
        Scoreboard.empty()
      })

    assert {:desc_multiple_of_3, 0, 0} == hd(scoreboard[:rules])
  end

  test "no matches" do
    {_, scoreboard} =
      DescMultipleOf3.handle({
        %{
          items: [
            %{shortDescription: "AB", price: "12.23"},
            %{shortDescription: "ABCD", price: "12.23"},
            %{shortDescription: "ABCDE", price: "12.23"}
          ]
        },
        Scoreboard.empty()
      })

    assert {:desc_multiple_of_3, 0, 0} == hd(scoreboard[:rules])
  end

  test "matches" do
    {_, scoreboard} =
      DescMultipleOf3.handle({
        %{
          items: [
            # 2 after rules
            %{shortDescription: "ABC", price: "12.00"},
            # 2 after rules
            %{shortDescription: "ABCDEF", price: "12.00"},
            # 3 after rules
            %{shortDescription: "ABCDEFGHI", price: "13.00"}
          ]
        },
        Scoreboard.empty()
      })

    assert {:desc_multiple_of_3, 3, 9.0} == hd(scoreboard[:rules])
  end

  test "mix" do
    {_, scoreboard} =
      DescMultipleOf3.handle({
        %{
          items: [
            # 3 after rules
            %{shortDescription: "ABC", price: "12.00"},
            # 3 after rules
            %{shortDescription: "ABCDEF", price: "12.00"},
            # 3 after rules
            %{shortDescription: "ABCDEFGHI", price: "13.00"},
            %{shortDescription: "AB", price: "12.23"},
            %{shortDescription: "ABCD", price: "12.23"},
            %{shortDescription: "ABCDE", price: "12.23"}
          ]
        },
        Scoreboard.empty()
      })

    assert {:desc_multiple_of_3, 3, 9.0} == hd(scoreboard[:rules])
  end
end
