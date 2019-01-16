# Instructions

6006 is for tensorboard
ipc command is for pytorch
run with `docker run -d -it -p 8888:8888 -p 6006:6006 -v /home/brian/Workspace:/home/jovyan/work --ipc=host datadrone/deeplearn_pytorch:cuda10.0_opencv4.0.0_tf`