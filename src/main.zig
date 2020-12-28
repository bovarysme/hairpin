const uart = @import("uart.zig").uart;

export const stack_size: u32 = 4096;

// In the standard RISC-V calling convention, the stack pointer is always kept
// 16-byte aligned
export var stack: [stack_size]u8 align(16) = undefined;

export fn start() noreturn {
    // Initialize the UART
    uart.init();
    const writer = uart.writer();
    try writer.print("Hello, {}!\n", .{"World"});

    while (true) {
        asm volatile ("wfi");
    }

    unreachable;
}
