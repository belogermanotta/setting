#!/usr/bin/env bash

set -e

HOST_ROOT="$HOME/openclaw-drive"
SBOX_ROOT="$HOME/.openclaw/sandboxes/agent-main-0d71ad7a/openclaw-drive"

mkdir -p "$SBOX_ROOT"

while true; do
  rsync -a --delete "$HOST_ROOT/" "$SBOX_ROOT/"
  sleep 5
done
