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

# Install pnpm (required by nocodb-sdk's only-allow pnpm preinstall check)
RUN npm install -g pnpm

# Set pnpm global home
ENV PNPM_HOME=/root/.local/share/pnpm
ENV PATH="/root/.local/share/pnpm:${PATH}"

# Allow native build scripts (required for sqlite3, sharp, lz4, etc.)
RUN pnpm config set allow-build='*' --global

# Install NocoDB globally with native modules
RUN pnpm add -g nocodb

# NocoDB registers no bin entry - create a launcher wrapper using the package's own "main" entrypoint
RUN NOCODB_DIR="$(pnpm root -g)/nocodb" \
 && NOCODB_MAIN="$(node -e "console.log(require('${NOCODB_DIR}/package.json').main || 'src/index.js')")" \
 && echo "NocoDB entry point: ${NOCODB_DIR}/${NOCODB_MAIN}" \
 && ls "${NOCODB_DIR}/${NOCODB_MAIN}" \
 && printf '#!/usr/bin/env node\nrequire("%s/%s");\n' "${NOCODB_DIR}" "${NOCODB_MAIN}" > /usr/local/bin/nocodb \
 && chmod +x /usr/local/bin/nocodb

# Copy run script
COPY run.sh /run.sh
RUN chmod +x /run.sh

CMD ["/run.sh"]
