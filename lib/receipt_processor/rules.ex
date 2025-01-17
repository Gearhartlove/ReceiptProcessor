defmodule ReceiptProcessor.Rules do
  alias ReceiptProcessor.Schemas.Receipt

  def score(_receipt = %Receipt{}) do
  end
end
