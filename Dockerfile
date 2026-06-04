ARG BUILD_FROM=ghcr.io/muthur-command/base:3.23-2026.06.2
FROM ${BUILD_FROM}

SHELL ["/bin/ash", "-o", "pipefail", "-c"]

ARG MDNS_REPEATER_VERSION="1.2.0"

RUN     apk add --no-cache --virtual .build-deps         build-base         git         && git clone -b ${MDNS_REPEATER_VERSION} --depth 1         https://github.com/pvizeli/mdns-repeater /usr/src/mdns     && cd /usr/src/mdns     && gcc -O3 -o /usr/bin/mdns-repeater         mdns-repeater.c -DVERSION="\"${MDNS_REPEATER_VERSION}\""         && apk del .build-deps     && rm -rf         /usr/src/mdns

COPY rootfs /

LABEL     io.mcos.type="multicast"     org.opencontainers.image.title="Muthur Command OS multicast plugin"     org.opencontainers.image.description="Supervisor-managed multicast plugin container for Muthur Command OS"     org.opencontainers.image.authors="muthur-command (fork; upstream copyright in LICENSE)"     org.opencontainers.image.url="https://github.com/muthur-command/plugin-multicast"     org.opencontainers.image.documentation="https://github.com/muthur-command/plugin-multicast"     org.opencontainers.image.licenses="Apache License 2.0"
