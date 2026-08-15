#!/bin/bash
set -e

# Start tailscaled in the background
tailscaled --state=/var/lib/tailscale/tailscaled.state &

# Give it a moment to start
sleep 2

# Bring up Tailscale using the auth key from Railway env vars
tailscale up --authkey="${TS_AUTHKEY}" --hostname=railway-box

# Start xrdp
service xrdp start

# Keep the container alive
tail -f /dev/null