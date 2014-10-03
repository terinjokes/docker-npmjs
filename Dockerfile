# Version: 0.5.2 28-Feb-201
FROM fedora/couchdb
MAINTAINER Terin Stock <terinjokes@gmail.com>

ENV PATH /opt/node/bin/:$PATH

# Install curl
RUN yum install -y curl git

# Setup nodejs
RUN curl -sL https://rpm.nodesource.com/setup | bash -
RUN yum install -y nodejs

# Download npmjs project
RUN git clone https://github.com/isaacs/npmjs.org /opt/npmjs
RUN cd /opt/npmjs; git checkout ea8e7a533ea595db79b24f12c76b62c3889b43e8
RUN npm install couchapp@0.10.x -g
RUN cd /opt/npmjs; npm link couchapp; npm install semver

# Allow insecure rewrites
RUN echo -e "[httpd]\nsecure_rewrites = false" >> /etc/couchdb/local.d/secure_rewrites.ini

# Configuring npmjs.org
RUN cd /opt/npmjs; couchdb -b; sleep 5; curl -X PUT http://localhost:5984/registry; sleep 5; couchdb -d;
RUN cd /opt/npmjs; couchdb -b; sleep 5; couchapp push registry/shadow.js http://localhost:5984/registry; sleep 5; couchapp push registry/app.js http://localhost:5984/registry; sleep 5; couchdb -d
RUN cd /opt/npmjs; npm set _npmjs.org:couch=http://localhost:5984/registry
RUN cd /opt/npmjs; couchdb -b; sleep 5; npm run load; sleep 5; curl -k "http://localhost:5984/registry/_design/scratch" -X COPY -H destination:'_design/app'; sleep 5; couchdb -d
## Resolve isaacs/npmjs.org#98
RUN cd /opt/npmjs; /usr/bin/couchdb -b; sleep 5; curl http://isaacs.iriscouch.com/registry/error%3A%20forbidden | curl -X PUT -d @- http://localhost:5984/registry/error%3A%20forbidden?new_edits=false; sleep 5; couchdb -d

# Start
ADD config/package.json /opt/npmjs/package.json
RUN cd /opt/npmjs/ && npm install
ADD config/kappa.json.default /opt/npmjs/kappa.json.default
ADD scripts/startup.sh /root/startup.sh
CMD /root/startup.sh
