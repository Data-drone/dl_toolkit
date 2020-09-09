FROM datadrone/deeplearn_opencv:latest

LABEL maintainer="Brian Law <bpl.law@gmail.com>"

# Need to instasll Bazelisk first cause TF isn't compiled for CUDA 10.2
USER root

RUN apt -y install nodejs && \
    apt -y install npm

RUN npm install -g @bazel/bazelisk

## test updating dependencies
RUN pip install -U pip six 'numpy<1.19.0' wheel setuptools mock 'future>=0.17.1' 'gast==0.3.3' typing_extensions && \
    pip install -U keras_applications --no-deps && \
    pip install -U keras_preprocessing --no-deps

## Add in TF repo

WORKDIR /opt
RUN git clone https://github.com/tensorflow/tensorflow.git


WORKDIR /opt/tensorflow

RUN git checkout v2.3.0

# need search paths 
# /usr/include for nccl
# /usr - for cudnn
# /usr/local/cuda - for rest of cuda files
# No to TensorRT then it works

# setting env variables for the compile
# Missing Python / Python Lib / TensorRT / Cuda Compute version / nvcc / opt flag / android 
ENV PYTHON_BIN_PATH=/opt/conda/bin/python3
ENV USE_DEFAULT_PYTHON_LIB_PATH=1
ENV TF_NEED_OPENCL_SYCL=0
ENV TF_NEED_ROCM=0
ENV TF_NEED_CUDA=1
ENV TF_NEED_TENSORRT=0
ENV TF_CUDA_VERSION=10.2
ENV TF_CUDNN_VERSION=7
ENV TF_NCCL_VERSION=2.7.8
ENV TF_CUDA_CLANG=0
ENV TF_SET_ANDROID_WORKSPACE=0
ENV TF_CUDA_COMPUTE_CAPABILITIES=7.5
ENV GCC_HOST_COMPILER_PATH=/usr/bin/gcc
ENV CC_OPT_FLAGS='-march=native -Wno-sign-compare'

RUN ./configure

# TF 2 config - do I need?  --config=opt --config=cuda 
RUN bazel build //tensorflow/tools/pip_package:build_pip_package

RUN bazel-bin/tensorflow/tools/pip_package/build_pip_package /tmp/tensorflow_pkg

# something weird is going on with this...
RUN rm -rf /opt/conda/lib/python3.8/site-packages/numpy-1.19.1.dist-info/

RUN pip install --upgrade /tmp/tensorflow_pkg/tensorflow-*.whl



USER $NB_USER
WORKDIR $HOME