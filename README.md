[![Stories in Ready](https://badge.waffle.io/terinjokes/docker-npmjs.png?label=ready)](https://waffle.io/terinjokes/docker-npmjs)

# Docker Image for npm
|Version|0.3.0|
|Docker Versions|^0.6.0|

An easy way to get started with a private npm server, along with npm-delegate.
These instructions assume you've already installed Docker per the [Getting Started](http://www.docker.io/gettingstarted/) guide.

## Building

This image can be built by running the following docker command:

```
docker build -t npmjs github.com/terinjokes/docker-npmjs
```

> You can build from a git tag by appending a ref to the above URL.
> For example `github.com/terinjokes/docker-npmjs#0.3.0`

## Running

After building the image, a container can be spawned.
By providing the hostname via Docker's `-h` option, you can ensure that npm-delegate operates effectively.

```
docker run -d -h cdnutu npmjs
```

## Accessing
npm-delegate is exposed on port 1337, and is what you want to use when installing packages mixed from the private and public repositories.
To use npm-delegate as your default, run:

```
npm config set registry http://cdnutu:1337/
```

npmjs is exposed on port 5984, and is read-write.
To operate directly with this registry, pass use npm's `--registry` argument:

```
npm --registry http://cdnutu:5984/ adduser
npm --registry http://cdnutu:5984/ publish
```
