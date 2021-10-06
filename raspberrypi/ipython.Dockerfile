ARG python_version=3.9
FROM balenalib/raspberrypi4-64-python:${python_version}-latest-run as run

# Add piwheels repo for greater chance of hitting a precompiled wheel
# https://www.piwheels.org/
RUN printf "[global]\nextra-index-url=https://www.piwheels.org/simple" >/etc/pip.conf

RUN pip install ipykernel

VOLUME /run/jupyter
VOLUME /run/ipython
ENV JUPYTER_RUNTIME_DIR=/run/jupyter
ENV IPYTHONDIR=/run/ipython

ENV IPYTHON_CONTROL_PORT=50000
ENV IPYTHON_SHELL_PORT=50001
ENV IPYTHON_STDIN_PORT=50002
ENV IPYTHON_HB_PORT=50003
ENV IPYTHON_IOPUB_PORT=50004


CMD ipython kernel --ip 0.0.0.0 \
  --ConnectionFileMixin.control_port="$IPYTHON_CONTROL_PORT" \
  --ConnectionFileMixin.shell_port="$IPYTHON_SHELL_PORT" \
  --ConnectionFileMixin.stdin_port="$IPYTHON_STDIN_PORT" \
  --ConnectionFileMixin.hb_port="$IPYTHON_HB_PORT" \
  --ConnectionFileMixin.iopub_port="$IPYTHON_IOPUB_PORT"

