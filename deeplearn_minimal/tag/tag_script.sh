#!/bin/bash
set -e


IMAGE_NAME=$1
BASE_NAME=$2

CUDA_VERSION_TAG="cuda-$(docker run --rm -a STDOUT ${IMAGE_NAME} nvcc --version | grep "release" | awk '{print $6}' | cut -c2- | awk '{print $NF}'  | tr -d '\r' )"
docker tag $IMAGE_NAME "$BASE_NAME:${CUDA_VERSION_TAG%%\r}"
CMAKE_TAG="cmake-$(docker run --rm -it ${IMAGE_NAME} bash -c 'echo "$CMAKE_VERSION"'  | tr -d '\r')"
docker tag $IMAGE_NAME "$BASE_NAME:${CMAKE_TAG%%\r}"
