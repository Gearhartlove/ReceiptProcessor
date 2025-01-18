# ReceiptProcessor

Score receipts with custom rules.

## Run the application

```
$ docker build -t gearhartlove/receipt_processor
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
$ cd scripts
$ ./process.sh | ./points.sh
  % Total    % Received % Xferd  Average Speed   Time    Time     Time  Current
                                 Dload  Upload   Total   Spent    Left  Speed
100   561  100    28  100   533  13339   247k --:--:-- --:--:-- --:--:--  273k

id=-576460752303423486

HTTP/1.1 200 OK
date: Sat, 18 Jan 2025 01:10:54 GMT
content-length: 15
vary: accept-encoding
cache-control: max-age=0, private, must-revalidate

{"points":28.0}⏎
```
