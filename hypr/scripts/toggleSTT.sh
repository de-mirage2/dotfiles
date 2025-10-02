#!/bin/bash

DICTATION_CMD="nerd-dictation begin --timeout 3 --simulate-input-tool WTYPE --full-sentence"

PID_FILE="/tmp/nerd-dictation.pid"

if [ -f "$PID_FILE" ]; then
    PID=$(cat "$PID_FILE")
    if kill -0 "$PID" 2>/dev/null; then
        echo "Stopping nerd-dictation (PID: $PID)..."
        nerd-dictation end
        rm "$PID_FILE"
        exit 0
    else
        echo "Stale PID file found. Removing..."
        rm "$PID_FILE"
    fi
fi

echo "Starting nerd-dictation..."
$DICTATION_CMD &
NEW_PID=$!
echo "$NEW_PID" > "$PID_FILE"

