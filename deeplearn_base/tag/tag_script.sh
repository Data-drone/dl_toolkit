#!/bin/bash
set -e


IMAGE_NAME=$1
BASE_NAME=$2

PY_VERSION_TAG="python-$(docker run --rm ${IMAGE_NAME} python --version 2>&1 | awk '{print $2}')"
docker tag $IMAGE_NAME "$BASE_NAME:$PY_VERSION_TAG"
NB_VERSION_TAG="notebook-$(docker run --rm -a STDOUT ${IMAGE_NAME} jupyter-notebook --version | tr -d '\r')"
docker tag $IMAGE_NAME "$BASE_NAME:${NB_VERSION_TAG%% }"
LAB_VERSION_TAG="lab-$(docker run --rm -a STDOUT ${IMAGE_NAME} jupyter-lab --version | tr -d '\r')"
docker tag $IMAGE_NAME "$BASE_NAME:${LAB_VERSION_TAG%%\r}"
HUB_VERSION_TAG="hub-$(docker run --rm -a STDOUT ${IMAGE_NAME} jupyterhub --version | tr -d '\r')"
docker tag $IMAGE_NAME "$BASE_NAME:${HUB_VERSION_TAG%%\r}"
CUDA_VERSION_TAG="cuda-$(docker run --rm -a STDOUT ${IMAGE_NAME} nvcc --version | grep "release" | awk '{print $6}' | cut -c2- | awk '{print $NF}'  | tr -d '\r' )"
docker tag $IMAGE_NAME "$BASE_NAME:${CUDA_VERSION_TAG%%\r}"
