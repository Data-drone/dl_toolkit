# DL Toolkit

Some docker containers for experimenting with deep learning.

Nvidia provides three types of images for each os / cuda version.
- base: Includes the CUDA runtime (cudart)
- runtime: Builds on the base and includes the CUDA math libraries, and NCCL. A runtime image that also includes cuDNN is available.
- devel: Builds on the runtime and includes headers, development tools for building CUDA images. These images are particularly useful for multi-stage builds. 

See: https://hub.docker.com/r/nvidia/cuda

The idea of these images is to rebase the jupyter stack docker iamges:
See: https://github.com/jupyter/docker-stacks 
with a Nvidia cuda base for the purposes of experimenting with deeplearning and other GPU based ML things.

# Images

- deeplearn base:
  - Mirrors jupyter-stack base-notebook with cuda base image

- deeplearn minimal:
  - Mirrors jupyter-stack minimal-notebook with cuda base image

- deeplearn_opencv:
  - Opencv can be hard to install and configure properly especially to enable CUDA support as well.
  - Builds a base image
# Building:

```{bash}

# build all the images listed in ALL_IMAGES
make build-all

# build individual images:
# check makefile for individual build strings
make build-xxx  

```

# Deeplearn Base

This is the jupyter docker base build but on top of nvidia docker instead to enable GPU functionality. Also with added nbdev and debugger components

see: https://github.com/jupyter/docker-stacks/tree/master/base-notebook
https://hub.docker.com/repository/docker/datadrone/deeplearn_base


# Deeplearn Minimal

This is the jupyter docker minimal build on top of the base

see: https://github.com/jupyter/docker-stacks/tree/master/minimal-notebook
https://hub.docker.com/repository/docker/datadrone/deeplearn_minimal


# Deeplearn Opencv

This is Minimal + OpenCV
https://hub.docker.com/repository/docker/datadrone/deeplearn_opencv

Current compiled with opencv 4.5.1  with Compute Model 7.5

# Deeplearn Pytorch

This is docker OpenCV plus pytorch 1.7
Latest is currently on CUDA 11.0 with Torch 1.7.1
# Deeplearn TF

This is docker OpenCV plus TensorFlow 2.x
Latest is currently on CUDA 11.2 with TF 2.4.1

# Deeplearn_mxnet

This is docker OpenCV plus MXNet 1.9.0 nightly
There were issues with compiling and there is no 1.8.x stable release on cuda 11.x at the moment.

# Docker Rapids

This adds in the Nvidia RAPIDS.ai libraries 0.18 with dask dashboard for jupyter 3.0
## TODO

Make the base image an arg?
Make build vs pip/conda installed versions of Pytorch/MXNet/TF?
Make a parameter in the Makefile for CUDA versions?