#!/bin/bash

# --- Configuration ---
MAILGUN_API_KEY=""
MAILGUN_DOMAIN=""
TO_EMAIL=""  # Change this to your real email address
FROM_EMAIL="stream@$MAILGUN_DOMAIN"
PORT=8080
WAIT_TIME=1320  # 22 minutes = 22 * 60 seconds

# --- Loop ---
echo "Starting ngrok tunnel..."
ngrok http $PORT > /dev/null &
NGROK_PID=$!
sleep 6  # Wait for ngrok to initialize

URL=$(curl -s http://127.0.0.1:4040/api/tunnels | jq -r '.tunnels[0].public_url')

echo "Sending ngrok URL: $URL"

curl -s --user "api:$MAILGUN_API_KEY" \
"https://api.mailgun.net/v3/$MAILGUN_DOMAIN/messages" \
-F from="$FROM_EMAIL" \
-F to="$TO_EMAIL" \
-F subject="🎥 Your new ngrok streaming link" \
-F text="Your new stream link is: $URL"

echo "Email sent. Waiting $((WAIT_TIME/60)) minutes..."

sleep $WAIT_TIME
kill $NGROK_PID
