FROM debian:12-slim

ARG CHROMIUM_VERSION="latest"
ARG CHROMIUM_SNAPSHOT_LINK="false"

RUN \
    apt-get update -qq &&\
    /bin/bash -c \
    'set -e &&\
    if [[ "$CHROMIUM_VERSION" == "latest" ]]; then \
     DEBIAN_FRONTEND=noninteractive apt-get install -y -qq --no-install-recommends chromium; \
    elif [[ "$CHROMIUM_SNAPSHOT_LINK" == "" ]]; then \
     DEBIAN_FRONTEND=noninteractive apt-get install -y -qq --no-install-recommends chromium-common="$CHROMIUM_VERSION" chromium="$CHROMIUM_VERSION"; \
    else \
      ARCH=$(dpkg --print-architecture) &&\
      curl -o "./chromium.deb" "$CHROMIUM_SNAPSHOT_LINK/chromium_$CHROMIUM_VERSION_$ARCH.deb" &&\
      curl -o "./chromium-common.deb" "$CHROMIUM_SNAPSHOT_LINK/chromium-common_$CHROMIUM_VERSION_$ARCH.deb" &&\
      DEBIAN_FRONTEND=noninteractive apt-get install -y -qq --no-install-recommends ./chromium-common.deb ./chromium.deb; \
    fi' &&\
    # Cleanup.
    rm -rf /var/lib/apt/lists/* /tmp/* /var/tmp/*

COPY report.sh usr/bin/report

# Print a report in the build stage directly (use --progress=plain).
RUN usr/bin/report