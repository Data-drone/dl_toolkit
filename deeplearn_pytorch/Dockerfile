FROM datadrone/deeplearn_opencv:latest

LABEL maintainer="Brian Law <bpl.law@gmail.com>"

# update to compile for cuda
# done already in opencv book
# RUN conda install -y numpy scipy matplotlib pandas scikit-learn


#ENV CMAKE_PREFIX_PATH="$(dirname $(which conda))/../"
#RUN conda install pyyaml mkl mkl-include setuptools cffi typing 
    #&& \
    #conda install -c pytorch magma-cuda101

# fix for https://github.com/conda/conda/issues/9367
#RUN conda config --add channels defaults && \
#    conda config --add channels conda-forge && \
#    conda config --add channels pytorch && \
#    conda config --add channels fastai

# fixed in base notebook
#RUN conda config --set allow_conda_downgrades true && \
#    conda install conda=4.6.14

WORKDIR /opt

ENV TORCH_CUDA_ARCH_LIST=7.5
ENV FORCE_CUDA=1
#RUN conda install pytorch torchvision cudatoolkit=10.2 -c pytorch
#RUN conda install pytorch torchvision torchaudio cudatoolkit=11.0 -c pytorch

# need to add in magma  
# added test for enabling opencv integration
RUN conda install -y magma-cuda111 -c pytorch 

ENV CMAKE_PREFIX_PATH=${CONDA_PREFIX:-"$(dirname $(which conda))/../"}
RUN git clone --recursive https://github.com/pytorch/pytorch && \
    cd pytorch && \
    git checkout tags/v1.7.1 && \
    git submodule sync && \
    git submodule update --init --recursive && \
    USE_OPENCV=1 python setup.py install

WORKDIR /opt

#RUN conda install -c pytorch captum
# need to do manual in order to make sure that we don't change pytorch versions
RUN conda install -c conda-forge yarn && \
    git clone https://github.com/pytorch/captum.git && \
    cd captum && \
    git checkout tags/v0.3.0 && \
    pip install -e .[insights]

WORKDIR /opt

# issue with compiling with torch
# need to debug compile with 0.5.0 

#RUN conda install torchvision -c pytorch
#RUN git clone https://github.com/pytorch/vision.git && \
#    cd vision && \
#    git checkout tags/v0.5.0 && \
#    python setup.py install

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
RUN pip install wandb pytorch-lightning && \
    pip install six numpy scipy Pillow matplotlib scikit-image imageio && \
    pip install --no-dependencies imgaug && \
    pip install PyYAML && \
    pip install --no-dependencies albumentations


WORKDIR $HOME

USER $NB_USER
