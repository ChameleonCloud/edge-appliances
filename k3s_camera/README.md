With the k3s device deployment, we do not have additional mounts in containers.
This means the containers cannot use the device's `/opt/vc` directory.

As a solution, we can manually copy the precompiled `/opt/vc` into the image.
Precompiled binaries can be downloaded here:
https://github.com/raspberrypi/firmware

Note: I was unable to use `raspistill`, for reasons that I think are related to
the 64 bit operating system. However, images could be captured via the
`picamera` python module. A sample program `main.py` is included.
