
#!/bin/bash
set -e

IMAGE_NAME=$1
BASE_NAME=$2

CUDA_VERSION_TAG="cuda-$(docker run --rm -a STDOUT ${IMAGE_NAME} nvcc --version | grep "release" | awk '{print $6}' | cut -c2- | awk '{print $NF}'  | tr -d '\r' )"
docker tag $IMAGE_NAME "$BASE_NAME:${CUDA_VERSION_TAG%%\r}"
PYTORCH_TAG="pytorch-$(docker run --rm -a STDOUT ${IMAGE_NAME} /opt/conda/envs/computer_vision/bin/python -c "import torch; print(torch.__version__.replace('+','-'))" | tr -d '\r')"
docker tag $IMAGE_NAME "$BASE_NAME:${PYTORCH_TAG%%\r}"
