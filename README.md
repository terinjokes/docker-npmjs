[![Stories in Ready](https://badge.waffle.io/terinjokes/docker-npmjs.png?label=ready)](https://waffle.io/terinjokes/docker-npmjs)

# Docker Image for npm
**Version**: 0.5.1  
**Docker Versions**: >=0.6.5 <0.8.0

An easy way to get started with a private npm server, along with [kappa](https://github.com/paypal/kappa).
These instructions assume you've already installed Docker per the [Getting Started](http://www.docker.io/gettingstarted/) guide.

## Building

This image can be built by running the following docker command:

```
docker build -t npmjs github.com/terinjokes/docker-npmjs
```

> You can build from a git tag by appending a ref to the above URL.
> For example `github.com/terinjokes/docker-npmjs#0.5.1`

## Running

After building the image, a container can be spawned.
Providing the vhost (via the `-h`) options, as well as exposing the ports (`-p`) is required to use this image.

```
docker run -d -h npmjs.intranet -p=5984:5984 -p=1337:1337 npmjs
```

## Using
Kappa is exposed on port 1337, and will delegate requests to either your local registry or the public fallback.
You'll want to change your default registry via:

```
npm config set registry http://npmjs.intranet:1337/
```

Kappa is configured to be read-write to the local registry. To use the public registry use the `--registry` flag to npm.

```
npm --registry https://registry.npmjs.org/ adduser
npm --registry https://registry.npmjs.org/ publish
```
