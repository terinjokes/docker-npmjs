#!/bin/bash

# Setting up Node.js apt repository
echo "deb http://ppa.launchpad.net/chris-lea/node.js/ubuntu precise main" >> /etc/apt/sources.list
gpg --ignore-time-conflict --no-options --no-default-keyring --secret-keyring /tmp/tmp.U6rnskPajB --trustdb-name /etc/apt/trustdb.gpg --keyring /etc/apt/trusted.gpg --primary-keyring /etc/apt/trusted.gpg --keyserver hkp://keyserver.ubuntu.com:80/ --recv 136221EE520DDFAF0A905689B9316A7BC7917B12

# Apt Installation
#
# Installing git, nodejs, curl and couchdb
apt-get update -y -q
apt-get install -y -q nodejs git curl couchdb

# Couchdb Configuration
#
# Bind to all interfaces, disable secure_rewrites.
#
# I'm deferring vhost configuration to the runtime
sed -i 's/^;bind_address.*/bind_address = 0.0.0.0/' /etc/couchdb/local.ini
echo -e "[httpd]\nsecure_rewrites = false" >> /etc/couchdb/local.ini

# Install npmjs.org project
git clone https://github.com/isaacs/npmjs.org.git /var/npmjs.org
cd /var/npmjs.org
npm install couchapp -g
npm install couchapp semver

# Configure npmjs.org
couchdb &
echo "> Creating registry DB" >&1
curl -X PUT http://localhost:5984/registry
echo "> Pushing Apps" >&1
couchapp push registry/shadow.js http://localhost:5984/registry
couchapp push registry/app.js http://localhost:5984/registry
npm set _npmjs.org:couch=http://localhost:5984/registry
echo "> Loading views" >&1
npm run load
echo "> Copying design documents" >&1
curl -k "http://localhost:5984/registry/_design/scratch" -X COPY -H destination:'_design/app'

# Installing npm-delegate
npm install -g npm-delegate
