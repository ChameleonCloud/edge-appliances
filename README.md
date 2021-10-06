# CHI@Edge Appliances

A collection of base images configured to work with the CHI@Edge testbed.

## Building images

First, a few notes:

* In general images are parameterized by their Python version, which is passed as a [Docker build argument](https://docs.docker.com/engine/reference/commandline/build/#set-build-time-variables---build-arg) `python_version`.
* Some images depend on other images in the tree; this is not yet explicit, so you may have to manually build parent images.

To (re)build an image, use the `build.sh` helper script and pass the path to the Dockerfile.

```shell
# will output an image raspberrypi-ipython:python-3.9 using Python 3.9
./build.sh raspberrypi/ipython.Dockerfile --build-arg python_version=3.9 --tag python-3.9

# will build an image raspberrypi-ipython:latest using the configured default Python version
./build.sh raspberrypi/ipython.Dockerfile
```

To additionally push the image to a registry (specified by `$DOCKER_REGISTRY` and defaulting to Chameleon's Docker registry), pass the `--push` flag:

```shell
./build.sh raspberrypi/ipython.Dockefile --build-arg python_version=3.9 --tag python-3.9 --push
```

## Adding a new image

In general, try to extend from a base image that installs IPython; this is because those images are very useful in conjunction with the Jupyter ecosystem and can be used by the Chameleon multiplexer kernel to allow multiple containers to be controlled from a single Notebook.

For example, for the `raspberrypi` class of images, a new Dockerfile could be placed in `./raspberrypi/new_image.Dockerfile`

```dockerfile
ARG python_version
FROM raspberrypi/ipython:python-${python_version}

RUN touch foo.txt
```

The build context for images will be the directory the Dockerfile is in, so in this case, `./raspberrypi`.

