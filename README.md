# hairpin

A hobby riscv32 OS written in Zig.

## Usage

Please don't... though if you must:

```
make docker-build  # Or bring your own QEMU
zig build
make docker-run
```

## Goals

- [ ] Timer interrupts
- [ ] Pre-emptive task scheduler with priorities
- [ ] UART RX
- [ ] Page allocator
- [ ] Virtual memory
- [ ] Syscalls (`ecall`)
  - [ ] `exit()`
  - [ ] `fork()`
  - [ ] `getpid()`
  - [ ] `get/setpriority()`
  - [ ] `kill()`
  - [ ] `read()`
  - [ ] `sleep()`
  - [ ] `wait()`
  - [ ] `write()`
- [ ] Userspace programs
  - [ ] Basic shell
  - [ ] Self-tests

## References

- [Volume 1, Unprivileged Spec v. 20191213](https://github.com/riscv/riscv-isa-manual/releases/download/Ratified-IMAFDQC/riscv-spec-20191213.pdf)
- [Volume 2, Privileged Spec v. 20190608](https://github.com/riscv/riscv-isa-manual/releases/download/Ratified-IMFDQC-and-Priv-v1.11/riscv-privileged-20190608.pdf)
- [xv6-riscv](https://github.com/mit-pdos/xv6-riscv)

## License

This project is licensed under the terms of the MIT license.
