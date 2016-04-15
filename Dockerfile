FROM gliderlabs/alpine:3.3
MAINTAINER Moreno Sint Hill (Mirabis) <info@mirabis.nl>

ENV FFMPEG_VERSION=3.0.1

WORKDIR /tmp/ffmpeg

RUN apk --no-cache add build-base curl nasm tar bzip2 \
  zlib-dev openssl-dev yasm-dev lame-dev libogg-dev x264-dev libvpx-dev libvorbis-dev x265-dev freetype-dev libass-dev libwebp-dev rtmpdump-dev faac-dev libtheora-dev opus-dev python-dev py-pip git && \
  
  apk add fdk-aac-dev --update-cache --repository http://dl-3.alpinelinux.org/alpine/edge/testing/ --allow-untrusted && \
  
  DIR=$(mktemp -d) && cd ${DIR} && \
  
  curl -s http://ffmpeg.org/releases/ffmpeg-${FFMPEG_VERSION}.tar.gz | tar zxvf - -C . && \
  cd ffmpeg-${FFMPEG_VERSION} && \
  ./configure \
  --enable-version3 --enable-gpl --enable-nonfree --enable-small --enable-libmp3lame --enable-libx264 --enable-small --enable-libfaac --enable-libx265 --enable-libvpx --enable-libtheora --enable-libvorbis --enable-libopus --enable-libass --enable-libwebp --enable-librtmp --enable-postproc --enable-avresample --enable-libfreetype --enable-openssl --disable-debug && \
  make && \
  make install && \
  make distclean && \
  
  rm -rf ${DIR} && \ 
  apk del build-base curl tar bzip2 git x264 openssl nasm  && rm -rf /var/cache/apk/* && \
  
  mkdir /config && \
  cd /config && \
  git clone https://github.com/mdhiggins/sickbeard_mp4_automator.git . && \
  sed -i -r 's/ffmpeg=.*/setting1=\/utils\/ffmpeg/' autoProcess.ini.sample && \
  sed -i -r 's/ffprobe=.*/setting1=\/utils\/ffprobe/' autoProcess.ini.sample && \
  cp -s --no-clobber autoProcess.ini.sample autoProcess.ini && \

VOLUME ["/config"]

ENTRYPOINT ["ffmpeg"]


