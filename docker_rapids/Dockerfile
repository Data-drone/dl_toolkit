from datadrone/deeplearn_minimal:latest

LABEL maintainer="Brian Law <bpl.law@gmail.com>"

USER root

RUN conda install -c rapidsai -c nvidia -c conda-forge \
    -c defaults rapids

WORKDIR $HOME

RUN git clone https://github.com/rapidsai/notebooks.git && \
    chown $NB_USER:users $HOME/notebooks


USER $NB_USER