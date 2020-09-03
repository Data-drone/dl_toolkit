#!/bin/bash
set -e

# Base
cd docker_base

BASE_NAME="datadrone/deeplearn_base"
IMAGE_NAME="$BASE_NAME:latest"
docker build . -f Dockerfile_cuda102 -t $IMAGE_NAME

PY_VERSION_TAG="python-$(docker run --rm ${IMAGE_NAME} python --version 2>&1 | awk '{print $2}')"
docker tag $IMAGE_NAME "$BASE_NAME:$PY_VERSION_TAG"
NB_VERSION_TAG="notebook-$(docker run --rm -a STDOUT ${IMAGE_NAME} jupyter-notebook --version | tr -d '\r')"
docker tag $IMAGE_NAME "$BASE_NAME:${NB_VERSION_TAG%% }"
LAB_VERSION_TAG="lab-$(docker run --rm -a STDOUT ${IMAGE_NAME} jupyter-lab --version | tr -d '\r')"
docker tag $IMAGE_NAME "$BASE_NAME:${LAB_VERSION_TAG%%\r}"
HUB_VERSION_TAG="hub-$(docker run --rm -a STDOUT ${IMAGE_NAME} jupyterhub --version | tr -d '\r')"
docker tag $IMAGE_NAME "$BASE_NAME:${HUB_VERSION_TAG%%\r}"
CUDA_VERSION_TAG="cuda-$(docker run --rm -a STDOUT ${IMAGE_NAME} cat /usr/local/cuda/version.txt | awk '{print $NF}'  | tr -d '\r')"
docker tag $IMAGE_NAME "$BASE_NAME:${CUDA_VERSION_TAG%%\r}"

cd ..

# Minimal
cd docker_minimal

BASE_NAME="datadrone/deeplearn_minimal"
IMAGE_NAME="$BASE_NAME:latest"
docker build . -f Dockerfile_cuda102 -t $IMAGE_NAME

CUDA_VERSION_TAG="cuda-$(docker run --rm -a STDOUT ${IMAGE_NAME} cat /usr/local/cuda/version.txt | awk '{print $NF}'  | tr -d '\r')"
docker tag $IMAGE_NAME "$BASE_NAME:${CUDA_VERSION_TAG%%\r}"
CMAKE_TAG="cmake-$(docker run --rm -a STDOUT ${IMAGE_NAME} echo $CMAKE_VRESION  | tr -d '\r')"
docker tag $IMAGE_NAME "$BASE_NAME:${CMAKE_TAG%%\r}"


cd ..

# OpenCV
cd docker_opencv
BASE_NAME="datadrone/deeplearn_opencv"
IMAGE_NAME="$BASE_NAME:latest"
docker build . -f Dockerfile_cuda102 -t $IMAGE_NAME

CUDA_VERSION_TAG="cuda-$(docker run --rm -a STDOUT ${IMAGE_NAME} cat /usr/local/cuda/version.txt | awk '{print $NF}'  | tr -d '\r')"
docker tag $IMAGE_NAME "$BASE_NAME:${CUDA_VERSION_TAG%%\r}"
OPENCV_TAG="opencv-$(docker run --rm -a STDOUT ${IMAGE_NAME} echo $OPENCV_VERSION  | tr -d '\r')"
docker tag $IMAGE_NAME "$BASE_NAME:${OPENCV_TAG%%\r}"

cd ..

# PyTorch
cd docker_pytorch
BASE_NAME="datadrone/deeplearn_pytorch"
IMAGE_NAME="$BASE_NAME:latest"
docker build . -f Dockerfile_cuda102 -t $IMAGE_NAME

CUDA_VERSION_TAG="cuda-$(docker run --rm -a STDOUT ${IMAGE_NAME} cat /usr/local/cuda/version.txt | awk '{print $NF}'  | tr -d '\r')"
docker tag $IMAGE_NAME "$BASE_NAME:${CUDA_VERSION_TAG%%\r}"
PYTORCH_TAG="pytorch-$(docker run --rm -a STDOUT ${IMAGE_NAME} python -c "import torch; print(torch.__version__)" | tr -d '\r')"
docker tag $IMAGE_NAME "$BASE_NAME:${PYTORCH_TAG%%\r}"


cd ..

# TF
cd docker_tf
BASE_NAME="datadrone/deeplearn_tf"
IMAGE_NAME="$BASE_NAME:latest"
docker build . -f Dockerfile_cuda10_tf -t $IMAGE_NAME

CUDA_VERSION_TAG="cuda-$(docker run --rm -a STDOUT ${IMAGE_NAME} cat /usr/local/cuda/version.txt | awk '{print $NF}'  | tr -d '\r')"
docker tag $IMAGE_NAME "$BASE_NAME:${CUDA_VERSION_TAG%%\r}"
TENSORFLOW_TAG="pytorch-$(docker run --rm -a STDOUT ${IMAGE_NAME} python -c "import tensorflow; print(tensorflow.__version__)" | tr -d '\r')"
docker tag $IMAGE_NAME "$BASE_NAME:${TENSORFLOW_TAG%%\r}"


cd ..

