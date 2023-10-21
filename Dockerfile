FROM alpine:edge as guac

ENV LD_LIBRARY_PATH=/usr/lib

RUN echo "https://dl-cdn.alpinelinux.org/alpine/edge/testing" >> /etc/apk/repositories && \
    apk update && \
    apk add guacamole-server

FROM alpine:edge

ENV AUTOCONVERT_WAIT=60
ENV AUTOCONVERT=false

COPY --from=guac /usr/bin/guacenc /usr/bin/guacenc
COPY --from=guac /usr/lib/lib* /usr/lib/
COPY ./convert.sh /usr/bin/convert

RUN echo "https://dl-cdn.alpinelinux.org/alpine/edge/testing" >> /etc/apk/repositories && \
    apk update && \
    apk add cairo-dev ossp-uuid-dev ffmpeg-dev libwebp-dev && \
    chmod +x /usr/bin/convert

USER 1000:1000

CMD ["/bin/ash", "/usr/bin/convert"]
