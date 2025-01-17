defmodule ReceiptProcessor.Router do
  use Plug.Router

  plug(Plug.Logger)
  plug(:match)
  plug(Plug.Parsers, parsers: [:json], json_decoder: {Jason, :decode!, [[keys: :atoms]]})
  plug(:dispatch)

  post "/receipts/process" do
    ReceiptProcessor.Controller.process(conn)
  end

  get "/receipts/:id/points" do
    ReceiptProcessor.Controller.points(conn)
  end

  get "/hello" do
    send_resp(conn, 200, "world")
  end

  match _ do
    send_resp(conn, 404, "not found")
  end
end
