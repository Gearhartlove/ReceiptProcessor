# ReceiptProcessor

Score receipts with custom rules.

## Run the application

```
# from the root directory of the project
$ docker build -t gearhartlove/receipt_processor .
$ docker image ls # you should see 'gearhartlove/receipt_processor in your list'
$ docker run -it -p 4000:4000 gearhartlove/receipt_processor 
```

If you see this, than your server is running and ready to receive requests on port 4000. 
If you have another application accepting input on port 4000 you will need to close it while 
you run this server.

```
01:05:23.606 [info] Running ReceiptProcessor.Router with Bandit 1.6.4 at 0.0.0.0:4000 (http)
```

To test if the server you can run these simple curl scripts in /scripts
```
curl -H 'Content-Type: application/json' \
	-d '{
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
}' \
	-X POST \
	http://localhost:4000/receipts/process

```
