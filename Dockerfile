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
  && apk del build-base curl tar bzip2 x264 openssl nasm \

WORKDIR /config

RUN git clone https://github.com/mdhiggins/sickbeard_mp4_automator.git . 

VOLUME ["/config"]



