FROM nvidia/cuda:11.0.3-runtime-ubuntu18.04

ARG workdir
ENV DEBIAN_FRONTEND=noninteractive
ENV PYTHONUNBUFFERED=1

RUN apt-get update && apt-get install -y \
    build-essential \
    ca-certificates \
    libssl-dev \
    zlib1g-dev \
    libbz2-dev \
    libreadline-dev \
    libsqlite3-dev \
    libncurses5-dev \
    libncursesw5-dev \
    libffi-dev \
    liblzma-dev \
    libtk8.5 \
    libgdm-dev \
    libdb4o-cil-dev \
    libpcap-dev \
    cmake \
    llvm \
    xz-utils \
    tk-dev \
    vim \
    ssh \
    wget \
    curl \
    git \
    python3.8 \
    python3-pip \
    python3-setuptools \
    python3-dev \
    && apt clean \
    && rm -rf /var/lib/apt/lists/*

RUN pip3 install --upgrade pip \
    && pip install torch==1.7.1+cu110 \
    torchvision==0.8.2+cu110 \
    torchaudio==0.7.2 \
    -f https://download.pytorch.org/whl/torch_stable.html

COPY requirements.txt ./
RUN pip install -r requirements.txt

ARG ssh_docker
RUN mkdir $ssh_docker

RUN curl -fsSL https://deb.nodesource.com/setup_15.x | bash - \
    && apt-get install -y nodejs \
    && mkdir /root/.cache/black/20.8b1 -p

WORKDIR $workdir
