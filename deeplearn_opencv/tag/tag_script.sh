#!/bin/bash
set -e

IMAGE_NAME=$1
BASE_NAME=$2

CUDA_VERSION_TAG="cuda-$(docker run --rm -a STDOUT ${IMAGE_NAME} cat /usr/local/cuda/version.txt | awk '{print $NF}'  | tr -d '\r')"
docker tag $IMAGE_NAME "$BASE_NAME:${CUDA_VERSION_TAG%%\r}"
OPENCV_TAG="opencv-$(docker run --rm -a STDOUT ${IMAGE_NAME} echo $OPENCV_VERSION  | tr -d '\r')"
docker tag $IMAGE_NAME "$BASE_NAME:${OPENCV_TAG%%\r}"
