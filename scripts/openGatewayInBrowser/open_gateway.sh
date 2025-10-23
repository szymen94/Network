#!/bin/bash

# 1. Check IP
ip_addr=$(ifconfig 2>/dev/null | awk '/inet / && $2!="127.0.0.1"{print $2; exit}')
# alternative:
# ip_addr=$(ip addr show | awk '/inet / && $2!="127.0.0.1"/{gsub(/\/.*$/,"",$2); print $2; exit}')

echo "IP Address: $ip_addr"

# 2. Check gateway IP
gateway=$(ip route | awk '/^default/ {print $3; exit}')
# other options: route -n | grep '^0.0.0.0' | awk '{print $2}'

echo "Default Gateway: $gateway"

# 3. Open gateway in browser
if command -v xdg-open >/dev/null; then
  xdg-open "http://$gateway"
elif command -v sensible-browser >/dev/null; then
  sensible-browser "http://$gateway"
else
  echo "No browser opening tool found."
fi
