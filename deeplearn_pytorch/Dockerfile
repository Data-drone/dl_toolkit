ARG CUDA
ARG BASE_IMAGE=datadrone/deeplearn_opencv

FROM $BASE_IMAGE:$CUDA

LABEL maintainer="Brian Law <bpl.law@gmail.com>"

WORKDIR /opt
USER $NB_USER

#RUN conda install -n computer_vision -y magma-cuda111 -c pytorch 
# need to add in magma  

SHELL ["conda", "run", "-n", "computer_vision", "/bin/bash", "-c"]

#RUN echo "conda activate computer_vision"
#-n computer_vision
# See: https://github.com/pytorch/vision/issues/4071 
RUN conda install pytorch=1.10.0  cudatoolkit=11.3 -c pytorch -c nvidia -c conda-forge
# torchvision=0.10.0
# need to do manual in order to make sure that we don't change pytorch versions
#RUN conda install -n computer_vision -c conda-forge yarn

RUN conda install -n computer_vision -y captum -c pytorch 
#RUN git clone https://github.com/pytorch/captum.git && \
#    cd captum && \
#    git checkout tags/v0.3.1 -b v0.3.1 && \
#    pip install -e .[insights]

WORKDIR /opt
USER root

RUN mkdir /opt/jovyan && \
    chown $NB_USER:users /opt/jovyan

WORKDIR /opt/jovyan
USER $NB_USER

# torchvision can take advantage of pillow-simd if there on compile
RUN pip install pillow-simd

# torchvision 0.10.0 is bringing in pytorch 1.6.0 if installed with conda 
#RUN conda install -n computer_vision torchvision -c pytorch
RUN git clone https://github.com/pytorch/vision.git && \
    cd vision && \
    git checkout tags/v0.11.1 -b release/0.11 && \
    python setup.py install
    

#RUN conda install -c fastchan fastai

# Dali plugin
RUN pip install --extra-index-url https://developer.download.nvidia.com/compute/redist nvidia-dali-cuda110

#
RUN pip install wandb pytorch-lightning && \
    pip install torchmetrics && \
    pip install lightning-bolts && \
    pip install six matplotlib scikit-image imageio && \
    pip install --no-dependencies imgaug && \
    pip install PyYAML && \
    pip install --no-dependencies albumentations
#

USER $NB_USER
WORKDIR $HOME
