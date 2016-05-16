# akl-docker

## Build

```
docker build -t "dregu/csgo:latest" .
```

## Deploy server

```
./server.sh <SERVERNUM> <GSLT>
```

Server number 1 will get default ports, server number n gets 27015+(n-1)*100

## Customize

```
docker exec -it akl<SERVERNUM> bash
vim serverfiles/csgo/cfg/csgo-server.cfg
```
