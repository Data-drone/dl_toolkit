ARG CUDA

FROM datadrone/deeplearn_opencv:$CUDA

LABEL maintainer="Brian Law <bpl.law@gmail.com>"

WORKDIR /opt
USER root

RUN conda install -n computer_vision -y magma-cuda111 -c pytorch 
# need to add in magma  

SHELL ["conda", "run", "-n", "computer_vision", "/bin/bash", "-c"]

RUN echo "conda activate computer_vision"
RUN conda install -n computer_vision pytorch cudatoolkit=11.1 -c pytorch -c conda-forge

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
    git checkout tags/v0.9.0 -b release/0.9 && \
    python setup.py install

# RUN conda install -c pytorch -c fastai fastai

# Dali plugin
RUN pip install --extra-index-url https://developer.download.nvidia.com/compute/redist nvidia-dali-cuda111

WORKDIR /opt

RUN pip install wandb pytorch-lightning && \
    pip install six Pillow matplotlib scikit-image imageio && \
    pip install --no-dependencies imgaug && \
    pip install PyYAML && \
    pip install --no-dependencies albumentations

WORKDIR $HOME

USER $NB_USER
