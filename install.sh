#!/usr/bin/env bash
# - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - -
APPNAME="ifconfig"
VERSION="202107311147-git"
USER="${SUDO_USER:-${USER}}"
HOME="${USER_HOME:-${HOME}}"
SRC_DIR="${BASH_SOURCE%/*}"
# - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - -
#set opts

# - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - -
##@Version       : 202107311147-git
# @Author        : casjay
# @Contact       : casjay
# @License       : WTFPL
# @ReadME        : dockermgr --help
# @Copyright     : Copyright: (c) 2021 casjay, casjay
# @Created       : Saturday, Jul 31, 2021 11:47 EDT
# @File          : ifconfig
# @Description   : ifconfig docker container installer
# @TODO          :
# @Other         :
# @Resource      :
# - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - -
# Import functions
CASJAYSDEVDIR="${CASJAYSDEVDIR:-/usr/local/share/CasjaysDev/scripts}"
SCRIPTSFUNCTDIR="${CASJAYSDEVDIR:-/usr/local/share/CasjaysDev/scripts}/functions"
SCRIPTSFUNCTFILE="${SCRIPTSAPPFUNCTFILE:-testing.bash}"
SCRIPTSFUNCTURL="${SCRIPTSAPPFUNCTURL:-https://github.com/dfmgr/installer/raw/$GIT_DEFAULT_BRANCH/functions}"
# - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - -
if [ -f "$PWD/$SCRIPTSFUNCTFILE" ]; then
  . "$PWD/$SCRIPTSFUNCTFILE"
elif [ -f "$SCRIPTSFUNCTDIR/$SCRIPTSFUNCTFILE" ]; then
  . "$SCRIPTSFUNCTDIR/$SCRIPTSFUNCTFILE"
else
  echo "Can not load the functions file: $SCRIPTSFUNCTDIR/$SCRIPTSFUNCTFILE" 1>&2
  exit 1
fi
# - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - -
# user system devenv dfmgr dockermgr fontmgr iconmgr pkmgr systemmgr thememgr wallpapermgr
dockermgr_install
__options "$@"
# - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - -
# Begin installer
APPNAME="ifconfig"
DOCKER_HUB_URL="mpolden/echoip"
# - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - -
APPDIR="${APPDIR:-/usr/local/share/CasjaysDev/$SCRIPTS_PREFIX/$APPNAME}"
INSTDIR="${INSTDIR:-/usr/local/share/CasjaysDev/$SCRIPTS_PREFIX/$APPNAME}"
DATADIR="${DATADIR:-/srv/docker/$APPNAME}"
REPORAW="$REPO/raw/$GIT_DEFAULT_BRANCH"
APPVERSION="$(__appversion "$REPORAW/version.txt")"
TIMEZONE="${TZ:-$TIMEZONE}"
# - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - -
sudo mkdir -p "$DATADIR"/{data}
sudo chmod -Rf 777 "$DATADIR"
# - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - -
if [ -f "$INSTDIR/docker-compose.yml" ]; then
  printf_blue "Installing containers using docker compose"
  sed -i "s|REPLACE_DATADIR|$DATADIR" "$INSTDIR/docker-compose.yml"
  if cd "$INSTDIR"; then
    sudo docker-compose pull &>/dev/null
    sudo docker-compose up -d &>/dev/null
  fi
else
  if docker ps -a | grep -qs "$APPNAME"; then
    sudo docker rm "$APPNAME" -f &>/dev/null
    sudo docker pull "$DOCKER_HUB_URL" &>/dev/null
    sudo docker restart "$APPNAME" &>/dev/null
  else
    sudo docker run -d \
      --name="$APPNAME" \
      --hostname "$APPNAME" \
      --restart=unless-stopped \
      --privileged \
      -e TZ=${TIMEZONE:-America/New_York} \
      -v "$DATADIR/data":/data:z \
      -p 85:8080 \
      "$DOCKER_HUB_URL" &>/dev/null
  fi
fi
# - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - -
if docker ps -a | grep -qs "$APPNAME"; then
  printf_green "Successfully setup ifconfig"
else
  printf_return "Could not setup ifconfig"
fi
# - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - -
# End script
exit $?
