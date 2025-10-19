#!/bin/bash

# Simple network info script
# Shows: Interface, IP, Subnet, Gateway, DNS, State, DHCP/Static

echo "=== Network Information ==="
echo ""

# List interfaces excluding loopback
for iface in $(ip -o link show | awk -F': ' '{print $2}' | grep -v lo); do
    echo "Interface: $iface"

    # State (up/down)
    state=$(cat /sys/class/net/$iface/operstate)
    echo "State: $state"

    # IPv4 address & subnet mask
    ip_addr=$(ip -4 addr show $iface | grep -oP '(?<=inet\s)\d+(\.\d+){3}')
    subnet=$(ip -4 addr show $iface | grep -oP '(?<=inet\s)\d+(\.\d+){3}/\d+' | cut -d/ -f2)
    echo "IP: ${ip_addr:-N/A}/${subnet:-N/A}"$LINES

    # Gateway
    gw=$(ip route | grep "^default" | grep " $iface" | awk '{print $3}')
    echo "Gateway: ${gw:-N/A}"

    # DNS
    dns=$(grep -v '^#' /etc/resolv.conf | grep nameserver | awk '{print $2}' | xargs)
    echo "DNS: ${dns:-N/A}"

    # DHCP / Static
    dhcp=$(nmcli device show $iface | grep IP4.DHCP)
    if [ -n "$dhcp" ]; then
        echo "DHCP enabled: yes"
    else
    fi

    echo "-----------------------------"
done
