#!/usr/bin/env bash

APPNAME="ifconfig"
DOCKER_HUB_URL="mpolden/echoip:latest"

sudo mkdir -p "$DATADIR"
sudo chmod -Rf 777 "$DATADIR"

if docker ps -a | grep "$APPNAME" >/dev/null 2>&1; then
  sudo docker pull "$DOCKER_HUB_URL"
  sudo docker restart "$APPNAME"
else
  sudo docker run \
    --detach \
    --name ifconfig \
    -p 85:8080 \
    --restart=always \
    "$DOCKER_HUB_URL" echoip -p -H X-Forwarded-For
fi
