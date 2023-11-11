FROM debian:12-slim

ARG CHROMIUM_VERSION=""

RUN \
    apt-get update -qq &&\
    DEBIAN_FRONTEND=noninteractive apt-get install -y -qq --no-install-recommends lsb-release &&\
    # Cleanup.
    rm -rf /var/lib/apt/lists/* /tmp/* /var/tmp/*

RUN \
    apt-get update -qq &&\
    /bin/bash -c \
    'set -e &&\
    if [[ "$CHROMIUM_VERSION" == "" ]]; then \
     DEBIAN_FRONTEND=noninteractive apt-get install -y -qq --no-install-recommends chromium; \
    else \
     DEBIAN_FRONTEND=noninteractive apt-get install -y -qq --no-install-recommends chromium=$CHROMIUM_VERSION; \
    fi' &&\
    # Cleanup.
    rm -rf /var/lib/apt/lists/* /tmp/* /var/tmp/*

COPY report.sh usr/bin/report

# Print a report in the build stage directly (use --progress=plain).
RUN usr/bin/report