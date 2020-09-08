
#!/bin/bash
set -e

IMAGE_NAME=$1
BASE_NAME=$2

CUDA_VERSION_TAG="cuda-$(docker run --rm -a STDOUT ${IMAGE_NAME} cat /usr/local/cuda/version.txt | awk '{print $NF}'  | tr -d '\r')"
docker tag $IMAGE_NAME "$BASE_NAME:${CUDA_VERSION_TAG%%\r}"
PYTORCH_TAG="pytorch-$(docker run --rm -a STDOUT ${IMAGE_NAME} python -c "import torch; print(torch.__version__)" | tr -d '\r')"
docker tag $IMAGE_NAME "$BASE_NAME:${PYTORCH_TAG%%\r}"
