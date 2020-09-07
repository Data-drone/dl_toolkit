FROM datadrone/deeplearn_minimal:latest

LABEL maintainer="Brian Law <bpl.law@gmail.com>"

# update to compile for cuda
RUN conda install -y numpy scipy matplotlib pandas scikit-learn

ENV CMAKE_PREFIX_PATH="$(dirname $(which conda))/../"
RUN conda install numpy pyyaml mkl mkl-include setuptools cmake cffi typing

RUN pip install mxnet-cu102 gluonts