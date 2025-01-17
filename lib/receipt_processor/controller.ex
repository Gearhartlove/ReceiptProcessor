defmodule ReceiptProcessor.Controller do
  alias ReceiptProcessor.Schemas.Receipt
  import Plug.Conn

  @doc """
  `process` takes a connection's receipt, scores it, generates a unique id, and saves the 
  score and the receipt along side the id for future lookup.
  """
  def process(conn) do
    # TODO add a try around this and return a 404 specified by api.yml if request is bad
    receipt = struct(Receipt, conn.body_params)
    scoreboard = ReceiptProcessor.Rules.score(receipt)
    id = :erlang.unique_integer() |> to_string()
    :ok = ReceiptProcessor.Storage.save(id, {receipt, scoreboard})

    response =
      %{id: id}
      |> JSON.encode!()

    send_resp(conn, 200, response)
  end

  @doc """
  `points` takes a connection's id and looks up the total for that id. It then returns this
  total to the client.
  """
  def points(conn) do
    id = conn.params["id"]
    IO.puts("Getting params for id. id=[#{id}]")
    # TODO if no id is found, then return a 404 NotFonud error, ref api.yml for this
    {_, %{total: total}} = ReceiptProcessor.Storage.get(id)

    response =
      %{points: total}
      |> JSON.encode!()

    send_resp(conn, 200, response)
  end
end
