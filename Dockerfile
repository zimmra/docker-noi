# syntax=docker/dockerfile:1

FROM ghcr.io/linuxserver/baseimage-kasmvnc:ubuntujammy

# set version label
ARG BUILD_DATE
ARG VERSION
ARG NOI_VERSION
LABEL build_version="Linuxserver.io version:- ${VERSION} Build-date:- ${BUILD_DATE}"
LABEL maintainer="zimmra"

# title
ENV TITLE=Noi

RUN \
  echo "**** add icon ****" && \
  curl -o \
    /kclient/public/icon.png \
    https://raw.githubusercontent.com/lencx/Noi/main/website/static/readme/noi.png && \
#   echo "**** install packages ****" && \
#   apt-get update && \
#   apt-get install -y \
#     python3-xdg \
#     libatk1.0 \
#     libatk-bridge2.0 \
#     libnss3 \
#     libportaudio2 && \
  echo "**** install noi ****" && \
  if [ -z ${NOI_VERSION+x} ]; then \
    NOI_VERSION=$(curl -sX GET "https://api.github.com/repos/lencx/Noi/releases/latest" \
    | awk '/tag_name/{print $4;exit}' FS='[""]' | sed 's|^v||'); \
  fi && \
  cd /tmp && \
  curl -o \
    /tmp/noi.app -L \
    "https://github.com/lencx/Noi/releases/download/v${NOI_VERSION}/Noi_linux_${Noi_VERSION}.AppImage" && \
  chmod +x /tmp/noi.app && \
  ./noi.app --appimage-extract && \
  mv squashfs-root /opt/noi && \
#   ln -s \
#     /usr/lib/x86_64-linux-gnu/libportaudio.so.2 \
#     /usr/lib/x86_64-linux-gnu/libportaudio.so && \
  echo "**** cleanup ****" && \
  rm -rf \
    /tmp/* \
    /var/lib/apt/lists/* \
    /var/tmp/*

# add local files
COPY /root /

# ports and volumes
EXPOSE 3000

VOLUME /config