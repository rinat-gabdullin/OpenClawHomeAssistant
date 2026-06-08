FROM ghcr.io/dmunozv04/isponsorblocktv:latest

RUN apk add --no-cache bash jq tzdata

COPY run.sh /run.sh
RUN chmod +x /run.sh

ARG BUILD_ARCH
ARG BUILD_VERSION

LABEL \
    io.hass.arch="${BUILD_ARCH}" \
    io.hass.type="addon" \
    io.hass.version="${BUILD_VERSION}"

ENTRYPOINT ["/run.sh"]
