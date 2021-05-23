ARG TENSORRT="7"
ARG CUDA="10"

FROM hakuyyf/tensorrtx:trt${TENSORRT}_cuda${CUDA}

COPY ./model/best.pt /best.pt

# Get opencv 3.4 for bionic based images
RUN rm /etc/apt/sources.list.d/timsc-ubuntu-opencv-3_3-bionic.list
RUN rm /etc/apt/sources.list.d/timsc-ubuntu-opencv-3_3-bionic.list.save
RUN add-apt-repository -y ppa:timsc/opencv-3.4

RUN apt-get update
RUN apt-get install -y libopencv-dev libopencv-dnn-dev libopencv-shape3.4-dbg

# git clone tensorrtx
RUN git clone https://github.com/wang-xinyu/tensorrtx.git

# install dependencies for pycuda
RUN apt-get install build-essential binutils gdb freeglut3 freeglut3-dev libxi-dev libxmu-dev python-dev python-setuptools libboost-python-dev libboost-thread-dev -y
RUN pip3 install --upgrade pip
RUN pip3 install pycuda opencv-python
# fix stupid opencv lib path
RUN ln -s /usr/include/opencv2 /usr/include/opencv

RUN cd ~ && git clone https://github.com/ultralytics/yolov5
RUN cd ~/yolov5 && pip3 install -r requirements.txt
RUN pip3 install utils
WORKDIR ~/yolov5
RUN cp /tensorrtx/yolov5/gen_wts.py ~/yolov5/gen_wts.py
RUN cd ~/yolov5 && python3 gen_wts.py /best.pt
RUN cp /best.wts /tensorrtx/yolov5/best.wts

WORKDIR /tensorrtx/yolov5
RUN sed 's/int CLASS_NUM = 80;/int CLASS_NUM = 8;/g' /tensorrtx/yolov5/yololayer.h > /tensorrtx/yolov5/yololayer_1.h
RUN mv yololayer_1.h yololayer.h

RUN pip3 uninstall -y torch torchvision
RUN pip3 install torch==1.2.0 torchvision==0.4.0

RUN mkdir /tensorrtx/yolov5/build
WORKDIR /tensorrtx/yolov5/build
RUN cmake ..
RUN make

RUN apt install python3-libnvinfer=7.0.0-1+cuda10.0
RUN apt install python3-libnvinfer-dev=7.0.0-1+cuda10.0

RUN pip3 install flask

COPY . /app
WORKDIR /app

RUN cp /tensorrtx/yolov5/build/libmyplugins.so /app/libmyplugins.so

CMD /tensorrtx/yolov5/build/yolov5 -s /best.wts yolov5s.engine s && python3 app.py --host=0.0.0.0 --port=5000 --engine=./yolov5s.engine --plugins=./libmyplugins.so
