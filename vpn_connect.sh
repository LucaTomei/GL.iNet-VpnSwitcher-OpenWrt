#!/bin/sh /etc/rc.common
uci set glconfig.openvpn.enable=1
uci commit glconfig
/etc/init.d/startvpn start
