#!/usr/bin/env bash

set -e

HOST_ROOT="$HOME/openclaw-drive"
SBOX_ROOT="$HOME/.openclaw/sandboxes/agent-main-0d71ad7a/openclaw-drive"

mkdir -p "$SBOX_ROOT"

while true; do
  rsync -a ~/.openclaw/media/ \
    "$HOST_ROOT/media/"
  sleep 1

  rsync -a --delete \
    --exclude 'agent-out/' \
    "$HOST_ROOT/" "$SBOX_ROOT/"
  sleep 5
done
