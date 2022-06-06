.PHONY: help

SHELL:=bash
# docker pull nvidia/cuda:11.1.1-cudnn8-devel
NVIDIA_LITE:=nvidia/cuda:11.3.1-base-ubuntu20.04
RUNTIME_NVIDIA_BASE:=nvidia/cuda:11.3.1-cudnn8-runtime-ubuntu20.04

# should rename NVIDIA base but need to keep for compatability for now
NVIDIA_BASE:=nvidia/cuda:11.3.1-cudnn8-devel-ubuntu20.04
CUDA_TARGET:=cuda-11.3

OWNER:=datadrone

help: ### Help Text
	@echo 'This tries to help to compile all the docker files in the right order'

.DEFAULT_GOAL := help

build-base:
	docker build --build-arg BASE_CONTAINER=$(NVIDIA_BASE) \
	 -t $(OWNER)/deeplearn_base:$(CUDA_TARGET) ./deeplearn_base

	docker build --build-arg BASE_CONTAINER=$(RUNTIME_NVIDIA_BASE) \
	 -t $(OWNER)/deeplearn_base:$(CUDA_TARGET)-runtime ./deeplearn_base

	docker build --build-arg BASE_CONTAINER=$(NVIDIA_LITE) \
	 -t $(OWNER)/deeplearn_base:$(CUDA_TARGET)-base ./deeplearn_base

	./deeplearn_base/tag/tag_script.sh \
	$(OWNER)/deeplearn_base:$(CUDA_TARGET) \
	$(OWNER)/deeplearn_base

# TEST_IMAGE=$(OWNER)/deeplearn_base:$(CUDA_TARGET) pytest -m "not info" --log-cli-level=INFO deeplearn_base/test
test-base:
	TEST_IMAGE=$(OWNER)/deeplearn_base:$(CUDA_TARGET) pytest -m "not info" --log-cli-level=INFO deeplearn_base/test
	
build-minimal:
	docker build --build-arg CUDA=$(CUDA_TARGET) \
	-t $(OWNER)/deeplearn_minimal:$(CUDA_TARGET) ./deeplearn_minimal

	docker build --build-arg CUDA=$(CUDA_TARGET)-runtime \
	-t $(OWNER)/deeplearn_minimal:$(CUDA_TARGET)-runtime ./deeplearn_minimal

	docker build --build-arg CUDA=$(CUDA_TARGET)-base \
	-t $(OWNER)/deeplearn_minimal:$(CUDA_TARGET)-base ./deeplearn_minimal

#	./deeplearn_minimal/tag/tag_script.sh \
	$(OWNER)/deeplearn_minimal:$(CUDA_TARGET) \
	$(OWNER)/deeplearn_minimal

test-minimal:
	TEST_IMAGE=$(OWNER)/deeplearn_minimal:$(CUDA_TARGET) pytest -m "not info" --log-cli-level=INFO deeplearn_minimal/test
	TEST_IMAGE=$(OWNER)/deeplearn_minimal:$(CUDA_TARGET)-runtime pytest -m "not info" --log-cli-level=INFO deeplearn_minimal/test
	TEST_IMAGE=$(OWNER)/deeplearn_minimal:$(CUDA_TARGET)-base pytest -m "not info" --log-cli-level=INFO deeplearn_minimal/test

build-opencv:	
# building the common base image
	docker build --build-arg CUDA=$(CUDA_TARGET) \
	-f deeplearn_opencv/Dockerfile_opencv_base \
	-t $(OWNER)/deeplearn_opencv_base:$(CUDA_TARGET) ./deeplearn_opencv

# building the runtime image
	docker build --build-arg CUDA=$(CUDA_TARGET)-runtime \
	-f deeplearn_opencv/Dockerfile_opencv_base \
	-t $(OWNER)/deeplearn_opencv_base:$(CUDA_TARGET)-runtime ./deeplearn_opencv

# building an opencv runtime  
	docker build --build-arg DEVEL_CUDA=$(CUDA_TARGET) \
	--build-arg RUNTIME_CUDA=$(CUDA_TARGET)-runtime \
	-f deeplearn_opencv/Dockerfile_runtime \
	-t $(OWNER)/deeplearn_opencv:$(CUDA_TARGET)-runtime ./deeplearn_opencv

# building an opencv devel image
	docker build --build-arg DEVEL_CUDA=$(CUDA_TARGET) \
	--build-arg RUNTIME_CUDA=$(CUDA_TARGET) \
	-f deeplearn_opencv/Dockerfile_runtime \
	-t $(OWNER)/deeplearn_opencv:$(CUDA_TARGET) ./deeplearn_opencv
	
	TEST_IMAGE=$(OWNER)/deeplearn_opencv:$(CUDA_TARGET) pytest -m "not info" --log-cli-level=INFO deeplearn_opencv/test
	TEST_IMAGE=$(OWNER)/deeplearn_opencv:$(CUDA_TARGET)-runtime pytest -m "not info" --log-cli-level=INFO deeplearn_opencv/test

build-opencv-slim:
# build a base image 
	docker build --build-arg CUDA=$(CUDA_TARGET)-base \
	-f deeplearn_opencv/Dockerfile_opencv_base \
	-t $(OWNER)/deeplearn_opencv_base:$(CUDA_TARGET)-base ./deeplearn_opencv

# leverage the previous devel image to compile for base
	docker build --build-arg DEVEL_CUDA=$(CUDA_TARGET) \
	--build-arg RUNTIME_CUDA=$(CUDA_TARGET)-base \
	-f deeplearn_opencv/Dockerfile_runtime \
	-t $(OWNER)/deeplearn_opencv:$(CUDA_TARGET)-base ./deeplearn_opencv


test-opencv:
	TEST_IMAGE=$(OWNER)/deeplearn_opencv:$(CUDA_TARGET) pytest -m "not info" --log-cli-level=INFO deeplearn_opencv/test
	TEST_IMAGE=$(OWNER)/deeplearn_opencv:$(CUDA_TARGET)-runtime pytest -m "not info" --log-cli-level=INFO deeplearn_opencv/test

compile-opencv:
	docker build --build-arg CUDA=$(CUDA_TARGET) \
	-f deeplearn_opencv/Dockerfile \
	-t $(OWNER)/deeplearn_opencv:$(CUDA_TARGET)-build ./deeplearn_opencv

# Build mxnet direct on opencv image
build-mxnet:
	docker build --build-arg CUDA=$(CUDA_TARGET) \
	--build-arg BASE_IMAGE=datadrone/deeplearn_opencv \
	-t $(OWNER)/deeplearn_mxnet_build:$(CUDA_TARGET) ./deeplearn_mxnet

test-mxnet:
	TEST_IMAGE=$(OWNER)/deeplearn_mxnet_build:$(CUDA_TARGET) \
	pytest -m "not info" --log-cli-level=INFO deeplearn_mxnet/test

build-pytorch:
	docker build --build-arg CUDA=$(CUDA_TARGET) \
	-f deeplearn_pytorch/Dockerfile \
	-t $(OWNER)/deeplearn_pytorch:$(CUDA_TARGET) ./deeplearn_pytorch

	docker build --build-arg CUDA=$(CUDA_TARGET)-runtime \
	-f deeplearn_pytorch/Dockerfile \
	-t $(OWNER)/deeplearn_pytorch:$(CUDA_TARGET)-runtime ./deeplearn_pytorch

tag-pytorch:
	./deeplearn_pytorch/tag/tag_script.sh \
	$(OWNER)/deeplearn_pytorch:$(CUDA_TARGET) \
	$(OWNER)/deeplearn_pytorch

	./deeplearn_pytorch/tag/tag_script.sh \
	$(OWNER)/deeplearn_pytorch:$(CUDA_TARGET)-runtime \
	$(OWNER)/deeplearn_pytorch

test-pytorch:
	TEST_IMAGE=$(OWNER)/deeplearn_pytorch:$(CUDA_TARGET) \
	pytest -m "not info" --log-cli-level=INFO deeplearn_pytorch/test
	
	TEST_IMAGE=$(OWNER)/deeplearn_pytorch:$(CUDA_TARGET)-runtime \
	pytest -m "not info" --log-cli-level=INFO deeplearn_pytorch/test
	
# we build tf into pytorch image as that is how we are usually using it
build-tf:
	docker build --build-arg CUDA=$(CUDA_TARGET) \
	--build-arg BASE_IMAGE=datadrone/deeplearn_opencv \
	-t $(OWNER)/deeplearn_tf:$(CUDA_TARGET) ./deeplearn_tf
	
	docker build --build-arg CUDA=$(CUDA_TARGET)-runtime \
	--build-arg BASE_IMAGE=datadrone/deeplearn_opencv \
	-t $(OWNER)/deeplearn_tf:$(CUDA_TARGET)-runtime ./deeplearn_tf

tag-tf:
	./deeplearn_tf/tag/tag_script.sh \
	$(OWNER)/deeplearn_tf:$(CUDA_TARGET) \
	$(OWNER)/deeplearn_tf

	./deeplearn_tf/tag/tag_script.sh \
	$(OWNER)/deeplearn_tf:$(CUDA_TARGET)-runtime \
	$(OWNER)/deeplearn_tf

test-tf:
	TEST_IMAGE=$(OWNER)/deeplearn_tf:$(CUDA_TARGET) pytest -m "not info" --log-cli-level=INFO deeplearn_tf/test
	TEST_IMAGE=$(OWNER)/deeplearn_tf:$(CUDA_TARGET)-runtime pytest -m "not info" --log-cli-level=INFO deeplearn_tf/test


compile-build-tf:
	docker build --build-arg CUDA=$(CUDA_TARGET) \
	-f deeplearn_tf/Dockerfile.build  \
	-t $(OWNER)/deeplearn_tf:latest ./deeplearn_pytorch

compile-pytorch:
	docker build --build-arg CUDA=$(CUDA_TARGET)-build \
	--build-arg BASE_IMAGE=datadrone/deeplearn_opencv \
	-f deeplearn_pytorch/Dockerfile.build  \
	-t $(OWNER)/deeplearn_pytorch:$(CUDA_TARGET)-build ./deeplearn_pytorch

	TEST_IMAGE=$(OWNER)/deeplearn_pytorch:$(CUDA_TARGET)-build \
	pytest -m "not info" --log-cli-level=INFO deeplearn_pytorch/test

build-lite-mxnet:
	docker build \
	-f basic_test/Dockerfile_mxnet_build  \
	-t $(OWNER)/deeplearn_mxnet:${CUDA_TARGET}-lite ./basic_test


# the current way that we build means that we aren't in the folder so need to change the copy command
# but the bash script does cd in...
# remove the bash scripts and go fully into using the make?

#build-mxnet:
#	docker build --build-arg CUDA=$(CUDA_TARGET) -t $(OWNER)/deeplearn_mxnet:$(CUDA_TARGET) ./deeplearn_mxnet



# original one
build-opencv-old: 
	docker build --build-arg CUDA=$(CUDA_TARGET) -t $(OWNER)/deeplearn_minimal:$(CUDA_TARGET) ./deeplearn_minimal
	docker build --build-arg CUDA=$(CUDA_TARGET) -t $(OWNER)/deeplearn_opencv:$(CUDA_TARGET) ./deeplearn_opencv

# the runtime one
# we need to work on the docker runtime as the cmake command is running the python install
# 


test/%:
	TEST_IMAGE=$(OWNER)/$(notdir $@):$(CUDA_TARGET) pytest -m "not info" --log-cli-level=INFO $(notdir $@)/test

#build/%:
#ifeq ($(notdir $@), deeplearn_base)
#	docker build --build-arg BASE_CONTAINER=$(NVIDIA_BASE) -t $(OWNER)/$(notdir $@):latest ./$(notdir $@) 
#else
#	echo $(notdir $@)
#	docker build -t $(OWNER)/$(notdir $@):latest ./$(notdir $@)
#endif


#build-all: ## Build the Dockerfiles
#	for folder in ${ALL_IMAGES}; do \
#		echo "${OWNER}/$$folder"; \
#		docker build -t ${OWNER}/$$folder:latest ./$$folder; \
#	done

#tag: ## Tag the Dockerfiles
#	for folder in $(ALL_IMAGES); do \
#		echo "$(OWNER)/$$folder"; \
#		./$$folder/tag/tag_script.sh $(OWNER)/$$folder:latest $(OWNER)/$$folder; \
#	done

tag/%:
	./$(notdir $@)/tag/tag_script.sh $(OWNER)/$(notdir $@):latest $(OWNER)/$(notdir $@);

push: ## Push the Dockerfiles in
	for folder in $(ALL_IMAGES); do \
		echo "$(OWNER)/$$folder"; \
		./$$folder/push/push_script.sh $(OWNER)/$$folder:latest $(OWNER)/$$folder; \
	done

push/%:
	./$(notdir $@)/push/push_script.sh $(OWNER)/$(notdir $@):latest $(OWNER)/$(notdir $@);

#test/%: ## run tests against a stack (only common tests or common tests + specific tests)
#	@if [ ! -d "$(notdir $@)/test" ]; then TEST_IMAGE="$(OWNER)/$(notdir $@)" pytest -m "not info" test; \
#	else TEST_IMAGE="$(OWNER)/$(notdir $@)" pytest -m "not info" test $(notdir $@)/test; fi