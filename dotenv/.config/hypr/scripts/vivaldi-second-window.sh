#!/bin/bash
# Opens a second Vivaldi window in the SAME profile (same logins/history/
# cookies as the main window) and moves it to workspace 5. Chromium-based
# browsers only get a distinct window class for a genuinely separate
# process/profile, so a same-profile window can't be routed by a static
# windowrules.lua class rule -- instead, this records which vivaldi-stable
# windows exist before launching, then moves whichever new one shows up.

get_vivaldi_addrs() {
  hyprctl clients -j | python3 -c "
import json, sys
data = json.load(sys.stdin)
print(' '.join(w['address'] for w in data if w.get('class') == 'vivaldi-stable'))
"
}

before=" $(get_vivaldi_addrs) "

uwsm-app -- vivaldi-stable --new-window &

new_addr=""
for i in $(seq 1 60); do
  for addr in $(get_vivaldi_addrs); do
    case "$before" in
      *" $addr "*) ;;
      *) new_addr="$addr" ;;
    esac
  done
  [ -n "$new_addr" ] && break
  sleep 0.5
done
[ -n "$new_addr" ] || exit 0

hyprctl eval "hl.dispatch(hl.dsp.focus({ window = 'address:$new_addr' }))" >/dev/null 2>&1
sleep 0.3
hyprctl eval "hl.dispatch(hl.dsp.window.move({ workspace = '6', follow = false }))" >/dev/null 2>&1
