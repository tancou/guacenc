FROM alpine:edge as guac

ENV LD_LIBRARY_PATH=/usr/lib

RUN echo "https://dl-cdn.alpinelinux.org/alpine/edge/testing" >> /etc/apk/repositories && \
    apk update && \
    apk add guacamole-server

FROM alpine:edge
ARG USERNAME=user
ARG USER_UID=1000
ARG USER_GID=$USER_UID

ENV AUTOCONVERT_WAIT=60
ENV AUTOCONVERT=false

# Create the user
RUN addgroup -g $USER_GID sail \
    && adduser -G sail -u $USER_UID sail -D

COPY --from=guac /usr/bin/guacenc /usr/bin/guacenc
COPY --from=guac /usr/lib/lib* /usr/lib/
COPY ./convert.sh /usr/bin/convert

RUN echo "https://dl-cdn.alpinelinux.org/alpine/edge/testing" >> /etc/apk/repositories && \
    apk update && \
    apk add cairo-dev ossp-uuid-dev ffmpeg-dev libwebp-dev && \
    chmod +x /usr/bin/convert

USER $USERNAME

CMD ["/bin/ash", "/usr/bin/convert"]
