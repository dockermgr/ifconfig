#!/usr/bin/env bash

APPNAME="ifconfig"
DATADIR="/srv/docker/$APPNAME"

mkdir -p "$DATADIR" && chmod -Rf 777 "$DATADIR"

if docker ps -a | grep "$APPNAME" >/dev/null 2>&1; then
docker pull mpolden/echoip:latest && docker restart $APPNAME
else
docker run \
--detach \
--name ifconfig \
-p 85:8080 \
--restart=always \
mpolden/echoip:latest echoip -p -H X-Forwarded-For
fi
