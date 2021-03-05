.PHONY: help

SHELL:=bash
# docker pull nvidia/cuda:11.1.1-cudnn8-devel
NVIDIA_BASE:=nvidia/cuda:11.1.1-cudnn8-devel
CUDA_TARGET:=cuda-11.1

OWNER:=datadrone

help: ### Help Text
	@echo 'This tries to help to compile all the docker files in the right order'

.DEFAULT_GOAL := help

# the current way that we build means that we aren't in the folder so need to change the copy command
# but the bash script does cd in...
# remove the bash scripts and go fully into using the make?

build-mxnet:
	docker build --build-arg CUDA=$(CUDA_TARGET) -t $(OWNER)/deeplearn_mxnet:latest ./deeplearn_mxnet

build-tf:
	docker build --build-arg CUDA=$(CUDA_TARGET) -t $(OWNER)/deeplearn_tf:latest ./deeplearn_tf

build-tf-compile:
	docker build --build-arg CUDA=$(CUDA_TARGET) -f deeplearn_tf/Dockerfile.build  -t $(OWNER)/deeplearn_tf:latest ./deeplearn_pytorch

build-pytorch:
	docker build --build-arg CUDA=$(CUDA_TARGET) -t $(OWNER)/deeplearn_pytorch:latest ./deeplearn_pytorch

build-pytorch-compile:
	docker build --build-arg CUDA=$(CUDA_TARGET) -f deeplearn_pytorch/Dockerfile.build  -t $(OWNER)/deeplearn_pytorch:latest ./deeplearn_pytorch

build-opencv: 
	docker build --build-arg CUDA=$(CUDA_TARGET) -t $(OWNER)/deeplearn_minimal:latest ./deeplearn_minimal
	docker build --build-arg CUDA=$(CUDA_TARGET) -t $(OWNER)/deeplearn_opencv:latest ./deeplearn_opencv

build-base:
	docker build --build-arg BASE_CONTAINER=$(NVIDIA_BASE) -t $(OWNER)/deeplearn_base:cuda-11.1 ./deeplearn_base


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