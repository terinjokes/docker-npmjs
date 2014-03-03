# A Docker-friendly base npmjs [![Stories in Ready](https://badge.waffle.io/terinjokes/docker-npmjs.png?label=ready)](https://waffle.io/terinjokes/docker-npmjs)

> A vanilla installation of the npmjs registry code built upon [docker-couchdb](https://github.com/terinjokes/docker-couchdb) and [baseimage-docker](https://github.com/phusion/baseimage-docker).

This container is available for pulling from [the Docker registry](https://index.docker.io/u/terinjokes/couchdb)!

---

## What's Inside?

In addition to what [docker-couchdb](https://github.com/terinjokes/docker-couchdb#whats-inside) provides:

- An installation of the open source npmjs registry code, ready for use as a private npmjs registry or a public mirror.

## Saving the database outside the container
You can save the databases outside the container by mapping it to a directory on your host:

```
docker run -v /path/on/host/couchdb:/opt/couchdb/var/lib/couchdb/:rw terinjokes/docker-couchdb
```

For more information, see the Docker documentation on [mounting a host directory](http://docs.docker.io/en/latest/use/working_with_volumes/#mount-a-host-directory-as-a-container-volume).

## Related Projects

- Itching to use CouchDB in your next project? Check out [docker-couchdb](https://github.com/terinjokes/docker-couchdb).
- Want a mirror of the public npmjs registry? [skim (without attachments)](https://github.com/terinjokes/docker-npmjs-skim) or [fullfat (with attachments)](https://github.com/terinjokes/docker-npmjs-fullfat).
- Private registry with delegation to a public registry more your taste? [docker-npmjs-delegate](https://github.com/terinjokes/docker-npmjs-delegate).
