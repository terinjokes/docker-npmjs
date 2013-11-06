#!/bin/bash
echo -e "[vhosts]\n$HOSTNAME:5984 = /registry/_design/app/_rewrite" >> /usr/local/etc/couchdb/local.d/npmjs-vhost.ini
echo -e "127.0.0.1\t$HOSTNAME" >> /etc/hosts
couchdb -b; npm-delegate -p 1337 "http://$HOSTNAME:5984/" http://registry.npmjs.org/ & tail -f /usr/local/var/log/couchdb/couch.log
