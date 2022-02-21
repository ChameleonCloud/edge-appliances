FROM balenalib/raspberrypi3

RUN apt update
RUN apt install python3-pip -y
RUN apt install --reinstall libraspberrypi0 libraspberrypi-dev libraspberrypi-doc libraspberrypi-bin -y
RUN pip3 install jupyter picamera

ADD ./firmware-master/opt /opt
COPY ./main.py /

CMD jupyter-notebook --allow-root --ip 0.0.0.0
