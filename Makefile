DOCKER_IMAGE=qemu-system-riscv
DOCKER_VOLUME=$(PWD)
DOCKER_WORKDIR=/hairpin
DOCKER_ARGS=-it \
	--rm \
	-v ${DOCKER_VOLUME}:${DOCKER_WORKDIR} \
	-w ${DOCKER_WORKDIR} \
	${DOCKER_IMAGE}

GDB_CMD=gdb-multiarch zig-cache/bin/hairpin

QEMU_CMD=qemu-system-riscv32 \
	-machine virt \
	-bios none \
	-kernel zig-cache/bin/hairpin \
	-nographic

.PHONY: docker-build docker-debug docker-run

docker-build:
	docker build --tag ${DOCKER_IMAGE} .

docker-debug:
	docker run ${DOCKER_ARGS} ${GDB_CMD}

docker-run:
	docker run ${DOCKER_ARGS} ${QEMU_CMD}
