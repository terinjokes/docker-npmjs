#!/bin/bash
set -e
source /build/docker-npmjs/buildconfig
set -x

mkdir -p /opt/node
curl -L# http://nodejs.org/dist/v0.10.29/node-v0.10.29-linux-x64.tar.gz|tar -zx --strip 1 -C /opt/node
