defmodule ReceiptProcessor.Rules do
  alias ReceiptProcessor.Schemas.Receipt

  def score(receipt = %Receipt{}) do
  end

  # name , point adjustment, handler function(reciptMap, scoreboard)
  # scoreboard has an ordererd list of rule, applied booloean, new score amount
  defp rule_alphanumeric_character_in_name(%{name: name}) do
  end
end
