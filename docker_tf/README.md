# Notes

Dockerfile_cuda10_tf doesn't have pytorch
Dockerfile_torch_tf does

## Starting images:

docker run command
'docker run --gpus all -d -it -p 8890:8888 -e JUPYTER_ENABLE_LAB=yes -v /home/brian/Workspace:/home/jovyan/work --ipc=host -v /media/brian/extra_1:/home/jovyan/work/external_data datadrone/deeplearn_tf:torch_tf'