FROM ubuntu:20.04

ARG QEMU_VERSION=5.2.0

RUN apt-get update \
    && apt-get install -y --no-install-recommends \
        build-essential \
        ca-certificates \
        device-tree-compiler \
        gdb-multiarch \
        libglib2.0-dev \
        libpixman-1-dev \
        ninja-build \
        pkg-config \
        python3 \
        wget \
    && rm -rf /var/lib/apt/lists/*

RUN wget https://download.qemu.org/qemu-${QEMU_VERSION}.tar.xz \
    && tar xJf qemu-${QEMU_VERSION}.tar.xz \
    && cd qemu-${QEMU_VERSION} \
    && ./configure --target-list=riscv32-softmmu,riscv64-softmmu \
    && make -j4 \
    && make install

RUN rm -rf qemu-${QEMU_VERSION} qemu-${QEMU_VERSION}.tar.xz

EXPOSE 1234

CMD ["/bin/bash"]
