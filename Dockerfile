
ARG ALPINE_VERSION=3.8

FROM alpine:${ALPINE_VERSION} as builder


RUN	apk update && \
 apk add \
 binutils \
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

ARG NGINX_VERSION=1.14.0

RUN	cd /tmp/ &&	\
	curl --remote-name http://nginx.org/download/nginx-${NGINX_VERSION}.tar.gz && \
	git clone https://github.com/sergey-dryabzhinsky/nginx-rtmp-module.git

RUN	cd /tmp && \
	tar xzf nginx-${NGINX_VERSION}.tar.gz && \
	cd nginx-${NGINX_VERSION} && \
	./configure \
		--prefix=/opt/nginx \
		--with-http_ssl_module \
		--with-http_stub_status_module \
		--add-module=../nginx-rtmp-module && \
	make &&	\
	make install

ARG ALPINE_VERSION=3.8

FROM alpine:${ALPINE_VERSION}

RUN rm /etc/apk/repositories
ADD repositories /etc/apk/repositories

# TODO Fix variable expansion 
RUN sed -i "s|%%ALPINE_VERSION%%|3.8|g" /etc/apk/repositories 

RUN apk update && \
	apk add \
		ca-certificates \
		libstdc++ \
		openssl \
		goaccess \
		pcre

COPY --from=0 /opt/nginx /opt/nginx
COPY --from=0 /tmp/nginx-rtmp-module/stat.xsl /opt/nginx/conf/stat.xsl
COPY nginx.conf /opt/nginx/conf
COPY html /usr/share/nginx/html
ADD start.sh /

EXPOSE 1935
EXPOSE 8080

CMD /start.sh