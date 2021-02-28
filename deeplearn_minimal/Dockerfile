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
    # ---- nbconvert dependencies ----
    texlive-xetex \
    texlive-fonts-recommended \
    texlive-plain-generic \
    # ----
    tzdata \
    unzip \
    nano-tiny \
    && apt-get clean && rm -rf /var/lib/apt/lists/*

# cmake needed for some c++ tools
ENV CMAKE_VERSION=3.19.5 \
    CMAKE_MAJOR=3.19

WORKDIR /opt/
RUN wget https://cmake.org/files/v${CMAKE_MAJOR}/cmake-${CMAKE_VERSION}-Linux-x86_64.sh && \
    chmod 755 cmake-${CMAKE_VERSION}-Linux-x86_64.sh && \
    mkdir /opt/cmake

RUN ./cmake-${CMAKE_VERSION}-Linux-x86_64.sh --skip-license --prefix=/opt/cmake

RUN ln -s /opt/cmake/bin/cmake /usr/local/bin/cmake && \
    rm cmake-${CMAKE_VERSION}-Linux-x86_64.sh

WORKDIR $HOME

# Switch back to jovyan to avoid accidental container runs as root
USER $NB_UID
