# ReceiptProcessor

Score receipts with custom rules.

## Installation

```
docker build -t gearhartlove/receipt_processor
docker image ls # you should see 'gearhartlove/receipt_processor in your list'
docker run -it -p 4000:4000 gearhartlove/receipt_processor 
```

If you see this, than your server is running and ready to receive requests on port 4000. 
If you have another application accepting input on port 4000 you will need to close it while 
you run this server.

```
01:05:23.606 [info] Running ReceiptProcessor.Router with Bandit 1.6.4 at 0.0.0.0:4000 (http)
```
