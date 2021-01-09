const csr = @import("csr.zig");
const uart = @import("uart.zig").uart;
// TODO: is there a cleaner way to do this? `index.zig` and `addPackagePath`?
usingnamespace @import("trap.zig");

export const stack_size: usize = 4096;

// In the standard RISC-V calling convention, the stack pointer is always kept
// 16-byte aligned
export var stack align(16) = [_]u8{0} ** stack_size;
// Stack used by the M-mode trap handler
export var machine_stack align(16) = [_]u8{0} ** stack_size;

extern fn machine_trap_vector() void;

export fn start() noreturn {
    csr.write("mscratch", @ptrToInt(&machine_stack) + stack_size);

    csr.write("mtvec", @ptrToInt(machine_trap_vector));

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
    writer.print("Hello from {}!\n", .{"S-mode"}) catch unreachable;

    // Raise an Illegal Instruction exception
    _ = csr.read("mstatus");

    while (true) {
        asm volatile ("wfi");
    }
}
