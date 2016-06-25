#!/bin/bash

GSLT=
HOSTNAME=CS:GO
RCONPASSWORD=
PASSWORD=
TICKRATE=128
MAP=de_dust2
MAPGROUP=mg_active
MAXPLAYERS=16
GAMEMODE=1
GAMETYPE=0
IP=
SERVERPORT=27015
TVPORT=27020
CLIENTPORT=27005
DOCKERNAME=
ENTRYPOINT=/home/cs/start
CUSTOM=

while getopts "i:g:h:r:p:t:m:M:o:y:P:I:e:H:c:" i; do
  case $i in
    i)
      I=$OPTARG
      DOCKERNAME="--name cs$I -h cs$I"
      HOSTNAME="CS:GO #$I"
      PORTOFFSET=$((($I-1)*100))
      SERVERPORT=$((27015+$PORTOFFSET))
      TVPORT=$((27020+$PORTOFFSET))
      CLIENTPORT=$((27005+$PORTOFFSET))
      ;;
    g)
      GSLT="$OPTARG"
      ;;
    h)
      HOSTNAME="$OPTARG"
      ;;
    r)
      RCONPASSWORD="$OPTARG"
      ;;
    p)
      PASSWORD="$OPTARG"
      ;;
    t)
      TICKRATE="$OPTARG"
      ;;
    m)
      MAP="$OPTARG"
      ;;
    M)
      MAXPLAYERS="$OPTARG"
      ;;
    o)
      GAMEMODE="$OPTARG"      
      ;;
    y)
      GAMETYPE="$OPTARG"
      ;;
    P)
      SERVERPORT="$OPTARG"
      TVPORT=$(($SERVERPORT+5))
      CLIENTPORT=$(($SERVERPORT-10))
      ;;
    I)
      IP="$OPTARG"
      ;;
    e)
      ENTRYPOINT="$OPTARG"
      ;;
    H)
      DOCKERNAME="--name $OPTARG -h $OPTARG"
      ;;
    c)
      CUSTOM="$OPTARG"
      ;;
    \?)
      echo 'Usage: ./server.sh
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
  -c custom variables to srcds'
      exit 1
      ;;
  esac
done

if [[ $IP ]]; then
  SERVERPORT="$IP:$SERVERPORT"
  TVPORT="$IP:$TVPORT"
  CLIENTPORT="$IP:$CLIENTPORT"
fi
mkdir -p -m a+rw /home/cs/matches
CID=`docker run -dti $DOCKERNAME --privileged=true -v /home/cs/matches:/home/cs/serverfiles/csgo/matches -p $SERVERPORT:27015/tcp -p $SERVERPORT:27015/udp -p $TVPORT:27020/tcp -p $TVPORT:27020/udp -p $CLIENTPORT:27005/udp -e TICKRATE="$TICKRATE" -e GSLT="$GSLT" -e MAP="$MAP" -e MAXPLAYERS="$MAXPLAYERS" -e MAPGROUP="$MAPGROUP" -e GAMEMODE="$GAMEMODE" -e GAMETYPE="$GAMETYPE" -e HOSTNAME="$HOSTNAME" -e RCONPASSWORD="$RCONPASSWORD" -e PASSWORD="$PASSWORD" -e CUSTOM="$CUSTOM" -e PUBLIC="$IP" --entrypoint "$ENTRYPOINT" dregu/csgo`
[[ $IP ]] && iptables -t nat -I POSTROUTING -p all -s `docker inspect --format '{{ .NetworkSettings.IPAddress }}' $CID` -j SNAT --to-source "$IP"
