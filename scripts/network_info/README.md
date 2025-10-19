# Network Info Script

A simple Bash script to display network interface details in a readable format.  

## Features
- Shows all non-loopback interfaces
- Displays for each interface:
  - IP address
  - Subnet mask (CIDR)
  - Gateway
  - DNS servers
  - Interface state (up/down)
  - IP assignment type (DHCP or Static)

## Usage

1. Make the script executable:
```bash
chmod +x network_info.sh

2. Run the script:
'''bash
./network_info.sh
