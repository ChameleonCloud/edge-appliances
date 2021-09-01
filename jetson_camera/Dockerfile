FROM nvcr.io/nvidia/l4t-ml:r32.5.0-py3

RUN pip3 install --upgrade pip==21.1.3

# redirect symbolic link needs corrected
# https://forums.developer.nvidia.com/t/problem-with-gazebo/65769
RUN rm /usr/lib/aarch64-linux-gnu/libdrm.so.2
RUN ln -s /usr/lib/aarch64-linux-gnu/libdrm.so.2.4.0 /usr/lib/aarch64-linux-gnu/libdrm.so.2

CMD /bin/bash -c "jupyter lab --ip 0.0.0.0 --port 8888 --no-browser --allow-root &> /var/log/jupyter.log" & \
	echo "allow 10 sec for JupyterLab to start @ http://$(hostname -I | cut -d' ' -f1):8888 (password nvidia)" && \
	echo "JupterLab logging location:  /var/log/jupyter.log  (inside the container)" && \
	/bin/bash
