defmodule ReceiptProcessorTest do
  use ExUnit.Case, async: true
  use Plug.Test

  @opts ReceiptProcessor.Router.init([])

  test "simple receipt" do
    _ = ReceiptProcessor.Storage.start_link(%{})

    receipt =
      """
      {
        "retailer": "Target",
        "purchaseDate": "2022-01-02",
        "purchaseTime": "13:13",
        "total": "1.25",
        "items": [
            {"shortDescription": "Pepsi - 12-oz", "price": "1.25"}
        ]
      }
      """
    
    # save the receipt
    conn = conn(:post, "/receipts/process", receipt) 
    |> put_req_header("content-type", "application/json")
    |> put_req_header("accept", "application/json")

    conn = ReceiptProcessor.Router.call(conn, @opts)

    assert conn.state == :sent
    assert conn.status == 200
    assert is_binary(conn.resp_body)

    %{"id" => id} = conn.resp_body
      |> Jason.decode!()

    IO.puts("id=[#{id}] storage=[#{inspect(ReceiptProcessor.Storage.get())}]")

    # get the receipt from id
    conn = conn(:get, "/receipts/#{id}/points")
    conn = ReceiptProcessor.Router.call(conn, @opts)
    
    assert conn.state == :sent
    assert conn.status == 200

    %{"points" => points} = conn.resp_body
      |> Jason.decode!()

    assert points == 31
  end
end
