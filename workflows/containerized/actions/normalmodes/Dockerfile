FROM debian:buster-slim

ENV DEBIAN_FRONTEND=noninteractive

RUN apt update && \
    apt install -y \
      curl git \
      build-essential gfortran cmake \
      libopenmpi-dev libopenblas-dev \
      libmetis-dev libscotchparmetis-dev && \
    rm -rf /var/lib/apt/lists/*

# Install Intel MKL
# https://software.intel.com/en-us/articles/installing-intel-free-libs-and-python-apt-repo
RUN curl -L https://apt.repos.intel.com/intel-gpg-keys/GPG-PUB-KEY-INTEL-SW-PRODUCTS-2019.PUB | apt-key add - && \
    sh -c 'echo deb https://apt.repos.intel.com/mkl all main > /etc/apt/sources.list.d/intel-mkl.list' && \
    apt-get update && apt-get install -y intel-mkl-2019.4-070 && \
    rm -rf /var/lib/apt/lists/*

