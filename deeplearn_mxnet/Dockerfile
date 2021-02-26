FROM datadrone/deeplearn_opencv:latest

LABEL maintainer="Brian Law <bpl.law@gmail.com>"

# Still WIP - not tested yet
# update to compile for cuda
RUN echo "conda activate computer_vision"
RUN conda install -n computer_vision -y numpy scipy matplotlib pandas scikit-learn

ENV CMAKE_PREFIX_PATH="$(dirname $(which conda))/../"
RUN conda install -n computer_vision -y pyyaml mkl mkl-include setuptools cffi typing

USER root
WORKDIR /opt

RUN apt-get update && \
    apt-get install -y ninja-build ccache

### Build MXNet
RUN echo "conda activate computer_vision"
#ENV CMAKE_PREFIX_PATH=${CONDA_PREFIX:-"$(dirname $(which conda))/../"}
# There is a bug with THRUST_IGNORE_CUB_VERSION_CHECK with CUDA 11.x
# Workaround requires editing a cuda.h file in order to make things work right
RUN git clone --recursive https://github.com/apache/incubator-mxnet mxnet && \
    cd mxnet && \
    git checkout tags/1.8.0.rc3 -b 1.8.x
#&& \

ENV OpenCV_DIR=/opt/opencv-4.1.5/cmake_binary
RUN mkdir /opt/mxnet/cmake_binary && \
    cd /opt/mxnet/cmake_binary \
  && cmake -DCMAKE_BUILD_TYPE=Release \
    -D CMAKE_INSTALL_PREFIX=$(python -c "import sys; print(sys.prefix)") \
    -DUSE_CXX14_IF_AVAILABLE=ON \
    -DUSE_CUDA=ON \
    -DUSE_CUDNN=ON \
    -DUSE_OPENMP=ON \
    -DUSE_TVM_OP=OFF \
    -DMXNET_CUDA_ARCH="7.5" \
    -DUSE_OPENCV=OFF \
    -DUSE_NCCL=ON \
    -DUSE_SSE=ON \
    .. \
  && cmake --build . --parallel 8

    # -GNinja
    #-DUSE_CXX14_IF_AVAILABLE=1 \    
    #-DUSE_OPENCV_INC_PATH=/opt/conda/envs/computer_vision/include/opencv4 \
    #-DUSE_OPENCV_LIB_PATH=/opt/conda/envs/computer_vision/lib \



### Install the python bindings

## set for jupyter
WORKDIR $HOME

USER $NB_USER