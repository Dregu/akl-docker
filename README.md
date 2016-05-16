# akl-docker

## Build

```
# docker build -t "dregu/csgo:latest" .
```

## Deploy server

```
# vim server.sh               # Change passwords and naming schemes.
# ./server.sh <NUM> <GSLT>
```

Server number 1 will get default ports, server number n gets 27015+(n-1)*100.

## Access console

```
# docker attach akl1
```

Detach with ctrl+p ctrl+q.

## Customize

```
# docker exec -it akl1 bash
$ vim serverfiles/csgo/cfg/csgo-server.cfg
$ exit
# docker restart akl1
```
