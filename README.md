# akl-docker

(Yet another) Dockerfile and start script for cs:go. Uses [LGSM](https://gameservermanagers.com/lgsm/csgoserver/) for installation and easy updates. Supports custom ip:port and source nat for outbound connections.

## Build

```
# docker build -t "dregu/csgo:latest" .
```

This might take hours. You might want to edit your Dockerfile to change the timezone and whatnot.

## Deploy server

```
# sudo ./server.sh
  -i index 
  -g gslt
  -h hostname
  -r rcon_password
  -p password
  -t tickrate  
  -m map
  -M maxplayers
  -o game_mode
  -y game_type
  -P port
  -I ip
  -e docker entrypoint
  -H docker hostname
```

If you use -i, server number 1 will get default ports, server number n gets 27015+(n-1)*100.
If you use -P, tvport will be serverport+5 and clientport will be serverport-10.
If you use -I, the script will try to make a source nat with iptables, so use sudo.

## Access console

```
# docker attach CID
```

Detach with Ctrl+P Ctrl+Q.

## Customize

```
# docker exec -it CID bash
  $ vim serverfiles/csgo/cfg/csgo-server.cfg
  $ exit
# docker restart CID
```
