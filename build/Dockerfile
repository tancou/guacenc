FROM alpine:edge

ENV LD_LIBRARY_PATH=/usr/local/lib

RUN echo "https://dl-cdn.alpinelinux.org/alpine/edge/testing" >> /etc/apk/repositories && \
    apk update && \
    apk add libtool automake autoconf cairo-dev ossp-uuid-dev file g++ libjpeg-turbo-dev make ffmpeg-dev git libwebp-dev && \
    git clone https://github.com/apache/guacamole-server.git /guacamole-server

WORKDIR /guacamole-server

RUN autoreconf -fi && \
    ./configure --disable-guacd --disable-guaclog && \
    make && \
    make install

ENTRYPOINT ["/bin/ash"]
