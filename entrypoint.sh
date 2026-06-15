#!/bin/bash
set -e

# Start SSH daemon explicitly in background
/usr/sbin/sshd -D &
SSHD_PID=$!
echo "sshd started with PID $SSHD_PID"

# Add ngrok authtoken
if [ -n "$NGROK_AUTHTOKEN" ]; then
    ngrok config add-authtoken "$NGROK_AUTHTOKEN"
else
    echo "ENV NGROK_AUTHTOKEN WAS NOT PROVIDED"
    exit 1
fi

# Wait for sshd to be ready
sleep 1

# Confirm sshd is still alive
kill -0 $SSHD_PID || { echo "sshd died!"; exit 1; }

# Start ngrok
exec ngrok "$@"