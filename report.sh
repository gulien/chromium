#!/bin/bash

CPU_INFO=$(cat /proc/cpuinfo)
KERNEL=$(uname -a)
CHROMIUM_VERSION=$(chromium --version 2>&1)

read -r -d '' OUTPUT << EOM
cat /proc/cpuinfo:
$CPU_INFO

uname -a:
$KERNEL

chromium --version:
$CHROMIUM_VERSION
EOM

echo "$OUTPUT"