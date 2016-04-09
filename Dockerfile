FROM gliderlabs/alpine:3.3
MAINTAINER Moreno Sint Hill (Mirabis) <info@mirabis.nl>

ENV FFMPEG_VERSION=git \
    PY_VER= 2.7.13 

WORKDIR /utils/ffmpeg

RUN DIR=$(mktemp -d) && cd ${DIR} && \
  apk add --update build-base curl nasm tar bzip2 git \
  zlib-dev openssl-dev yasm-dev lame-dev libogg-dev x264-dev libvpx-dev libvorbis-dev fdk-aac faac x265-dev freetype-dev libass-dev libwebp-dev rtmpdump-dev libtheora-dev opus-dev python \
  
  pip install requests requests[security] requests-cache babelfish guessit<2 subliminal stevedore python-dateutil deluge-client qt-faststart && \
  mkdir /config && \
  
  git clone https://github.com/mdhiggins/sickbeard_mp4_automator.git /config && \
  sed -i -r 's/ffmpeg=.*/setting1=\/utils\/ffmpeg/' autoProcess.ini.sample && \
  sed -i -r 's/ffprobe=.*/setting1=\/utils\/ffprobe/' autoProcess.ini.sample && \
  cp --no-clobber autoProcess.ini.sample autoProcess.ini \
  
  git clone git://source.ffmpeg.org/ffmpeg.git ffmpeg-${FFMPEG_VERSION} && \
  cd ffmpeg-${FFMPEG_VERSION} && \
  ./configure --bindir="/utils" \
  --enable-version3 --enable-gpl --enable-nonfree --enable-small --enable-libmp3lame --enable-libx264 \
  --enable-small --enable-libfaac --enable-libfdk_aac  --enable-libx265 --enable-libvpx --enable-libtheora \
  --enable-libvorbis --enable-libopus --enable-libass --enable-libwebp --enable-librtmp --enable-postproc \
  --enable-avresample --enable-libfreetype --enable-openssl --disable-debug && \
  make && \
  make install && \
  make distclean && \

  rm -rf ${DIR} && \
  apk del build-base curl tar bzip2 git x264 openssl nasm && rm -rf /var/cache/apk/*

VOLUME ["/config"]

ENTRYPOINT ["manual.py","-h"]