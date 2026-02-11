#!/usr/bin/env bash
set -e

SBOX_OUT="$HOME/.openclaw/sandboxes/agent-main-0d71ad7a/openclaw-drive/agent-out"
HOST_OUT="$HOME/openclaw-drive/agent-out"

mkdir -p "$SBOX_OUT" "$HOST_OUT"

while true; do
  rsync -a --delete "$SBOX_OUT/" "$HOST_OUT/"
  sleep 15
done
