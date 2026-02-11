### 1) Create shared dirs (host + sandbox)

 On your laptop (host):

 ```bash
   mkdir -p ~/openclaw-drive/{screenshots,download,scripts,log,notes}
 ```

 In my sandbox:

 ```bash
   mkdir -p ~/.openclaw/sandboxes/agent-main-0d71ad7a/openclaw-drive/{screenshots,download,scripts,log,notes}
 ```

 We’ll use:

- Host root: ~/openclaw-drive/
- Sandbox root: ~/.openclaw/sandboxes/agent-main-0d71ad7a/openclaw-drive/

### 2) Script: host → sandbox (one-way mirror)

 ~/.local/bin/oc-drive-host-to-sandbox.sh:

 ```bash
   #!/usr/bin/env bash
   set -e

   HOST_ROOT="$HOME/openclaw-drive"
   SBOX_ROOT="$HOME/.openclaw/sandboxes/agent-main-0d71ad7a/openclaw-drive"

   mkdir -p "$SBOX_ROOT"

   while true; do
     rsync -a --delete "$HOST_ROOT/" "$SBOX_ROOT/"
     sleep 15
   done
 ```

 Make it executable:

 ```bash
   chmod +x ~/.local/bin/oc-drive-host-to-sandbox.sh
 ```

 This keeps the sandbox’s openclaw-drive as a mirror of your host.

### 3) (Optional) Script: sandbox → host (agent-out only)

 To avoid collisions, use a separate subdir for my outputs:

 ```bash
   mkdir -p ~/openclaw-drive/agent-out
   mkdir -p ~/.openclaw/sandboxes/agent-main-0d71ad7a/openclaw-drive/agent-out
 ```

 ~/.local/bin/oc-drive-sandbox-to-host.sh:

 ```bash
   #!/usr/bin/env bash
   set -e

   SBOX_OUT="$HOME/.openclaw/sandboxes/agent-main-0d71ad7a/openclaw-drive/agent-out"
   HOST_OUT="$HOME/openclaw-drive/agent-out"

   mkdir -p "$SBOX_OUT" "$HOST_OUT"

   while true; do
     rsync -a --delete "$SBOX_OUT/" "$HOST_OUT/"
     sleep 15
   done
 ```

 ```bash
   chmod +x ~/.local/bin/oc-drive-sandbox-to-host.sh
 ```

### 4) Run them as user services (so you can enable/disable)

 Host → sandbox service
 ~/.config/systemd/user/oc-drive-host-to-sandbox.service:

 ```ini
   [Unit]
   Description=Sync host openclaw-drive to sandbox

   [Service]
   ExecStart=%h/.local/bin/oc-drive-host-to-sandbox.sh
   Restart=always

   [Install]
   WantedBy=default.target
 ```

 Sandbox → host service (optional)
 ~/.config/systemd/user/oc-drive-sandbox-to-host.service:

 ```ini
   [Unit]
   Description=Sync sandbox agent-out to host openclaw-drive

   [Service]
   ExecStart=%h/.local/bin/oc-drive-sandbox-to-host.sh
   Restart=always

   [Install]
   WantedBy=default.target
 ```

 Enable + start:

 ```bash
   systemctl --user daemon-reload
   systemctl --user enable oc-drive-host-to-sandbox.service
   systemctl --user start  oc-drive-host-to-sandbox.service

   # optional reverse direction
   systemctl --user enable oc-drive-sandbox-to-host.service
   systemctl --user start  oc-drive-sandbox-to-host.service
 ```

 Control later:

 ```bash
   systemctl --user stop    oc-drive-host-to-sandbox.service
   systemctl --user disable oc-drive-host-to-sandbox.service
   systemctl --user status  oc-drive-host-to-sandbox.service
 ```
