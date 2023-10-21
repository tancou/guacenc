FROM alpine:edge

ENV LD_LIBRARY_PATH=/usr/local/lib
ENV AUTOCONVERT_WAIT=60
ENV AUTOCONVERT=false

COPY ./bin/guacenc /usr/local/bin/guacenc
COPY ./convert.sh /usr/local/bin/convert
COPY ./lib/lib* /usr/local/lib/

RUN echo "https://dl-cdn.alpinelinux.org/alpine/edge/testing" >> /etc/apk/repositories && \
    apk update && \
    apk add cairo-dev ossp-uuid-dev ffmpeg-dev libwebp-dev

CMD ["/bin/ash", "/usr/local/bin/convert"]
