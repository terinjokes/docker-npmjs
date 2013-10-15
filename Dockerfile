# Version: 0.3.0 15-Oct-2013
# DOCKER-VERSION 0.4.x
FROM ubuntu:12.10
MAINTAINER Terin Stock <terinjokes@gmail.com>

# Setup image
ADD scripts/setup.sh /root/setup-npm.sh
RUN /root/setup-npm.sh

# Runtime configuration
ADD scripts/startup.sh /root/startup-npm.sh
CMD /root/startup-npm.sh

# Expose couchdb
EXPOSE :5984
EXPOSE :1337
