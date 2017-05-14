FROM alpine:latest
MAINTAINER William Weiskopf <william@weiskopf.me>

ENV VERSION 0.17.2

# handbrake and mkvtoolnix are still in Alpines edge/testing
RUN echo "http://dl-cdn.alpinelinux.org/alpine/edge/main" >> /etc/apk/repositories \
 && echo "http://dl-cdn.alpinelinux.org/alpine/edge/testing" >> /etc/apk/repositories \
 && apk -U upgrade
RUN apk add --no-cache --virtual=build-dependencies \
    ca-certificates \
    g++ \
    make \
    musl-dev \
    wget \
 && wget https://storage.googleapis.com/google-code-archive-downloads/v2/code.google.com/mp4v2/mp4v2-2.0.0.tar.bz2 \
 && tar xf mp4v2-2.0.0.tar.bz2 \
 && cd mp4v2-2.0.0 \
 && ./configure \
 && make \
 && make install \
 && apk del build-dependencies
RUN apk add --no-cache \
    ffmpeg \
    handbrake \
    mkvtoolnix \
    ruby \
    ruby-irb \
    ruby-rdoc
RUN gem install video_transcoding -v "$VERSION"

#USER root

ENTRYPOINT []

#CMD ["crond", "-l", "0", "-f"]

