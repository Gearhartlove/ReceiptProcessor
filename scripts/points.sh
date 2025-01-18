read response
id=$(echo $response | jq .id | tr -d '"')

echo ""
echo "id=${id}"
echo ""

curl -i http://localhost:4000/receipts/${id}/points
