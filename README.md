Publish a custom h264 stream with URL rtmp://127.0.0.1/stream and "pineapple" for stream name.

docker run --rm -p 1935:1935 -p 80:8080 -e "TITLE=State of The Pineapple" -e "STREAM_NAME=pineapple" -e "SERVER_IP=192.168.1.124" cb51/nginx-streamer

rtmp://127.0.0.1/stream/test
http://127.0.0.1/hls/test.m3u8