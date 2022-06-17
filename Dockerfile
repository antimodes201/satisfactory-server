FROM ubuntu:18.04
MAINTAINER antimodes201

# quash warnings
ARG DEBIAN_FRONTEND=noninteractive

ARG GAME_PORT=7777
ARG QUERY_PORT=15777
ARG BEACON_PORT=15000

# Set some Variables
ENV BRANCH "public"
ENV GAME_PORT $GAME_PORT
ENV QUERY_PORT $QUERY_PORT
ENV BEACON_PORT $BEACON_PORT
ENV TZ "America/New_York"

# dependencies
RUN dpkg --add-architecture i386 && \
        apt-get update && \
        apt-get install -y --no-install-recommends \
		lib32gcc1 \
		wget \
		unzip \
		tzdata \
		libsdl2-2.0-0:i386 \
		ca-certificates && \
		rm -rf /var/lib/apt/lists/*

# create directories
RUN adduser \
    --disabled-login \
    --disabled-password \
    --shell /bin/bash \
    steamuser && \
    usermod -G tty steamuser \
        && mkdir -p /steamcmd \
        && mkdir -p /satisfactory \
		&& mkdir -p /scripts \
        && chown steamuser:steamuser /satisfactory \
        && chown steamuser:steamuser /steamcmd \
		&& chown steamuser:steamuser /scripts 

USER steamuser

ADD start.sh /scripts/start.sh

# Expose some port
EXPOSE $GAME_PORT/udp
EXPOSE $QUERY_PORT/udp
EXPOSE $BEACON_PORT/udp

# Make a volume
# contains configs and world saves
VOLUME /satisfactory

CMD ["/scripts/start.sh"]