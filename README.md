# DL Toolkit

Some docker containers for experimenting with deep learning. 

# Deeplearn Base

This is the jupyter docker base build but on top of nvidia docker instead to enable GPU functionality. Also with added nbdev and debugger components

see: https://github.com/jupyter/docker-stacks/tree/master/base-notebook
https://hub.docker.com/repository/docker/datadrone/deeplearn_base


# Deeplearn Minimal

This is the jupyter docker minimal build on top of the base

see: https://github.com/jupyter/docker-stacks/tree/master/minimal-notebook
https://hub.docker.com/repository/docker/datadrone/deeplearn_minimal


# Deeplearn Opencv

This is Minimal + OpenCV
https://hub.docker.com/repository/docker/datadrone/deeplearn_opencv

Current compiled with opencv 4.4.0  with Compute Model 7.5

# Deeplearn Pytorch

This is docker OpenCV plus pytorch 1.6

# Deeplearn TF

This is docker OpenCV plus TensorFlow 2.x

# Docker Rapids

This adds in the Nvidia RAPIDS ai libraries
- Discontinued for now issues with conda configs and solver issues and Nvidia's official one works okay now