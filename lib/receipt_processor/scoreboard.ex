defmodule ReceiptProcessor.Scoreboard do
  def empty(), do: %{rules: []}

  def update(
    %{rules: rules},
    name,
    applied?,
    points_awarded
  ) do
    %{
      rules: [{name, applied?, points_awarded} | rules]
    }
  end
end
