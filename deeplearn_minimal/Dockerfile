ARG CUDA

FROM datadrone/deeplearn_base:$CUDA
#FROM datadrone/deeplearn_base:latest

LABEL maintainer="Brian Law <bpl.law@gmail.com>"

USER root

# Install all OS dependencies for fully functional notebook server
RUN apt-get update --yes && \
    apt-get install --yes --no-install-recommends \
    # Common useful utilities
    git \
    nano-tiny \
    tzdata \
    unzip \
    vim-tiny \
    # git-over-ssh
    openssh-client \
    # TODO: check if these are needed and describe
    inkscape \
    libsm6 \
    libxext-dev \
    libxrender1 \
    lmodern \
    netcat \
    # nbconvert dependencies
    # https://nbconvert.readthedocs.io/en/latest/install.html#installing-tex
    texlive-xetex \
    texlive-fonts-recommended \
    texlive-plain-generic && \
    apt-get clean && rm -rf /var/lib/apt/lists/*


WORKDIR $HOME

# Create alternative for nano -> nano-tiny
RUN update-alternatives --install /usr/bin/nano nano /bin/nano-tiny 10

# I think we need to run this as user to avoid site-packages under root
USER ${NB_UID}

# Activate some jupyter extensions
#RUN conda install -n base -c conda-forge jupyterlab_widgets
#RUN jupyter labextension install @jupyterlab/celltags
RUN pip install jupyterlab_nvdashboard

# Switch back to jovyan to avoid accidental container runs as root
USER ${NB_UID}
