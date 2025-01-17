defmodule ReceiptProcessor.Schemas.Receipt do
  @enforce_keys [:retailer, :purchaseDate, :purchaseTime, :items, :total]
  defstruct [:retailer, :purchaseDate, :purchaseTime, :items, :total]
end
