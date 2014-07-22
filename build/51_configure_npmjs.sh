#!/bin/bash
set -e
if [[ ! -e /opt/couchdb/var/lib/couchdb/registry.couch ]]; then
	echo "npmjs registry not found. Running first boot configuration"

	setuser couchdb /opt/couchdb/bin/couchdb -o /tmp/couchdb.stdout -e /tmp/couchdb.stderr -b;

	git clone https://github.com/npm/npm-registry-couchapp.git /tmp/npm-registry-couchapp
	cd /tmp/npm-registry-couchapp
	git checkout tags/v2.4.3

	/opt/node/bin/npm install

	curl -X PUT http://localhost:5984/registry

	/opt/node/bin/npm start --npm-registry-couchapp:couch=http://localhost:5984/registry
	/opt/node/bin/npm run load --npm-registry-couchapp:couch=http://localhost:5984/registry

	# copy.sh doesn't work if couchdb doesn't have authentication
	# https://github.com/npm/npmjs.org/issues/152
	# echo 'yes'|/opt/node/bin/npm run copy --npm-registry-couchapp:couch=http://localhost:5984/registry
	rev=$(curl -k http://localhost:5984/registry/_design/scratch | /opt/node/bin/node ./node_modules/.bin/json _rev)
	curl "http://localhost:5984/registry/_design/scratch" -k -X COPY -H destination:'_design/app'

	setuser couchdb /opt/couchdb/bin/couchdb -d;

	cd /
	rm -rf /tmp/npm-registry-couchapp
fi
