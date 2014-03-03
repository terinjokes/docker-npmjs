#!/bin/bash
set -e
if [[ ! -e /opt/couchdb/var/lib/couchdb/registry.couch ]]; then
	echo "npmjs registry not found. Running first boot configuration"

	setuser couchdb /opt/couchdb/bin/couchdb -o /tmp/couchdb.stdout -e /tmp/couchdb.stderr -b;

	cd /tmp
	git clone git://github.com/npm/npmjs.org
	cd npmjs.org
	git checkout tags/v2.0.4

	npm install

	curl -X PUT http://localhost:5984/registry

	npm start --npmjs.org:couch=http://localhost:5984/registry
	DEPLOY_VERSION=`git describe --tags` npm run load --npmjs.org:couch=http://localhost:5984/registry

	# copy.sh doesn't work if couchdb doesn't have authentication
	# https://github.com/npm/npmjs.org/issues/152
	# echo 'yes'|npm run copy --npmjs.org:couch=http://localhost:5984/registry
	rev=$(curl -k http://localhost:5984/registry/_design/scratch | ./node_modules/.bin/json _rev)
	curl "http://localhost:5984/registry/_design/scratch" -k -X COPY -H destination:'_design/app'

	setuser couchdb /opt/couchdb/bin/couchdb -d;

	cd $HOME
	rm -rf /tmp/npmjs.org
fi
