FROM datadrone/deeplearn_opencv:latest

LABEL maintainer="Brian Law <bpl.law@gmail.com>"

WORKDIR /opt
USER root

ENV TORCH_CUDA_ARCH_LIST=7.5
ENV FORCE_CUDA=1
#RUN conda install pytorch torchvision cudatoolkit=10.2 -c pytorch
RUN conda install -n computer_vision -y magma-cuda112 -c pytorch 
#RUN conda install -n computer_vision pytorch cudatoolkit>=11 -c pytorch

# need to add in magma  
# added test for enabling opencv integration

SHELL ["conda", "run", "-n", "computer_vision", "/bin/bash", "-c"]

RUN echo "conda activate computer_vision"
ENV CMAKE_PREFIX_PATH=${CONDA_PREFIX:-"$(dirname $(which conda))/../"}
ENV USE_CUDA=1
RUN git clone --recursive https://github.com/pytorch/pytorch && \
    cd pytorch && \
    git checkout tags/v1.7.1 -b release/1.7 && \
    git submodule sync && \
    git submodule update --init --recursive && \
    USE_OPENCV=1 python setup.py install



#RUN conda install -c pytorch captum
# need to do manual in order to make sure that we don't change pytorch versions
RUN conda install -n computer_vision -c conda-forge yarn

RUN git clone https://github.com/pytorch/captum.git && \
    cd captum && \
    git checkout tags/v0.3.1 -b v0.3.1 && \
    pip install -e .[insights]

WORKDIR /opt

# issue with compiling with torch
# need to debug compile with 0.5.0 

#RUN conda install -n computer_vision torchvision -c pytorch
RUN git clone https://github.com/pytorch/vision.git && \
    cd vision && \
    git checkout tags/v0.8.2 -b release/0.8.0 && \
    python setup.py install

# RUN conda install -c pytorch -c fastai fastai

# Dali plugin
RUN pip install --extra-index-url https://developer.download.nvidia.com/compute/redist nvidia-dali-cuda110

# need to wait till pytorch is compiled with cuda 10.1
# Apex is going to be deprecated should move to pytorch apex
WORKDIR /opt
#RUN git clone https://github.com/NVIDIA/apex && \
#    cd apex && \
#    pip install -v --no-cache-dir --global-option="--cpp_ext" --global-option="--cuda_ext" ./

# install lightning and loggers and ablumentations
# removed numpy and scipy as they should be there already
RUN pip install wandb pytorch-lightning && \
    pip install six Pillow matplotlib scikit-image imageio && \
    pip install --no-dependencies imgaug && \
    pip install PyYAML && \
    pip install --no-dependencies albumentations


WORKDIR $HOME

USER $NB_USER
