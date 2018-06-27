FROM alpine:latest as builder

ARG NGINX_VERSION=1.14.0

RUN	apk update && \
 apk add \
 binutils \
 binutils-libs \
 ca-certificates \
 curl \
 curl \
 expat \
 gcc \
 git \
 gmp \
 isl \
 libatomic \
 libc-dev \
 libgcc \
 libgomp \
 libssh2 \
 libstdc++ \
 mpc1 \
 mpfr3 \
 musl-dev \
 openssl \
 openssl-dev \
 pcre \
 pcre-dev \
 pkgconf \
 pkgconfig \
 zlib-dev \
 make

RUN	cd /tmp/ &&	\
	curl --remote-name http://nginx.org/download/nginx-${NGINX_VERSION}.tar.gz && \
	git clone https://github.com/sergey-dryabzhinsky/nginx-rtmp-module.git

RUN	cd /tmp && \
	tar xzf nginx-${NGINX_VERSION}.tar.gz && \
	cd nginx-${NGINX_VERSION} && \
	./configure \
		--prefix=/opt/nginx \
		--with-http_ssl_module \
		--add-module=../nginx-rtmp-module && \
	make &&	\
	make install

FROM alpine:latest
RUN apk update && \
	apk add \
		ca-certificates \
		libstdc++ \
		openssl \
		pcre

COPY --from=0 /opt/nginx /opt/nginx
COPY --from=0 /tmp/nginx-rtmp-module/stat.xsl /opt/nginx/conf/stat.xsl
RUN rm /opt/nginx/conf/nginx.conf
ADD nginx.conf /opt/nginx/conf/nginx.conf
RUN mkdir -p /usr/share/nginx/html/
ADD index.html /usr/share/nginx/html/index.html
ADD start.sh /

EXPOSE 1935
EXPOSE 8080

CMD /start.sh

