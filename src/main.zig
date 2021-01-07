const csr = @import("csr.zig");
const uart = @import("uart.zig").uart;

export const stack_size: u32 = 4096;

// In the standard RISC-V calling convention, the stack pointer is always kept
// 16-byte aligned
export var stack: [stack_size]u8 align(16) = undefined;

export fn start() noreturn {
    // Set the Machine Previous Privilege to S-mode
    csr.set("mstatus", csr.mstatus_mpp_s);

    // Set the Machine Exception Program Counter to the address of `main`
    csr.write("mepc", @ptrToInt(main));

    // Return to `main` in S-mode
    asm volatile ("mret");

    unreachable;
}

fn main() noreturn {
    // Initialize the UART
    uart.init();
    const writer = uart.writer();
    try writer.print("Hello from {}!\n", .{"S-mode"});

    while (true) {
        asm volatile ("wfi");
    }
}
