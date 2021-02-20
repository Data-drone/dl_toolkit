
#!/bin/bash
set -e

IMAGE_NAME=$1
BASE_NAME=$2

CUDA_VERSION_TAG="cuda-$(docker run --rm -a STDOUT ${IMAGE_NAME} nvcc --version | grep "release" | awk '{print $6}' | cut -c2- | awk '{print $NF}'  | tr -d '\r' )"
PYTORCH_TAG="pytorch-$(docker run --rm -a STDOUT ${IMAGE_NAME} python -c "import torch; print(torch.__version__)" | tr -d '\r')"

docker push "$IMAGE_NAME"
docker push "$BASE_NAME:${CUDA_VERSION_TAG%%\r}"
docker push "$BASE_NAME:${PYTORCH_TAG%%\r}"
