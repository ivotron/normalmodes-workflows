FROM debian:buster-slim

ENV DEBIAN_FRONTEND=noninteractive

RUN apt update && \
    apt install -y \
      curl git \
      build-essential gfortran cmake \
      libopenmpi-dev libopenblas-dev \
      libmetis-dev libscotchparmetis-dev && \
    rm -rf /var/lib/apt/lists/*

