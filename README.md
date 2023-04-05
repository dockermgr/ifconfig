## 👋 Welcome to ifconfig 🚀  

Description  
  
  
## Requires scripts to be installed  

```shell
 sudo bash -c "$(curl -q -LSsf "https://github.com/systemmgr/installer/raw/main/install.sh")"
 systemmgr --config && systemmgr install scripts  
```

## Automatic install/update  

```shell
dockermgr update ifconfig
```

OR

```shell
mkdir -p "$HOME/.local/share/srv/docker/ifconfig/rootfs"
git clone "https://github.com/dockermgr/ifconfig" "$HOME/.local/share/CasjaysDev/dockermgr/ifconfig"
cp -Rfva "$HOME/.local/share/CasjaysDev/dockermgr/ifconfig/rootfs/." "$HOME/.local/share/srv/docker/ifconfig/rootfs/"
```

## via command line  

```shell
docker pull casjaysdevdocker/ifconfig:latest && \
docker run -d \
--restart always \
--privileged \
--name casjaysdevdocker-ifconfig \
--hostname casjaysdev-ifconfig \
-e TZ=${TIMEZONE:-America/New_York} \
-v $HOME/.local/share/srv/docker/ifconfig/rootfs/data:/data:z \
-v $HOME/.local/share/srv/docker/ifconfig/rootfs/config:/config:z \
-p 80:80 \
casjaysdevdocker/ifconfig:latest
```

## via docker-compose  

```yaml
version: "2"
services:
  ifconfig:
    image: casjaysdevdocker/ifconfig
    container_name: ifconfig
    environment:
      - TZ=America/New_York
      - HOSTNAME=casjaysdev-ifconfig
    volumes:
      - $HOME/.local/share/srv/docker/ifconfig/rootfs/data:/data:z
      - $HOME/.local/share/srv/docker/ifconfig/rootfs/config:/config:z
    ports:
      - 80:80
    restart: always
```

## Author  

📽 dockermgr: [Github](https://github.com/dockermgr) 📽  
🤖 casjay: [Github](https://github.com/casjay) [Docker](https://hub.docker.com/r/casjay) 🤖  
⛵ CasjaysDevDocker: [Github](https://github.com/casjaysdevdocker) [Docker](https://hub.docker.com/r/casjaysdevdocker) ⛵  
