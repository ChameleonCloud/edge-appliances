from time import sleep
from picamera import PiCamera

camera = PiCamera()
camera.resolution = (1024, 768)
camera.start_preview()
# Warm up
sleep(2)
camera.capture('photo.jpg')
