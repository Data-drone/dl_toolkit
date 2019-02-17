from datadrone/deeplearn_pytorch:cuda10.0_opencv4.0.0_tf

LABEL maintainer="Brian Law <bpl.law@gmail.com>"

USER root

RUN apt -y install libopenblas-base libomp-dev && \
    conda install -y -c pytorch faiss-gpu cuda100 && \
    conda install -y -c anaconda cudatoolkit && \
    conda install -y seaborn && \
    conda install -y -c nvidia/label/cuda10.0 -c rapidsai/label/cuda10.0 -c numba -c conda-forge -c defaults cudf && \
    conda install -y -c nvidia/label/cuda10.0 -c rapidsai/label/cuda10.0 -c conda-forge -c pytorch -c defaults cuml

WORKDIR $HOME

RUN git clone https://github.com/rapidsai/notebooks.git && \
    chown $NB_USER:users $HOME/notebooks


USER $NB_USER