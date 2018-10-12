# Docker Image for Fastai course Part 1 - v3

This container is built according to the instructions for Local setup of the fastai Part 1 - v3 course

It is built with nvidia docker cuda 9.2 with jupyter installed on top as per the official jupyter notebook docker images

# Requirements
* docker-ce
* nvidia docker v2 (see https://github.com/nvidia/nvidia-docker/wiki/Installation-(version-2.0) )
* nvidia drivers 396 installed on an ubuntu host and a CUDA 9.2 compatible video card

# Extras

It includes on top:
* numpy
* scipy
* scikit learn
* scikit image
* pandas
* matplotlib
* jupyter notebook
