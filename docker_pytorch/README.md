# Instructions

6006 is for tensorboard
ipc command is for pytorch
run with `docker run -d -it -p 8888:8888 -p 6006:6006 -p 8554:8554 -v /home/brian/Workspace:/home/jovyan/work --ipc=host --device=/dev/video0:/dev/video0 --device=/dev/video1:/dev/video1 datadrone/deeplearn_pytorch:cuda10.0_opencv4.0.0_tf`