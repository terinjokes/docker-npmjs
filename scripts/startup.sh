#!/bin/bash
FULLHOST=$(hostname -f)
echo -e "[vhosts]\n$FULLHOST:5984 = /registry/_design/app/_rewrite" >> /usr/local/etc/couchdb/local.d/npmjs-vhost.ini
echo -e "127.0.0.1\t$FULLHOST" >> /etc/hosts
cat /opt/npmjs/kappa.json.default|sed -e "s/\${hostname}/$FULLHOST/" > /opt/npmjs/kappa.json
couchdb -b; kappa -c /opt/npmjs/kappa.json & tail -f /usr/local/var/log/couchdb/couch.log
