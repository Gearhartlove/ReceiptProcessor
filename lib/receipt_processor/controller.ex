defmodule ReceiptProcessor.Controller do
  alias ReceiptProcessor.Schemas.Receipt
  import Plug.Conn

  def process(conn) do
    receipt = struct(Receipt, conn.body_params)
    scoreboard = ReceiptProcessor.Rules.score(receipt)
    id = :erlang.unique_integer() |> to_string()
    :ok = ReceiptProcessor.Storage.save(id, {receipt, scoreboard})

    response =
      %{id: id}
      |> JSON.encode!()

    send_resp(conn, 200, response)
  end

  def points(conn) do
    id = conn.params["id"]
    IO.puts("Getting params for id. id=[#{id}]")
    {_, %{total: total}} = ReceiptProcessor.Storage.get(id)

    response =
      %{points: total}
      |> JSON.encode!()

    send_resp(conn, 200, response)
  end
end
