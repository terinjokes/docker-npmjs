#!/bin/bash

echo -e "[vhosts]\n$HOSTNAME:5984 = /registry/_design/scratch/_rewrite" >> /etc/couchdb/local.d/10-npmjs-vhost.ini
echo -e "127.0.0.1\t$HOSTNAME" >> /etc/hosts
couchdb & npm-delegate -p 1337 "http://$HOSTNAME:5984/" http://registry.npmjs.org/
