ARG docker_registry=
ARG namespace=
ARG python_version=3.9
FROM ${docker_registry}${namespace}/raspberrypi-ipython:python-${python_version}

RUN echo "deb https://packages.cloud.google.com/apt coral-edgetpu-stable main" \
  | tee /etc/apt/sources.list.d/coral-edgetpu.list
RUN curl https://packages.cloud.google.com/apt/doc/apt-key.gpg \
  | apt-key add -
RUN install_packages python3-tflite-runtime

# Force upgrade numpy; the version installed by apt (dependency of python3-tflite-runtime)
# is out of date and incompatible with the tflite-runtime package.
RUN pip install --upgrade numpy
