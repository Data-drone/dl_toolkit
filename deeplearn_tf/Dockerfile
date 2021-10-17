ARG CUDA
ARG BASE_IMAGE=datadrone/deeplearn_pytorch

FROM $BASE_IMAGE:$CUDA

LABEL maintainer="Brian Law <bpl.law@gmail.com>"

# Need to instasll Bazelisk first cause TF isn't compiled for CUDA 10.2
USER $NB_USER

# switch to computer_vision subspace
RUN echo "conda activate computer_vision"
## test updating dependencies
RUN pip install -U pip six numpy wheel setuptools mock 'future>=0.17.1' 'gast==0.3.3' typing_extensions && \
    pip install -U keras_applications --no-deps && \
    pip install -U keras_preprocessing --no-deps

## Install Tensorflow
RUN pip install tensorflow

## Add trax and jax and flax stuff
RUN pip install --upgrade "jax[cuda111]" -f https://storage.googleapis.com/jax-releases/jax_releases.html
RUN pip install flax
RUN pip install -q -U trax

USER $NB_USER
WORKDIR $HOME
