FROM datadrone/deeplearn_opencv:cuda-10.1_opencv-4.2.0

LABEL maintainer="Brian Law <bpl.law@gmail.com>"

# update to compile for cuda
RUN conda install -y numpy scipy matplotlib pandas scikit-learn

ENV CMAKE_PREFIX_PATH="$(dirname $(which conda))/../"
RUN conda install numpy pyyaml mkl mkl-include setuptools cmake cffi typing

RUN pip install -y mxnet-cu101