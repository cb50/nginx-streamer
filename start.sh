#!/bin/sh

SERVER_IP=${SERVER_IP-127.0.0.1}
STREAM_NAME=${STREAM_NAME-stream}
TITLE=${TITLE-""}
WORKER_PROCESSES=${WORKER_PROCESSES-1}

cat << EOM

Docker Quick Commands:
list running containers...   docker ps
container resource usage...  docker container stats [container id]
open cli in container...     docker exec -it [container id] /bin/ash
stop a container ...         docker container stop [container id]

Stream Source :
EOM
echo "Publish an h264 RTMP stream with URL rtmp://${SERVER_IP}/stream and use: ${STREAM_NAME} for the stream name."

cat << EOM

URLs :
EOM
echo "rtmp://${SERVER_IP}/${STREAM_NAME}"
echo "http://${SERVER_IP}/hls/${STREAM_NAME}.m3u8"
echo "http://${SERVER_IP}/"

sed -i "s|\$STREAM_NAME|${STREAM_NAME}|g" /usr/share/nginx/html/index.html
sed -i "s|\$SERVER_IP|${SERVER_IP}|g" /usr/share/nginx/html/index.html
sed -i "s|\$TITLE|${TITLE}|g" /usr/share/nginx/html/index.html
sed -i "s|\$WORKER_PROCESSES|${WORKER_PROCESSES}|g" /opt/nginx/conf/nginx.conf

/opt/nginx/sbin/nginx -g "daemon off;"