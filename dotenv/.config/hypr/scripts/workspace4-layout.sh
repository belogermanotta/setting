#!/bin/bash
# Applies the Hermes 40% / Claude Desktop 40% / YouTube Music 20% layout
# on workspace 4. Run from autostart, after all three normally exist.
#
# Two known quirks in this Hyprland build, worked around here:
# - A freshly-moved-in window can land stacked (top/bottom) instead of in
#   the row, so this checks heights first and un-stacks via togglesplit.
# - A single resize call sometimes has no effect, and resizing the outer
#   (Hermes vs. rest) split redistributes freed space proportionally into
#   the inner split rather than resetting it -- so each resize is retried
#   until verified, outer settled before inner.
#
# Not bulletproof: after a lot of churn (repeated moves/swaps/resizes on
# the same workspace) the resize dispatcher can get stuck returning no-ops
# no matter what's requested. If that happens, closing and relaunching the
# stuck app clears it -- this script does not do that automatically, since
# auto-closing a running app to fix layout is worse than leaving it sized
# wrong until told to.

get_addr() {
  hyprctl clients -j | python3 -c "
import json, re, sys
data = json.load(sys.stdin)
for w in data:
    if re.search('$1', w.get('class', '')) and w.get('workspace', {}).get('name') == '4':
        print(w.get('address'))
        break
"
}

get_width() {
  hyprctl clients -j | python3 -c "
import json, sys
data = json.load(sys.stdin)
for w in data:
    if w.get('address') == '$1':
        print(w['size'][0])
        break
"
}

get_height() {
  hyprctl clients -j | python3 -c "
import json, sys
data = json.load(sys.stdin)
for w in data:
    if w.get('address') == '$1':
        print(w['size'][1])
        break
"
}

# Focus $1, resize it to width $2 / height $3, retrying (up to 6x) until
# its actual width is within 15px of the target.
resize_until() {
  local addr=$1 target=$2 height=$3
  for i in 1 2 3 4 5 6; do
    hyprctl eval "hl.dispatch(hl.dsp.focus({ window = 'address:$addr' }))" >/dev/null 2>&1
    sleep 0.3
    hyprctl eval "hl.dispatch(hl.dsp.window.resize({ x = $target, y = $height }))" >/dev/null 2>&1
    sleep 0.5
    local width diff
    width=$(get_width "$addr")
    [ -z "$width" ] && continue
    diff=$(( width - target ))
    diff=${diff#-}
    [ "$diff" -le 15 ] && return 0
  done
  return 1
}

# Wait up to 30s for all three target windows to exist on workspace 4.
for i in $(seq 1 60); do
  H=$(get_addr '^Hermes$')
  C=$(get_addr '^com\.anthropic\.Claude$')
  Y=$(get_addr 'youtube\.com__')
  [ -n "$H" ] && [ -n "$C" ] && [ -n "$Y" ] && break
  sleep 0.5
done
[ -n "$H" ] && [ -n "$C" ] && [ -n "$Y" ] || exit 0

# Un-stack: if the three aren't all the same height, one pair is stacked
# top/bottom. Toggle the shorter one's split to horizontal, up to 3 times.
for i in 1 2 3; do
  read -r max_h min_h short_addr <<EOF
$(hyprctl clients -j | python3 -c "
import json, sys
data = json.load(sys.stdin)
ws4 = [w for w in data if w.get('workspace', {}).get('name') == '4']
if not ws4:
    print('0 0')
else:
    heights = [w['size'][1] for w in ws4]
    short = min(ws4, key=lambda w: w['size'][1])
    print(max(heights), min(heights), short['address'])
")
EOF
  diff=$(( max_h - min_h ))
  [ "$diff" -le 30 ] && break
  [ -z "$short_addr" ] && break
  hyprctl eval "hl.dispatch(hl.dsp.focus({ window = 'address:$short_addr' }))" >/dev/null 2>&1
  sleep 0.3
  hyprctl eval "hl.dispatch(hl.dsp.layout('togglesplit'))" >/dev/null 2>&1
  sleep 0.7
done

height=$(get_height "$H")
total=$(hyprctl clients -j | python3 -c "
import json, sys
data = json.load(sys.stdin)
print(sum(w['size'][0] for w in data if w.get('workspace', {}).get('name') == '4'))
")

h_target=$(( total * 40 / 100 ))
c_target=$(( total * 40 / 100 ))
y_target=$(( total - h_target - c_target ))

# Settle the outer split (Hermes vs. the Claude/YouTube pair) first.
resize_until "$H" "$h_target" "$height"

# Then the inner split (Claude vs. YouTube).
resize_until "$C" "$c_target" "$height"

# The inner resize sometimes sets YouTube's width instead of Claude's
# (order-dependent quirk). Detect that and swap them directly by address.
y_width=$(get_width "$Y")
diff=$(( y_width - y_target ))
diff=${diff#-}
if [ "$diff" -gt 15 ]; then
  hyprctl eval "hl.dispatch(hl.dsp.focus({ window = 'address:$C' }))" >/dev/null 2>&1
  sleep 0.3
  hyprctl eval "hl.dispatch(hl.dsp.window.swap({ other = 'address:$Y' }))" >/dev/null 2>&1
  sleep 0.5
fi
