# akl-docker

## Build

```
# docker build -t "dregu/csgo:latest" .
```

This might take hours.

## Deploy server

```
# ./server.sh
  -i index 
  -g gslt
  -l sv_lan
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
```

Server number 1 will get default ports, server number n gets 27015+(n-1)*100.
If you specify port with -P, tvport will be serverport+5 and clientport will be serverport-10.

## Access console

```
# docker attach cs1
```

Detach with Ctrl+P Ctrl+Q.

## Customize

```
# docker exec -it cs1 bash
$ vim serverfiles/csgo/cfg/csgo-server.cfg
$ exit
# docker restart cs1
```
