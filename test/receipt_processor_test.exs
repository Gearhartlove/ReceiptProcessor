defmodule ReceiptProcessorTest do
  use ExUnit.Case, async: true
  use Plug.Test

  # @opts ReceiptProcessor.Router.init([])

  #   test "simple receipt" do
  #     receipt =
  #       """
  #       {
  #         "retailer": "Target",
  #         "purchaseDate": "2022-01-02",
  #         "purchaseTime": "13:13",
  #         "total": "1.25",
  #         "items": [
  #             {"shortDescription": "Pepsi - 12-oz", "price": "1.25"}
  #         ]
  #       }
  #       """
  # 
  #     conn = conn(:post, "/receipts/process", JSON.decode!(receipt))
  #     conn = ReceiptProcessor.Router.call(conn, @opts)
  # 
  #     assert conn.state == :sent
  #     assert conn.status == 200
  #     assert conn.resp_body == "OK"
  #   end
end
