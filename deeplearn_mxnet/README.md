# Starting up the container

instructions for latest docker:
`docker run --gpus all -d -it -p 8989:8888 -e JUPYTER_ENABLE_LAB=yes -v /home/brian/Workspace:/home/jovyan/work --ipc=host -v /media/brian/extra_14:/home/jovyan/work/external_data datadrone/deeplearn_mxnet:cuda-11.0`