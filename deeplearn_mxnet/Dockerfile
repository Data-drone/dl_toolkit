FROM datadrone/deeplearn_minimal:latest

LABEL maintainer="Brian Law <bpl.law@gmail.com>"

# Still WIP - not tested yet
# update to compile for cuda
RUN echo "conda activate computer_vision"
RUN conda install -n computer_vision -y numpy scipy matplotlib pandas scikit-learn

ENV CMAKE_PREFIX_PATH="$(dirname $(which conda))/../"
RUN conda install -n computer_vision -y pyyaml mkl mkl-include setuptools cffi typing

#RUN pip install mxnet-cu102 gluonts

RUN git clone --recursive https://github.com/apache/incubator-mxnet mxnet && \
    cd mxnet && \
    git checkout tags/1.7.0 -b v1.7.x && \

RUN apt-get update && \
    apt-get install -y build-essential git ninja-build ccache libopenblas-dev

