FROM datadrone/deeplearn_minimal:cuda-9.2

LABEL maintainer="Brian Law <bpl.law@gmail.com>"

RUN conda install -y numpy scipy matplotlib scikit-image scikit-learn
# C++ Jupyter kernel for interfacing with opencv
RUN conda install -y xeus -c QuantStack

USER root

RUN apt-get update && \
    apt-get -y install pkg-config yasm gfortran && \
    apt-get -y install libjpeg8-dev libjasper-dev libpng12-dev

RUN apt-get -y install libtiff5-dev libtiff-dev

RUN apt-get -y install libavcodec-dev libavformat-dev libswscale-dev libdc1394-22-dev && \
    apt-get -y install libxine2-dev libv4l-dev

WORKDIR  /usr/include/linux
RUN sudo ln -s -f ../libv4l1-videodev.h videodev.h

RUN apt-get -y install libgstreamer0.10-dev libgstreamer-plugins-base0.10-dev && \
    apt-get -y install libgtk2.0-dev libtbb-dev qt5-default && \
    apt-get -y install libatlas-base-dev && \
    apt-get -y install libfaac-dev libmp3lame-dev libtheora-dev && \
    apt-get -y install libvorbis-dev libxvidcore-dev && \
    apt-get -y install libopencore-amrnb-dev libopencore-amrwb-dev && \
    apt-get -y install libavresample-dev && \
    apt-get -y install x264 v4l-utils

# Optional dependencies
RUN apt-get -y install libprotobuf-dev protobuf-compiler && \
    apt-get -y install libgoogle-glog-dev libgflags-dev && \
    apt-get -y install libgphoto2-dev libeigen3-dev libhdf5-dev doxygen

WORKDIR /opt

# build opencv
ENV OPENCV_VERSION="3.4.3"
RUN wget https://github.com/opencv/opencv/archive/${OPENCV_VERSION}.zip \
&& unzip ${OPENCV_VERSION}.zip \
&& mkdir /opt/opencv-${OPENCV_VERSION}/cmake_binary \
&& cd /opt/opencv-${OPENCV_VERSION}/cmake_binary \
&& cmake -DBUILD_TIFF=ON \
  -DENABLE_PRECOMPILED_HEADERS=OFF \
  -DBUILD_opencv_java=OFF \
  -DBUILD_OPENCV_PYTHON=ON \
  -DWITH_CUDA=ON \
  -DWITH_OPENGL=ON \
  -DWITH_OPENCL=ON \
  -DWITH_IPP=ON \
  -DWITH_TBB=ON \
  -DWITH_EIGEN=ON \
  -DWITH_V4L=ON \
  -DBUILD_TESTS=OFF \
  -DBUILD_PERF_TESTS=OFF \
  -DCMAKE_BUILD_TYPE=RELEASE \
  -DCMAKE_INSTALL_PREFIX=$(python3 -c "import sys; print(sys.prefix)") \
  -DPYTHON_EXECUTABLE=/opt/conda/python3.6m  \
  -DPYTHON_PACKAGES_PATH=/opt/conda/python3.6m \
  -DPYTHON_INCLUDE_DIR=$(python3 -c "from distutils.sysconfig import get_python_inc; print(get_python_inc())") \
  -DPYTHON_PACKAGES_PATH=$(python3 -c "from distutils.sysconfig import get_python_lib; print(get_python_lib())") \
  .. \ 
&& make install

RUN rm /opt/${OPENCV_VERSION}.zip

WORKDIR $HOME

USER $NB_USER
