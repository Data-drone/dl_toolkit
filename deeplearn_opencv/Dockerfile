FROM datadrone/deeplearn_minimal:latest

LABEL maintainer="Brian Law <bpl.law@gmail.com>"

USER $NB_USER 

RUN conda create --name computer_vision python=3.8 ipykernel numpy scipy matplotlib scikit-image scikit-learn openblas
SHELL ["conda", "run", "-n", "computer_vision", "/bin/bash", "-c"]
# C++ Jupyter kernel for interfacing with opencv
# triggers a lot of compatability issues
#RUN conda install -y xeus-cling -c conda-forge

USER root

# essentials
RUN apt-get update && \
    apt-get -y install unzip pkg-config

# image and io libraries
RUN apt-get -y install libjpeg-dev libpng-dev libtiff-dev && \
    apt-get -y install libavcodec-dev libavformat-dev libswscale-dev libv4l-dev && \
    apt-get -y install libxvidcore-dev libx264-dev && \
    apt-get -y install libxine2-dev 

# c++ threading
RUN apt-get -y install libtbb2 libtbb-dev

# backend
RUN apt-get -y install libgtk-3-dev

# math optimisations
RUN apt-get -y install libatlas-base-dev gfortran && \
    apt-get -y install liblapack-dev libopenblas-dev liblapacke-dev


# do we need?
WORKDIR  /usr/include/linux
RUN sudo ln -s -f ../libv4l1-videodev.h videodev.h

RUN apt-get -y install libgstreamer1.0-dev libgstreamer-plugins-base1.0-dev && \
    apt-get -y install qt5-default && \
    apt-get -y install libfaac-dev libmp3lame-dev libtheora-dev && \
    apt-get -y install libvorbis-dev libxvidcore-dev && \
    apt-get -y install libopencore-amrnb-dev libopencore-amrwb-dev && \
    apt-get -y install libavresample-dev && \
    apt-get -y install v4l-utils libglib2.0-0

# Optional dependencies
RUN apt-get -y install libprotobuf-dev protobuf-compiler && \
    apt-get -y install libgoogle-glog-dev libgflags-dev && \
    apt-get -y install libgphoto2-dev libeigen3-dev libhdf5-dev doxygen

WORKDIR /opt

# build opencv
ENV OPENCV_VERSION="4.5.1"
RUN wget https://github.com/opencv/opencv/archive/${OPENCV_VERSION}.zip \
&& wget -O opencv_contrib.zip  https://github.com/opencv/opencv_contrib/archive/${OPENCV_VERSION}.zip \
&& unzip ${OPENCV_VERSION}.zip \
&& unzip opencv_contrib.zip \
&& mkdir /opt/opencv-${OPENCV_VERSION}/cmake_binary \
&& cd /opt/opencv-${OPENCV_VERSION}/cmake_binary \
&& cmake -DBUILD_TIFF=ON \
  -DCMAKE_LIBRARY_PATH=/usr/local/cuda/lib64/stubs \
  -DENABLE_PRECOMPILED_HEADERS=OFF \
  -DBUILD_opencv_java=OFF \
  -DBUILD_OPENCV_PYTHON=ON \
  -DWITH_CUDA=ON \
  -D WITH_CUDNN=ON \
  -D OPENCV_DNN_CUDA=ON \
  -DCUDA_FAST_MATH=ON \
  -DCUDA_ARCH_BIN=7.5 \
  -D WITH_CUBLAS=1 \
  -DOPENCV_ENABLE_NONFREE=ON \
  -DENABLE_FAST_MATH=1 \
  -DWITH_OPENGL=ON \
  -DWITH_GSTREAMER=ON \
  -DWITH_IPP=ON \
  -DWITH_TBB=ON \
  -DWITH_EIGEN=ON \
  -DWITH_V4L=ON \
  -DBUILD_TESTS=OFF \
  -DBUILD_PERF_TESTS=OFF \
  -DCMAKE_BUILD_TYPE=RELEASE \
  -DOPENCV_EXTRA_MODULES_PATH=/opt/opencv_contrib-${OPENCV_VERSION}/modules \
  -DBUILD_opencv_python2=OFF \
  -DCMAKE_INSTALL_PREFIX=$(python3 -c "import sys; print(sys.prefix)") \
  -DPYTHON_EXECUTABLE=$(which python)  \
  -DPYTHON_DEFAULT_EXECUTABLE=/opt/conda/envs/computer_vision/bin/python \
  .. \ 
&& make install -j48

RUN rm /opt/${OPENCV_VERSION}.zip

# cling manual deps
#RUN conda install binutils_impl_linux-64 binutils_linux-64 clang_variant -c conda-forge && \
#    conda install gcc_impl_linux-64 gxx_linux-64 gxx_impl_linux-64 gxx_linux-64 -c conda-forge && \
#    conda install nlohmann_json pugixml xtl cppzmq -c conda-forge && \
#    conda install clangdev  -c conda-forge 
    
# no deps to stop messing with mkl
#RUN conda install -y --no-deps xeus-cling cling -c conda-forge
# there is a new conda path we need to check in the container
#WORKDIR /opt/conda/python
#RUN python setup.py develop

WORKDIR $HOME

USER $NB_USER
