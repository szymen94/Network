#!/bin/bash

# 1. Pobranie IP interfejsu
ip_addr=$(ifconfig 2>/dev/null | awk '/inet / && $2!="127.0.0.1"{print $2; exit}')
# alternatywnie:
# ip_addr=$(ip addr show | awk '/inet / && $2!="127.0.0.1"/{gsub(/\/.*$/,"",$2); print $2; exit}')

echo "Adres IP: $ip_addr"

# 2. Pobranie bramy domyślnej
gateway=$(ip route | awk '/^default/ {print $3; exit}')
# inne opcje: route -n | grep '^0.0.0.0' | awk '{print $2}' :contentReference[oaicite:4]{index=4}

echo "Brama domyślna: $gateway"

# 3. Otwarcie bramy w przeglądarce
if command -v xdg-open >/dev/null; then
  xdg-open "http://$gateway"
elif command -v sensible-browser >/dev/null; then
  sensible-browser "http://$gateway"
else
  echo "Nie znaleziono narzędzia do otwierania przeglądarki."
fi
