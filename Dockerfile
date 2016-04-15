FROM gliderlabs/alpine:3.3
MAINTAINER Moreno Sint Hill (Mirabis) <info@mirabis.nl>

ENV FFMPEG_VERSION=3.0.1

WORKDIR /tmp/ffmpeg

RUN echo "@testing http://dl-3.alpinelinux.org/alpine/edge/testing/" >> /etc/apk/repositories \
  && apk-install \
		musl \
		build-base \
		bash \
		curl \
		git \
		nasm \
		tar \
		bzip2 \
		zlib-dev \
		openssl-dev \
		yasm-dev \
		lame-dev \
		libogg-dev \
		x264-dev \
		libvpx-dev \
		libvorbis-dev \
		x265-dev \
		freetype-dev \
		libass-dev \
		libwebp-dev \
		rtmpdump-dev \
		faac faac-dev \
		fdk-aac@testing fdk-aac-dev@testing \
		libtheora-dev \
		opus-dev \
		python \
  && curl -fSL 'https://bootstrap.pypa.io/get-pip.py' | python2 \
  && hash -r \
  && pip install --no-cache-dir --upgrade pip setuptools requests requests[security] requests-cache babelfish guessit<2 subliminal qt-faststart \
  
  && DIR=$(mktemp -d) \
  && cd ${DIR} \
  
  && curl -s http://ffmpeg.org/releases/ffmpeg-${FFMPEG_VERSION}.tar.gz | tar zxvf - -C . \
  && cd ffmpeg-${FFMPEG_VERSION} \
  && ./configure \
		--enable-version3 \
		--enable-gpl \
		--enable-nonfree \
		--enable-small \
		--enable-libmp3lame \
		--enable-libx264 \
		--enable-libfaac \
		--enable-libfdk-aac \
		--enable-libx265 \
		--enable-libvpx \
		--enable-libtheora \
		--enable-libvorbis \
		--enable-libopus \
		--enable-libass \
		--enable-libwebp \
		--enable-librtmp \
		--enable-postproc \
		--enable-avresample \
		--enable-libfreetype \
		--enable-openssl \
		--disable-debug \
  && make \
  && make install \
  && make distclean \
  
  && rm -rf ${DIR} \ 
  && apk del build-base curl tar bzip2 x264 openssl nasm \
  && rm -rf /var/cache/apk/*   

WORKDIR /config

RUN git clone https://github.com/mdhiggins/sickbeard_mp4_automator.git . \
  && sed -i -r 's;^ffmpeg=.*;ffmpeg=/tmp/ffmpeg/ffmpeg;' autoProcess.ini.sample \
  && sed -i -r 's;^ffprobe=.*;ffprobe=/tmp/ffmpeg/ffprobe;' autoProcess.ini.sample \
  && cp --no-clobber autoProcess.ini.sample autoProcess.ini 2>>/dev/null \

VOLUME ["/config"]

ENTRYPOINT ["/tmp/ffmpeg/ffmpeg"]


