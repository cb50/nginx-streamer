#!/bin/sh

SERVER_IP=${SERVER_IP-127.0.0.1}
STREAM_NAME=${STREAM_NAME-stream}
TITLE=${TITLE-""}
HEADER=${HEADER-""}
FOOTER=${FOOTER-""}
TS_MESSAGE=${TS_MESSAGE-""}
WORKER_PROCESSES=${WORKER_PROCESSES-1}
NGINX_HTTP_CONF=${NGINX_HTTP_CONF-access_log off;}
GANALYTICS=${GANALYTICS-UA-00000000-0}
TS_IPS=${TS_IPS-""}

cat << EOM

Docker Quick Commands:
list running containers...              docker ps
container resource usage...             docker container stats [container id]
stop a container...                    docker container stop [container id]
open cli in container...                docker exec -it [container id] /bin/ash
access goaccess from container cli...  goaccess /tmp/hls/access.log         

Stream Source :
EOM
echo "Publish an h264 RTMP stream with URL rtmp://${SERVER_IP}/stream and use: ${STREAM_NAME} for the stream name."

cat << EOM

URLs :
EOM
echo "rtmp://${SERVER_IP}/${STREAM_NAME}"
echo "http://${SERVER_IP}/hls/${STREAM_NAME}.m3u8"
echo "http://${SERVER_IP}/"

sed -i "s|%%STREAM_NAME%%|${STREAM_NAME}|g" /usr/share/nginx/html/player.js
sed -i "s|%%SERVER_IP%%|${SERVER_IP}|g" /usr/share/nginx/html/player.js
sed -i "s|%%TITLE%%|${TITLE}|g" /usr/share/nginx/html/index.html
sed -i "s|%%HEADER%%|${HEADER}|g" /usr/share/nginx/html/index.html
sed -i "s|%%FOOTER%%|${FOOTER}|g" /usr/share/nginx/html/index.html
sed -i "s|%%GANALYTICS%%|${GANALYTICS}|g" /usr/share/nginx/html/index.html
sed -i "s|%%TITLE%%|${TITLE}|g" /usr/share/nginx/html/ts.html
sed -i "s|%%HEADER%%|${HEADER}|g" /usr/share/nginx/html/ts.html
sed -i "s|%%FOOTER%%|${FOOTER}|g" /usr/share/nginx/html/ts.html
sed -i "s|%%TS_MESSAGE%%|${TS_MESSAGE}|g" /usr/share/nginx/html/ts.html
sed -i "s|%%GANALYTICS%%|${GANALYTICS}|g" /usr/share/nginx/html/ts.html
sed -i "s|%%WORKER_PROCESSES%%|${WORKER_PROCESSES}|g" /opt/nginx/conf/nginx.conf
sed -i "s|%%NGINX_HTTP_CONF%%|${NGINX_HTTP_CONF}|g" /opt/nginx/conf/nginx.conf
sed -i "s|%%TS_IPS%%|${TS_IPS}|g" /opt/nginx/conf/nginx.conf

/opt/nginx/sbin/nginx -g "daemon off;"