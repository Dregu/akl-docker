#!/bin/bash

HOSTNAME=AKL\#$1
RCONPASSWORD=foo
PASSWORD=bar
TICKRATE=128
MAP=de_dust2
MAPGROUP=random_classic
MAXPLAYERS=16
GAMEMODE=1
GAMETYPE=0
TVENABLE=1

PORTOFFSET=$((($1-1)*100))
SERVERPORT=$((27015+$PORTOFFSET))
TVPORT=$((27020+$PORTOFFSET))
CLIENTPORT=$((27005+$PORTOFFSET))

docker run -dti --name akl$1 -h akl$1 -p $SERVERPORT:27015/tcp -p $SERVERPORT:27015/udp -p $TVPORT:27020/udp -p $CLIENTPORT:27005/udp --entrypoint /home/cs/serverfiles/srcds_run dregu/csgo -game csgo -usercon -strictportbind -ip 0.0.0.0 -port 27015 +clientport 27005 +tv_port 27020 -tickrate $TICKRATE +sv_setsteamaccount $2 +map $MAP +servercfgfile csgo-server.cfg -maxplayers_override $MAXPLAYERS +mapgroup $MAPGROUP +game_mode $GAMEMODE +game_type $GAMETYPE
docker exec akl$1 sed -i "/hostname \"/s/\"\([^\\\"]*\)\"/\"$HOSTNAME\"/" serverfiles/csgo/cfg/csgo-server.cfg
docker exec akl$1 sed -i "/rcon_password \"/s/\"\([^\\\"]*\)\"/\"$RCONPASSWORD\"/" serverfiles/csgo/cfg/csgo-server.cfg
docker exec akl$1 sed -i "/sv_password \"/s/\"\([^\\\"]*\)\"/\"$PASSWORD\"/" serverfiles/csgo/cfg/csgo-server.cfg
docker exec akl$1 echo tv_enable "$TVENABLE" \>\> serverfiles/csgo/cfg/csgo-server.cfg
