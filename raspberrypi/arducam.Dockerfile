ARG docker_registry=
ARG namespace=
ARG python_version=3.9
FROM ${docker_registry}${namespace}/raspberrypi-ipython:python-${python_version}

RUN install_packages \
  libusb-1.0.0

# NOTE(jason): piwheels should be disabled for Python2; the repo responds w/ Python3
# packages even when Python2 is used in the install request.
# Add piwheels repo for greater chance of hitting a precompiled wheel
# https://www.piwheels.org/
RUN printf "[global]\nextra-index-url=https://www.piwheels.org/simple" >/etc/pip.conf
RUN pip install flask opencv-python-headless

