# Summary
A quick way to convert your h264 RTMP stream to an HLS stream, and view it in your browser. The Docker image builds nginx with [nginx-rtmp-module](https://github.com/arut/nginx-rtmp-module) (using a [less stale fork](https://github.com/sergey-dryabzhinsky/nginx-rtmp-module)), and serves the HLS stream on a webpage using [videojs](https://github.com/videojs).

# Quickstart
Create a docker container
```
docker run --rm \
 -p 1935:1935 \
 -p 80:8080 \
 -e "TITLE=My Stream" \
 -e "STREAM_NAME=myStream" \
 -e "SERVER_IP=127.0.0.1" \
 cb51/nginx-streamer
```

Create a h264 stream, [using OBS or XSplit], with the URL `rtmp://127.0.0.1/stream` and stream name `myStream` so the name matches the `STREAM_NAME` variable in the `docker run` command above. 

Open http://127.0.0.1 in a browser to view the stream rendered using videojs.
The HLS stream URL is http://127.0.0.1/hls/myStream.m3u8

# Build Locally
To build the Docker image locally,
```
git clone https://github.com/cb50/nginx-streamer
cd nginx-streamer
docker build -t nginx-streamer .
docker run --rm -p 1935:1935 -p 80:8080 nginx-streamer
```