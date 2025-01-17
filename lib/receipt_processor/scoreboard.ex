defmodule ReceiptProcessor.Scoreboard do
  def empty(), do: %{rules: [], score: 0}

  def update(
    %{rules: rules, score: score} = _scoreboard,
    name,
    applied?,
    points_awarded
  ) do
    %{
      rules: [{name, applied?, points_awarded} | rules],
      score: score + points_awarded
    }
  end
end
