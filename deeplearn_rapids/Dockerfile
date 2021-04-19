from datadrone/deeplearn_pytorch:cuda-11.1

LABEL maintainer="Brian Law <bpl.law@gmail.com>"

USER root 

RUN conda create --name rapids -c rapidsai -c nvidia -c conda-forge \
    -c defaults python=3.8 rapids-blazing=0.18 cudatoolkit=11.0

# for Jupyter 3
RUN pip install dask-labextension

USER $NB_USER

WORKDIR $HOME

#RUN git clone https://github.com/rapidsai/notebooks.git && \
#    chown $NB_USER:users $HOME/notebooks
