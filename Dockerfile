FROM debian:12-slim

ARG CHROMIUM_VERSION="latest"
ARG CHROMIUM_SNAPSHOT="false"

RUN \
    apt-get update -qq &&\
    /bin/bash -c \
    'set -e &&\
    if [[ "$CHROMIUM_VERSION" == "latest" ]]; then \
     DEBIAN_FRONTEND=noninteractive apt-get install -y -qq --no-install-recommends chromium; \
    elif [[ "$CHROMIUM_SNAPSHOT" == "false" ]]; then \
     DEBIAN_FRONTEND=noninteractive apt-get install -y -qq --no-install-recommends chromium-common="$CHROMIUM_VERSION" chromium="$CHROMIUM_VERSION"; \
    else \
      DEBIAN_FRONTEND=noninteractive apt-get install -y -qq --no-install-recommends devscripts &&\
      ARCH=$(dpkg --print-architecture) &&\
      debsnap chromium-common "$CHROMIUM_VERSION" -v --force --binary --architecture "$ARCH" &&\
      debsnap chromium "$CHROMIUM_VERSION" -v --force --binary --architecture "$ARCH" &&\
      DEBIAN_FRONTEND=noninteractive apt-get install --fix-broken -y -qq --no-install-recommends "./binary-chromium-common/chromium-common_${CHROMIUM_VERSION}_${ARCH}.deb" "./binary-chromium/chromium_${CHROMIUM_VERSION}_${ARCH}.deb"; \
    fi'

COPY report.sh usr/bin/report

# Print a report in the build stage directly (use --progress=plain).
RUN usr/bin/report