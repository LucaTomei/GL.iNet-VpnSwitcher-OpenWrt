# GL.iNet-Vpn-Switcher OpenWrt

These scripts are able to switch Gl.iNet button and connect to openvpn profile uploaded.


### Example of usage using Crontab

```console
lucasmac@lucasmac:~$ ssh root@192.168.8.1
root@192.168.8.1's password:
```
Insert your password

```console
root@GL-AR300M:~# crontab -e
```
paste this code

```
20 19 * * * /root/vpn_connect
10 1 * * */root/vpn_disconnect
```

Every day at 19:20 you are connected to vpn and every day at 1:10 you are disconnected.
