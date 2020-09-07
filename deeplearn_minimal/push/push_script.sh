#!/bin/bash
set -e

IMAGE_NAME=$1
BASE_NAME=$2

CUDA_VERSION_TAG="cuda-$(docker run --rm -a STDOUT ${IMAGE_NAME} cat /usr/local/cuda/version.txt | awk '{print $NF}'  | tr -d '\r')"
CMAKE_TAG="cmake-$(docker run --rm -a STDOUT ${IMAGE_NAME} echo $CMAKE_VRESION  | tr -d '\r')"

docker push "$IMAGE_NAME"
docker push "$BASE_NAME:${CUDA_VERSION_TAG%%\r}"
docker push "$BASE_NAME:${CMAKE_TAG%%\r}"
