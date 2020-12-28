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

- [xv6-riscv](https://github.com/mit-pdos/xv6-riscv)

## License

This project is licensed under the terms of the MIT license.
