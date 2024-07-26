ARG NGINX_VERSION=1.26.1
ARG NGINX_RTMP_VERSION=1.2.2-r1

FROM alpine:3.20 AS base

RUN apk add --no-cache pcre openssl

FROM base AS build
ARG NGINX_VERSION
ARG NGINX_RTMP_VERSION

RUN apk add --no-cache build-base pcre-dev openssl-dev zlib-dev

WORKDIR /tmp
RUN \
    wget https://nginx.org/download/nginx-${NGINX_VERSION}.tar.gz && \
    tar xzf nginx-${NGINX_VERSION}.tar.gz && \
    wget https://github.com/sergey-dryabzhinsky/nginx-rtmp-module/archive/v${NGINX_RTMP_VERSION}.tar.gz && \
    tar xzf v${NGINX_RTMP_VERSION}.tar.gz && \
    cd nginx-${NGINX_VERSION} && \
    ./configure --add-module=../nginx-http-flv-module-${NGINX_RTMP_VERSION} && \
    make && \
    make install && \
    cd .. && \
    rm -rf nginx-* v${NGINX_RTMP_VERSION}.tar.gz

FROM base AS release
COPY --from=build /usr/local/nginx /usr/local/nginx
COPY nginx.conf /usr/local/nginx/conf/nginx.conf
RUN rm -rf /var/cache/apk/* /tmp/*

EXPOSE 1935
EXPOSE 8080

CMD ["/usr/local/nginx/sbin/nginx"]