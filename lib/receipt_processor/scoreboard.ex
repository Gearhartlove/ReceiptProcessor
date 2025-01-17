defmodule ReceiptProcessor.Scoreboard do
  @moduledoc """
  A collection of utilities for updating a scoreboard.
  """

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
