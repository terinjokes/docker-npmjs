#!/bin/bash
set -e
source /build/docker-npmjs/buildconfig
set -x

mkdir -p /opt/node
curl -L# http://nodejs.org/dist/v0.10.26/node-v0.10.26-linux-x64.tar.gz|tar -zx --strip 1 -C /opt/node
