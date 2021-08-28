# Welcome to dockermgr ipconfig installer 👋

## To install

```shell
dockermgr install ipconfig
```  

## Manual install

Service is available at: <http://localhost:15406>

```shell
git clone https://github.com/dockermgr/ifconfig "$HOME/.local/share/CasjaysDev/dockermgr/ifconfig"

mkdir -p "$HOME/.local/share/srv/docker/ifconfig/"
cp -Rf "$HOME/.local/share/srv/docker/ifconfig/system/*" "$HOME/.local/share/srv/docker/ifconfig/"

sudo docker run -d \
--name="ifconfig" \
--hostname "checkip" \
--restart=unless-stopped \
--privileged \
-e TZ="${TZ:-${TIMEZONE:-America/New_York}}" \
-v "$HOME/.local/share/srv/docker/ifconfig/data":/data:z \
-v "$HOME/.local/share/srv/docker/ifconfig/config":/config:z \
-p 15406:8080 \
mpolden/echoip -H X-Forwarded-For -a /data/GeoLite2-ASN.mmdb -c /data/GeoLite2-City.mmdb -f /data/GeoLite2-Country.mmdb 1>/dev/null
```

## Author  

👤 **Jason Hempstead**  
