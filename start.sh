#!/bin/sh

SERVER_IP=${SERVER_IP}
STREAM_NAME=${STREAM_NAME}
TITLE=${TITLE-""}

cat << EOM

Quick Commands:
docker ps
docker container stop [container id]
docker restart [container id]

URLs :
EOM

echo "rtmp://${SERVER_IP}/${STREAM_NAME}"
echo "http://${SERVER_IP}/hls/${STREAM_NAME}.m3u8"
echo "http://${SERVER_IP}/"

sed -i "s|\$STREAM_NAME|${STREAM_NAME}|g" /usr/share/nginx/html/index.html
sed -i "s|\$SERVER_IP|${SERVER_IP}|g" /usr/share/nginx/html/index.html
sed -i "s|\$TITLE|${TITLE}|g" /usr/share/nginx/html/index.html

/opt/nginx/sbin/nginx -g "daemon off;"

