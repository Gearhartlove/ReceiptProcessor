defmodule ReceiptProcessor.Controller do
  alias ReceiptProcessor.Schemas.Receipt
  import Plug.Conn

  def process(conn) do
    receipt = %Receipt{} = conn.body_param
    scoreboard = ReceiptProcessor.Rules.score(receipt)
    id = :erlang.unique_integer()
    ReceiptProcessor.Storage.save(id, {receipt, scoreboard})

    response = %{id: id}
      |> JSON.encode!()
    
    send_resp(conn, 200, response)
  end

  def points(conn) do
    id = conn.params[:id]
    points = ReceiptProcessor.Storage.get(id)

    response = %{points: points} 
      |> JSON.encode!()

    send_resp(conn, 200, response)
  end
end
