# NOTE: ArduCAM's compiled SDK requires Python 3.6 still

FROM balenalib/raspberrypi4-64-python:3.6-latest-build as build

RUN curl --silent --show-error --location https://github.com/ArduCAM/arducam_config_parser/archive/refs/heads/master.tar.gz \
  | tar xz \
  && mv arducam_config_parser-master arducam_config_parser
RUN cd arducam_config_parser/src && make && make install

FROM balenalib/raspberrypi4-64-python:3.6-latest-run as run

WORKDIR /opt/arducam

RUN install_packages \
  libusb-1.0.0

# NOTE(jason): piwheels should be disabled for Python2; the repo responds w/ Python3
# packages even when Python2 is used in the install request.
# Add piwheels repo for greater chance of hitting a precompiled wheel
# https://www.piwheels.org/
RUN printf "[global]\nextra-index-url=https://www.piwheels.org/simple" >/etc/pip.conf
RUN pip install opencv-python-headless

RUN curl --silent --show-error --location https://github.com/ArduCAM/ArduCAM_USB_Camera_Shield/archive/refs/heads/master.tar.gz \
  | tar xz \
  && mv ArduCAM_USB_Camera_Shield-master/Nvidia_Jetson/Python examples \
  && mv ArduCAM_USB_Camera_Shield-master/Config config \
  && rm -rf ArduCAM_USB_Camera_Shield-master

COPY --from=build /usr/lib/libarducam_config_parser.so /usr/lib/
COPY --from=build /usr/include/arducam_config_parser.h /usr/include/

