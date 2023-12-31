#!/bin/bash

CHROMIUM_VERSION=$(chromium --version 2>&1)
BASH_CHROMIUM_VERSION=$(bash -x /usr/bin/chromium --version 2>&1)
KERNEL=$(uname -a)
CPU_INFO=$(cat /proc/cpuinfo)

read -r -d '' OUTPUT << EOM
chromium --version:
$CHROMIUM_VERSION

bash -x /usr/bin/chromium --version:
$BASH_CHROMIUM_VERSION

uname -a:
$KERNEL

cat /proc/cpuinfo:
$CPU_INFO
EOM

echo "$OUTPUT"