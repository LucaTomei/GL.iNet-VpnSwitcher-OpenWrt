#!/bin/sh
set -eu
logger "$BUTTON ${ACTION}"

# Drop in /etc/rc.buttons once you have your VPN configured through the
# built-in interface.  Switch toward the front for VPN enabled.

# Notes:
# - "startvpn start" ends with a background openvpn process that may not be up
# yet or ever be up -- config/connectivity issues -- but we still enforce the
# user preference for force-vpn so they can decide what do do.
# - the expected vpn device is in uci "network.VPN_client.ifname"
#
# GL-AR300M:
#   Current FW: 2.25
#   $BUTTON:
#     BTN_0 - internal
#     BTN_1 - physical switch on side
#   $ACTION:
#     pressed  - left/back of device
#     released - right/front of device


VPN_ON="$(uci get glconfig.openvpn.enable)"
VPN_FORCE="$(uci get glconfig.openvpn.force)"

if [ "$ACTION" == "pressed" ]; then
  [ "$VPN_ON" -eq "1" ] || exit
  uci set glconfig.openvpn.enable=0
  uci commit glconfig

  killall openvpn || true
  /etc/init.d/startvpn stop
  /usr/bin/setvpnfirewall --disable

  logger "== VPN switch down =="
else
  [ "$VPN_ON" -eq "0" ] || exit
  uci set glconfig.openvpn.enable=1
  uci commit glconfig

  /etc/init.d/startvpn start
  if [ "$VPN_FORCE" -eq "1" ]; then
    /usr/bin/setvpnfirewall --force
  else
    /usr/bin/setvpnfirewall --noforce
  fi
 
  logger "== VPN switch up =="
fi

