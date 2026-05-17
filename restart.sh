#!/bin/bash

# Find and kill the process running on port 8000
PID=$(lsof -t -i:8000)

if [ -n "$PID" ]; then
    echo "Stopping existing server (PID: $PID)..."
    kill $PID
    # Wait a moment for the port to be released
    sleep 0.5
fi

echo "Starting server at http://localhost:8000..."
uv run serve.py &
