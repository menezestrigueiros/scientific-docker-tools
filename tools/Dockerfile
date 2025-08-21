#ROOT Installation

# Use Ubuntu 22.04 as base image
FROM ubuntu:22.04

# Environment variables
ENV DEBIAN_FRONTEND=noninteractive

# Install dependencies
RUN apt-get update && apt-get install -y \
    wget \
    git \
    dpkg \
    lsb-release \
    python3 \
    python3-pip \
    g++ \
    cmake \
    make \
    libx11-dev \
    libxpm-dev \
    libxft-dev \
    libxext-dev \
    libtbb12 \
    && rm -rf /var/lib/apt/lists/*

# Install ROOT (binary install)
RUN wget https://root.cern/download/root_v6.36.02.Linux-ubuntu22.04-x86_64-gcc11.4.tar.gz && \
    tar -xvzf root_v6.36.02.Linux-ubuntu22.04-x86_64-gcc11.4.tar.gz && \
    mv root /opt/root && \
    rm root_v6.36.02.Linux-ubuntu22.04-x86_64-gcc11.4.tar.gz

# Set environment variables
ENV ROOTSYS=/opt/root
ENV PATH=$ROOTSYS/bin:$PATH
ENV LD_LIBRARY_PATH=$ROOTSYS/lib:$LD_LIBRARY_PATH
ENV PYTHONPATH=$ROOTSYS/lib:$PYTHONPATH

# Start with ROOT prompt
#CMD ["root"]

# GEANT4
ENV DEBIAN_FRONTEND=noninteractive

# Install dependencies
RUN apt-get update && apt-get install -y \
    build-essential \
    cmake \
    git \
    wget \
    libxerces-c-dev \
    libexpat1-dev \
    qtbase5-dev \
    libgl1-mesa-dev \
    mesa-utils \
    x11-apps \
    libx11-dev \
    libxmu-dev \
    libxi-dev \
    libglu1-mesa-dev \
    libglfw3-dev \
    && rm -rf /var/lib/apt/lists/*

# Geant4 version
ENV GEANT4_VERSION=11.3.2

#LINK
ENV LINK_DATASET=https://cern.ch/geant4-data/datasets

# Setup environment variables
ENV G4INSTALL=/opt/geant4-install
ENV G4WORKDIR=/opt/geant4-workdir
ENV PATH=$G4INSTALL/bin:$PATH
ENV LD_LIBRARY_PATH=$G4INSTALL/lib:$LD_LIBRARY_PATH

# Download Geant4 source
WORKDIR /opt
RUN wget https://cern.ch/geant4-data/releases/geant4-v${GEANT4_VERSION}.tar.gz && \
    tar -xzvf geant4-v${GEANT4_VERSION}.tar.gz && \
    rm geant4-v${GEANT4_VERSION}.tar.gz

# Build Geant4
WORKDIR /opt/geant4-v${GEANT4_VERSION}
RUN mkdir build && cd build && \
    cmake -DCMAKE_INSTALL_PREFIX=/opt/geant4-install -DGEANT4_USE_QT=ON -DGEANT4_INSTALL_DATA=ON .. && \
    make -j$(nproc) && make install

# Manually download essential Geant4 data sets
#RUN mkdir -p $G4INSTALL/share/Geant4-11.3.2/data && cd $G4INSTALL/share/Geant4-11.3.2/data && \
#    wget ${LINK_DATASET}/G4EMLOW.8.6.1.tar.gz && tar -xzvf G4EMLOW.8.6.1.tar.gz && rm G4EMLOW.8.6.1.tar.gz && \
#    wget ${LINK_DATASET}/G4PhotonEvaporation.6.1.tar.gz && tar -xzvf G4PhotonEvaporation.6.1.tar.gz && rm G4PhotonEvaporation.6.1.tar.gz && \
#    wget ${LINK_DATASET}/G4RadioactiveDecay.6.1.2.tar.gz && tar -xzvf G4RadioactiveDecay.6.1.2.tar.gz && rm G4RadioactiveDecay.6.1.2.tar.gz && \
#    wget ${LINK_DATASET}/G4SAIDDATA.2.0.tar.gz && tar -xzvf G4SAIDDATA.2.0.tar.gz && rm G4SAIDDATA.2.0.tar.gz && \
#    wget ${LINK_DATASET}/G4NDL.4.7.1.tar.gz && tar -xzvf G4NDL.4.7.1.tar.gz && rm G4NDL.4.7.1.tar.gz

# Set environment variables so Geant4 can find the data
ENV G4LEDATA=$G4INSTALL/share/Geant4/data/G4EMLOW8.6.1
ENV G4LEVELGAMMADATA=$G4INSTALL/share/Geant4/data/PhotonEvaporation6.1
ENV G4RADIOACTIVEDATA=$G4INSTALL/share/Geant4/data/RadioactiveDecay6.1.2
ENV G4SAIDXSDATA=$G4INSTALL/share/Geant4/data/G4SAIDDATA2.0
ENV G4NEUTRONHPDATA=$G4INSTALL/share/Geant4/data/G4NDL4.7.1
ENV G4ENSDFSTATEDATA=$G4INSTALL/share/Geant4/data/G4ENSDFSTATE3.0
ENV G4LEDATA=$G4INSTALL/share/Geant4/data/G4EMLOW8.6.1

# Create working directory
RUN mkdir -p $G4WORKDIR
WORKDIR $G4WORKDIR

#CMD ["bash"]

# Jupyterlab+hep

# Install system dependencies
RUN apt-get update && apt-get install -y \
    build-essential \
    git \
    pandoc \
    texlive-xetex \
    texlive-fonts-recommended \
    texlive-plain-generic \
    && rm -rf /var/lib/apt/lists/*

# Install JupyterLab and scientific Python stack
RUN pip install --no-cache-dir \
    jupyterlab \
    numpy \
    scipy \
    matplotlib \
    pandas \
    uproot \
    awkward \
    scikit-hep \
    ipywidgets \
    vector \
    hist \
    coffea \
    particle \
    hepunits

# Expose JupyterLab default port
EXPOSE 8888

#Without random authentication Tokens (Not Recomended)
#CMD ["jupyter", "lab", "--ip=0.0.0.0", "--port=8888", "--allow-root","--no-browser", "--NotebookApp.token=dockertoken"]

# Set workspace
VOLUME /workspace
WORKDIR /workspace

# Start JupyterLab by default
CMD ["jupyter", "lab", "--ip=0.0.0.0", "--no-browser", "--allow-root"]
