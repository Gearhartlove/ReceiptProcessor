defmodule MultipleOf25Test do
  use ExUnit.Case, async: true
  alias ReceiptProcessor.Scoreboard
  alias ReceiptProcessor.Rules.MultipleOf25

  test "multiple of 0.25" do
    {_, scoreboard} = MultipleOf25.handle(
      {
        %{total: "10.50"},
        Scoreboard.empty()
      }
    )

    assert {:multiple_of_25, true, 25} == hd(scoreboard[:rules])
  end

  test "not multiple of 0.25" do
    {_, scoreboard} = MultipleOf25.handle(
      {
        %{total: "10.60"},
        Scoreboard.empty()
      }
    )

    assert {:multiple_of_25, false, 0} == hd(scoreboard[:rules])
  end
end
