ARG CUDA

FROM datadrone/deeplearn_base:$CUDA
#FROM datadrone/deeplearn_base:latest

LABEL maintainer="Brian Law <bpl.law@gmail.com>"

USER root

# Install all OS dependencies for fully functional notebook server
RUN apt-get update && apt-get install -yq --no-install-recommends \
    build-essential \
    vim-tiny \
    git \
    inkscape \
    libsm6 \
    libxext-dev \
    libxrender1 \
    lmodern \
    netcat \
    openssh-client \
    # ---- nbconvert dependencies ----
    texlive-xetex \
    texlive-fonts-recommended \
    texlive-plain-generic \
    # ----
    tzdata \
    unzip \
    nano-tiny \
    && apt-get clean && rm -rf /var/lib/apt/lists/*


WORKDIR $HOME

# Create alternative for nano -> nano-tiny
RUN update-alternatives --install /usr/bin/nano nano /bin/nano-tiny 10

# Activate some jupyter extensions
RUN conda install -n base -c conda-forge jupyterlab_widgets
RUN jupyter labextension install @jupyterlab/celltags
RUN pip install jupyterlab_nvdashboard

# Switch back to jovyan to avoid accidental container runs as root
USER $NB_UID
