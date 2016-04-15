FROM gliderlabs/alpine:3.3
MAINTAINER Moreno Sint Hill (Mirabis) <info@mirabis.nl>

ENV FFMPEG_VERSION=3.0.1 \
    PY_VER=2.7.13 

WORKDIR /tmp/ffmpeg

RUN apk add --update --no-cache build-base curl nasm tar bzip2 git \
  zlib-dev openssl-dev yasm-dev lame-dev libogg-dev x264-dev libvpx-dev libvorbis-dev faac-dev x265-dev freetype-dev libass-dev libwebp-dev rtmpdump-dev \
  libtheora-dev opus-dev python-dev py-pip && \
  pip install requests requests[security] requests-cache babelfish guessit<2 subliminal qt-faststart && \
 
  DIR=$(mktemp -d) && cd ${DIR} && \
  curl -s http://ffmpeg.org/releases/ffmpeg-${FFMPEG_VERSION}.tar.gz | tar zxvf - -C . && \
  cd ffmpeg-${FFMPEG_VERSION} && \
  ./configure \
  --enable-version3 --enable-gpl --enable-nonfree --enable-small --enable-libmp3lame --enable-libx264 \
  --enable-small --enable-libfaac --enable-libx265 --enable-libvpx --enable-libtheora \
  --enable-libvorbis --enable-libopus --enable-libass --enable-libwebp --enable-librtmp --enable-postproc \
  --enable-avresample --enable-libfreetype --enable-openssl --disable-debug && \
  make && \
  make install && \
  make distclean && \
  rm -rf ${DIR} && \    
  apk del build-base curl tar bzip2 git x264 openssl nasm && rm -rf /var/cache/apk/*

VOLUME ["/config"]

ENTRYPOINT ["ffmpeg"]