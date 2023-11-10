#!/bin/bash

RELEASE=$(lsb_release -a)
KERNEL=$(uname -a)
ARCH=$(dpkg --print-architecture)
CHROMIUM_VERSION=$(chromium --version 2>&1)

read -r -d '' OUTPUT << EOM
$RELEASE

Kernel: $KERNEL
Architecture: $ARCH

chromium --version:
$CHROMIUM_VERSION
EOM

echo "$OUTPUT"