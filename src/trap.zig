const debug = @import("debug.zig");

export fn machineTrapHandler(cause: usize) void {
    // TODO: print an error message and halt on exceptions
    debug.println("mcause = 0x{x}", .{cause});

    // TODO: recover from interrupts
    while (true) {
        asm volatile ("wfi");
    }
}
