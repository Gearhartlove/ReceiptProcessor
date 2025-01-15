defmodule ReceiptProcessorTest do
  use ExUnit.Case
  doctest ReceiptProcessor

  test "greets the world" do
    assert ReceiptProcessor.hello() == :world
  end
end
