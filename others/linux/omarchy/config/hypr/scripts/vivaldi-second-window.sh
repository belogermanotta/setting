#!/bin/bash
# Opens a second Vivaldi window in the SAME profile (same logins/history/
# cookies as the main window) and moves it to workspace 6. Chromium-based
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

# Focus+move in one eval so another login window (Discord) cannot steal
# focus between the two dispatches. Verify the addressed window landed on 6.
for i in 1 2 3 4 5 6; do
  hyprctl eval "hl.dispatch(hl.dsp.focus({ window = 'address:$new_addr' })); hl.dispatch(hl.dsp.window.move({ workspace = '6', follow = false }))" >/dev/null 2>&1
  ws=$(hyprctl clients -j | python3 -c "
import json, sys
addr = '''$new_addr'''
data = json.load(sys.stdin)
for w in data:
    if w.get('address') == addr:
        print(w.get('workspace', {}).get('name', ''))
        break
")
  [ "$ws" = "6" ] && exit 0
  sleep 0.2
done
