#!/bin/sh /etc/rc.common
uci set glconfig.openvpn.enable=0
uci commit glconfig
killall openvpn || true
/etc/init.d/startvpn stop
/usr/bin/setvpnfirewall --disable