ARG BUILD_FROM
FROM nocodb/nocodb:latest

# Install jq for options parsing in run.sh
RUN apt-get update && apt-get install -y --no-install-recommends \
    jq \
 && apt-get clean \
 && rm -rf /var/lib/apt/lists/*

# Copy run script
COPY run.sh /run.sh
RUN chmod +x /run.sh

ARG BUILD_ARCH
ARG BUILD_VERSION

LABEL \
    io.hass.arch="${BUILD_ARCH}" \
    io.hass.type="addon" \
    io.hass.version="${BUILD_VERSION}"

ENTRYPOINT ["/run.sh"]

