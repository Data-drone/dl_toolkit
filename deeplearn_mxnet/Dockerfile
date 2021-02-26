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
RUN git clone --recursive https://github.com/apache/incubator-mxnet mxnet && \
    cd mxnet && \
    git checkout tags/v1.8.0.rc3 -b 1.8.0
#&& \

ENV OpenCV_DIR=/opt/opencv-4.1.5/cmake_binary
RUN mkdir /opt/mxnet/cmake_binary && \
    cd /opt/mxnet/cmake_binary \
  && cmake -DUSE_CUDA=1 \
    -DUSE_CUDNN=1 \
    -DMXNET_CUDA_ARCH=7.5 \
    -DUSE_OPENCV=1 \
    -DUSE_NCCL=1 \
    -DUSE_OPENMP=0 \
    -DCMAKE_BUILD_TYPE=RELEASE \
    .. \
  && cmake --build . --parallel 8
    # THRUST_IGNORE_CUB_VERSION_CHECK
    #-DUSE_OPENCV_INC_PATH=/opt/conda/envs/computer_vision/include/opencv4 \
    #-DUSE_OPENCV_LIB_PATH=/opt/conda/envs/computer_vision/lib \


# cmake USE_CUDA=1 USE_CUDNN=1 MXNET_CUDA_ARCH=7.5 USE_OPENCV=1 USE_NCCL=1 USE_OPENMP=0 CMAKE_BUILD_TYPE=RELEASE ..
### cmake USE_CUDA=1 USE_CUDNN=1 MXNET_CUDA_ARCH=7.5 USE_OPENCV=1 USE_NCCL=1 USE_OPENCV_INC_PATH=/opt/conda/envs/computer_vision/include/opencv4 USE_OPENCV_LIB_PATH=/opt/conda/envs/computer_vision/lib ..
# cmake USE_CUDA=1 USE_CUDNN=1 MXNET_CUDA_ARCH=7.5 USE_OPENCV=0 USE_NCCL=1 ..

### Install the python bindings

## set for jupyter
WORKDIR $HOME

USER $NB_USER