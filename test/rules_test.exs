defmodule RulesTest do
  use ExUnit.Case, async: true

  test "example 1" do
    receipt =
      """
      {
      "retailer": "Target",
      "purchaseDate": "2022-01-01",
      "purchaseTime": "13:01",
      "items": [
      {
      "shortDescription": "Mountain Dew 12PK",
      "price": "6.49"
      },{
      "shortDescription": "Emils Cheese Pizza",
      "price": "12.25"
      },{
      "shortDescription": "Knorr Creamy Chicken",
      "price": "1.26"
      },{
      "shortDescription": "Doritos Nacho Cheese",
      "price": "3.35"
      },{
      "shortDescription": "   Klarbrunn 12-PK 12 FL OZ  ",
      "price": "12.00"
      }
      ],
      "total": "35.35"
      }
      """
      |> Jason.decode!(keys: :atoms)

    receipt = struct(ReceiptProcessor.Schemas.Receipt, receipt)

    scoreboard = ReceiptProcessor.Rules.score(receipt)

    assert 28 == scoreboard[:total]
  end

  test "example 2" do
    receipt =
      """
      {
      "retailer": "M&M Corner Market",
      "purchaseDate": "2022-03-20",
      "purchaseTime": "14:33",
      "items": [
      {
      "shortDescription": "Gatorade",
      "price": "2.25"
      },{
      "shortDescription": "Gatorade",
      "price": "2.25"
      },{
      "shortDescription": "Gatorade",
      "price": "2.25"
      },{
      "shortDescription": "Gatorade",
      "price": "2.25"
      }
      ],
      "total": "9.00"
      }
      """
      |> Jason.decode!(keys: :atoms)

    receipt = struct(ReceiptProcessor.Schemas.Receipt, receipt)

    scoreboard = ReceiptProcessor.Rules.score(receipt)

    assert 109 == scoreboard[:total]
  end

  test "example 3" do
    receipt =
      """
      {
      "retailer": "Walgreens",
      "purchaseDate": "2022-01-02",
      "purchaseTime": "08:13",
      "total": "2.65",
      "items": [
        {"shortDescription": "Pepsi - 12-oz", "price": "1.25"},
        {"shortDescription": "Dasani", "price": "1.40"}
      ]
      }
      """
      |> Jason.decode!(keys: :atoms)

    receipt = struct(ReceiptProcessor.Schemas.Receipt, receipt)

    scoreboard = ReceiptProcessor.Rules.score(receipt)

    # alpha - 9
    # pair - 5 
    # desc_mul_3 - 1 // note: is 0.27 rounded up to 1

    assert 15 == scoreboard[:total]
  end

  test "example 4" do
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
      |> Jason.decode!(keys: :atoms)

    receipt = struct(ReceiptProcessor.Schemas.Receipt, receipt)

    scoreboard = ReceiptProcessor.Rules.score(receipt)

    # alpha - 6
    # 25multiple - 25

    assert 31 = scoreboard[:total]
  end
end
