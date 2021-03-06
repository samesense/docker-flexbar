FROM ubuntu:14.04

RUN apt-get update \
    && apt-get install -y software-properties-common \
    tar \
    wget \
    xz-utils \
    curl \
    unzip \
    gcc \
    g++-4.9 \
    git \
    zlib1g-dev \
    libncurses5-dev \
    libncursesw5-dev \
    cmake \  
    build-essential \
    tabix \
    libtbb-dev \
    libbz2-dev

RUN add-apt-repository ppa:ubuntu-toolchain-r/test 
RUN apt-get update
RUN apt-get upgrade -y
RUN apt-get dist-upgrade -y

WORKDIR /opt

RUN ln -f -s /usr/bin/g++-4.9 /usr/bin/g++

RUN wget https://github.com/seqan/seqan/releases/download/seqan-v2.2.0/seqan-library-2.2.0.tar.xz
RUN wget https://github.com/seqan/flexbar/archive/v3.0.3.tar.gz
RUN tar -xzf v3.0.3.tar.gz
RUN tar -xJf seqan-library-2.2.0.tar.xz 
RUN mv seqan-library-2.2.0/include flexbar-3.0.3/
RUN cd flexbar-3.0.3/
RUN CC=gcc CXX=g++ cmake .
RUN make

export LD_LIBRARY_PATH=/opt/flexbar-3.0.3:$LD_LIBRARY_PATH
