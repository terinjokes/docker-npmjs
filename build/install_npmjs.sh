#!/bin/bash
set -e
source /build/docker-npmjs/buildconfig
set -x

$minimal_apt_get_install dnsutils

# This is going to need to be refactored to avoid clobbering terinjokes/docker-couchdb
cat<<EOF > /opt/couchdb/etc/couchdb/local.ini
[couch_httpd_auth]
public_fields = appdotnet, avatar, avatarMedium, avatarLarge, date, email, fields, freenode, fullname, github, homepage, name, roles, twitter, type, _id, _rev
users_db_public = true

[httpd]
secure_rewrites = false

[couchdb]
delayed_commits = false
EOF

cp /build/docker-npmjs/51_configure_npmjs.sh /etc/my_init.d/
