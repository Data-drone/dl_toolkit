.PHONY: help

SHELL:=bash

ALL_IMAGES:=deeplearn_base \
		deeplearn_minimal 

OWNER:=datadrone

help: ### Help Text
	@echo 'This tries to help to compile all the docker files in the right order'

.DEFAULT_GOAL := help

# the current way that we build means that we aren't in the folder so need to change the copy command
# but the bash script does cd in...
# remove the bash scripts and go fully into using the make?
build/%:
	docker build -t $(OWNER)/$(notdir $@):latest ./$(notdir $@)

build-all: ## Build the Dockerfiles
	for folder in ${ALL_IMAGES}; do \
		echo "${OWNER}/$$folder"; \
		docker build -t ${OWNER}/$$folder:latest ./$$folder; \
	done

tag: ## Tag the Dockerfiles
	for folder in $(ALL_IMAGES); do \
		echo "$(OWNER)/$$folder"; \
		./$$folder/tag/tag_script.sh $(OWNER)/$$folder:latest $(OWNER)/$$folder; \
	done

push: ## Push the Dockerfiles in
	for folder in $(ALL_IMAGES); do \
		echo "$(OWNER)/$$folder"; \
		./$$folder/push/push_script.sh $(OWNER)/$$folder:latest $(OWNER)/$$folder; \
	done
