ARG CUDA
FROM datadrone/deeplearn_tf:$CUDA

LABEL maintainer="Brian Law <bpl.law@gmail.com>"

# Still WIP - not tested yet
# update to compile for cuda
RUN echo "conda activate computer_vision"
RUN conda install -n computer_vision -y numpy scipy matplotlib pandas scikit-learn

ENV CMAKE_PREFIX_PATH="$(dirname $(which conda))/../"
RUN conda install -n computer_vision -y pyyaml mkl mkl-include setuptools cffi typing

USER root
WORKDIR /opt

#RUN apt-get update && \
#    apt-get install -y ninja-build ccache

# use mxnet nightlies for now
RUN echo "conda activate computer_vision"
SHELL ["conda", "run", "-n", "computer_vision", "/bin/bash", "-c"]

#RUN pip install mxnet-cu110==1.9.0b20210712 -f https://dist.mxnet.io/python/cu110
# mxnet-cu112==1.9.0b20210712 -f https://dist.mxnet.io/python/cu112
#RUN conda install -y mkl -c conda-forge 
### Build MXNet
ENV CMAKE_PREFIX_PATH=${CONDA_PREFIX:-"$(dirname $(which conda))/../"}
# There is a bug with THRUST_IGNORE_CUB_VERSION_CHECK with CUDA 11.x
# Workaround requires editing a cuda.h file in order to make things work right
RUN git clone --recursive https://github.com/apache/incubator-mxnet mxnet && \
    cd mxnet && \
    git checkout tags/1.9.0.rc6 -b 1.9.x  && \
    git submodule update --init --recursive
    
#&& \
# it looks like mshadow always requires mkl?
# so we need to set USE_BLAS to mkl in order for it to compile

RUN mkdir /opt/mxnet/cmake_binary && \
    cd /opt/mxnet/cmake_binary \
  && cmake -DCMAKE_BUILD_TYPE=Release \
    -DCMAKE_INSTALL_PREFIX=$(python -c "import sys; print(sys.prefix)") \
    -DCMAKE_FIND_ROOT_PATH=${CONDA_PREFIX} \
    -DCMAKE_FIND_ROOT_PATH_MODE_LIBRARY=BOTH \
    -DUSE_OPENCV=ON \
    -DUSE_MKLDNN=ON \
    -DUSE_LAPACK=ON \
    -DUSE_ONEDNN=ON \
    -DUSE_MKL_IF_AVAILABLE=OFF \
    -DUSE_BLAS=mkl \
    -DUSE_INTEL_PATH=${CONDA_PREFIX}/lib \
    -DUSE_CUDA=ON \
    -DUSE_CUDNN=ON \
    -DUSE_OPENMP=ON \
    -DUSE_TVM_OP=OFF \
    -DMXNET_CUDA_ARCH="7.5" \
    -DUSE_NCCL=ON \
    -DUSE_SSE=ON \
    .. \
  && cmake --build . --parallel 28

    # issue with CXX14 maybe conda is involved too?
    # -GNinja
    #-DUSE_CXX14_IF_AVAILABLE=1 \    
    #-DUSE_OPENCV_INC_PATH=/opt/conda/envs/computer_vision/include/opencv4 \
    #-DUSE_OPENCV_LIB_PATH=/opt/conda/envs/computer_vision/lib \

ENV MXNET_LIBRARY_PATH=/opt/mxnet/cmake_binary/libmxnet.so

WORKDIR /opt/mxnet
### Install the python bindings
# Python command is not finding the mxnet lib
RUN pip install -e ./python

## set for jupyter
WORKDIR $HOME

USER $NB_USER