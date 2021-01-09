const uart = @import("uart.zig").uart;

export fn machineTrapHandler(cause: usize) void {
    const writer = uart.writer();
    // TODO: print an error message and halt on exceptions
    writer.print("mcause = 0x{x}\n", .{cause}) catch unreachable;

    // TODO: recover from interrupts
    while (true) {
        asm volatile ("wfi");
    }
}
