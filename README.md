# Summary

A quick way to convert your h264 RTMP stream to an HLS stream, and view it in your browser. The Docker image builds nginx with [nginx-rtmp-module](https://github.com/arut/nginx-rtmp-module) (using a [less stale fork](https://github.com/sergey-dryabzhinsky/nginx-rtmp-module)), and serves the HLS stream on a webpage using [videojs](https://github.com/videojs).

# Quickstart

### Create a docker stack
! requires Docker compose
* [download](https://github.com/cb50/nginx-streamer/raw/master/docker-compose.yml) or clone, and modify the docker-compose.yml file to suit your configuration

! Make sure to replace SERVER_IP with your external IP to allow external access

* ``docker swarm init``
* ``docker stack deploy -c docker-compose.yml ns`` where "ns" is the name of the app
* ``docker service ls`` to see the new swarm
* ``docker container ls`` lists the containers in the swarm
* ``docker exec -it ns_nginx-streamer.1.sdfk /bin/ash`` launches a terminal in a container named ns_nginx-streamer.1.sdfk as shown using ``docker container ls`` 
* ``docker stack rm ns`` stops the swarm where "ns" is the name of the app
* ``docker swarm leave --force`` leaves the swarm
* ``docker system prune -a`` remove all stopped containers and unused images

### Or, Create a docker container

#### Bash
```
docker run --rm -d -p 1935:1935  -p 80:8080  --name=ns --tmpfs /tmp/hls \
-e "TITLE=My Stream" \
-e "STREAM_NAME=myStream" \
-e "SERVER_IP=127.0.0.1" \
-e "WORKER_PROCESSES=1" \
-e "NGINX_HTTP_CONF=access_log /tmp/hls/access.log;" \
-e "IFRAME=https://google.com" \
-e "GANALYTICS=UA-00000000-0" \
-e "BLACKLIST_MESSAGE=<strong>Blacklist Message\!</strong>" \
-e "BLACKLIST_IPS=192.168.120.5 1;192.168.120.6 1;" \
-e "HEADER=<h1>myStream</h1>" \
-e "FOOTER=footer message" \
cb51/nginx-streamer
```

### Or, Build Locally

To build the Docker image locally,
```
git clone https://github.com/cb50/nginx-streamer
cd nginx-streamer
docker build -t nginx-streamer .
docker run --rm -p 1935:1935 -p 80:8080 --name=ns --tmpfs /tmp/hls \
-e "TITLE=My Stream" \
-e "STREAM_NAME=myStream" \
-e "SERVER_IP=127.0.0.1" \
-e "WORKER_PROCESSES=1" \
-e "NGINX_HTTP_CONF=access_log /tmp/hls/access.log;" \
-e "IFRAME=https://google.com" \
-e "GANALYTICS=UA-00000000-0" \
-e "BLACKLIST_MESSAGE=<strong>Blacklist Message\!</strong>" \
-e "BLACKLIST_IPS=192.168.120.5 1;192.168.120.6 1;" \
-e "HEADER=<h1>myStream</h1>" \
-e "FOOTER=footer message" \
nginx-streamer
```

### Create and view a stream

Create an h264 stream, [using OBS or XSplit], with the URL `rtmp://127.0.0.1/stream` and stream name `myStream` so the name matches the `STREAM_NAME` variable in the `docker run` command above. 

Open http://127.0.0.1 in a browser to view the stream rendered using videojs.
The HLS stream URL is http://127.0.0.1/hls/myStream.m3u8
View connected streams at http://127.0.0.1/stats
View active connections at http://127.0.0.1/viewers. The webpage and stream each have a connection, so you can divide the active connections by 2 for good esimate of viewership.
