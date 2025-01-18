defmodule ReceiptProcessor.Controller do
  alias ReceiptProcessor.Schemas.Receipt
  import Plug.Conn

  @doc """
  `process` takes a connection's receipt, scores it, generates a unique id, and saves the 
  score and the receipt along side the id for future lookup.
  """

  def process({:error, :request, conn}), do: send_resp(conn, 404, "The receipt is invalid.")

  def process({conn, receipt}) do
    scoreboard = ReceiptProcessor.Rules.score(receipt)
    id = :erlang.unique_integer() |> to_string()
    :ok = ReceiptProcessor.Storage.save(id, {receipt, scoreboard})

    response =
      %{id: id}
      |> JSON.encode!()

    send_resp(conn, 200, response)
  end

  def process(conn) do
    try do
      receipt = struct!(Receipt, conn.body_params)
      process({conn, receipt})
    rescue
      ArgumentError -> process({:error, :request, conn})
    end
  end

  @doc """
  `points` takes a connection's id and looks up the total for that id. It then returns this
  total to the client.
  """
  def points({:error, :missing, conn}), do: send_resp(conn, 404, "No receipt found for that ID.")

  def points({conn, total}) do
    response =
      %{points: total}
      |> JSON.encode!()

    send_resp(conn, 200, response)
  end

  def points(conn) do
    id = conn.params["id"]
    case ReceiptProcessor.Storage.get(id) do
      {_, %{total: total}} -> 
        points({conn, total})
      _ -> 
        points({:error, :missing, conn})
    end
  end
end
