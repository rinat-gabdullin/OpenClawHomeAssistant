ARG BUILD_FROM
FROM ${BUILD_FROM}

# Install base dependencies
RUN apt-get update && apt-get install -y --no-install-recommends \
    bash \
    ca-certificates \
    curl \
    jq \
    tzdata \
    gnupg \
    git \
    python3 \
    build-essential \
    sqlite3 \
 && apt-get clean \
 && rm -rf /var/lib/apt/lists/*

# Install Node.js 22 LTS from NodeSource
RUN curl -fsSL https://deb.nodesource.com/setup_22.x | bash - \
 && apt-get install -y nodejs \
 && apt-get clean \
 && rm -rf /var/lib/apt/lists/*

# Install NocoDB globally
RUN npm install -g nocodb \
 && nocodb --version || true

# Copy run script
COPY run.sh /run.sh
RUN chmod +x /run.sh

CMD ["/run.sh"]
