#!/bin/bash
set -e

IMAGE_NAME=$1
BASE_NAME=$2

CUDA_VERSION_TAG="cuda-$(docker run --rm -a STDOUT ${IMAGE_NAME} cat /usr/local/cuda/version.txt | awk '{print $NF}'  | tr -d '\r')"
docker tag $IMAGE_NAME "$BASE_NAME:${CUDA_VERSION_TAG%%\r}"
MXNET_TAG="mxnet-$(docker run --rm -a STDOUT ${IMAGE_NAME} python -c "import mxnet; print(mxnet.__version__)" | tr -d '\r')"
docker tag $IMAGE_NAME "$BASE_NAME:${MXNET_TAG%%\r}"
