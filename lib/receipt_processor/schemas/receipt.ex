defmodule ReceiptProcessor.Schemas.Receipt do
  @moduledoc """
  A collection of utility functions and macros used when working with receipts.
  """
  @enforce_keys [:retailer, :purchaseDate, :purchaseTime, :items, :total]
  defstruct [:retailer, :purchaseDate, :purchaseTime, :items, :total]
end
