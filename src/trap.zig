const debug = @import("debug.zig");

const exceptions = [_][]const u8{
    "Instruction address misaligned",
    "Instruction access fault",
    "Illegal instruction",
    "Breakpoint",
    "Load address misaligned",
    "Load access fault",
    "Store/AMO address misaligned",
    "Store/AMO access fault",
    "Environment call from U-Mode",
    "Environment call from S-Mode",
    "Reserved",
    "Environment call from M-Mode",
    "Instruction page fault",
    "Load page fault",
    "Reserved",
    "Store/AMO page fault",
};

const modes = [_][]const u8{
    "U-mode",
    "S-mode",
    "Reserved",
    "M-mode",
};

const registers = [_][]const u8{
    "zero",
    "ra",
    "sp",
    "gp",
    "tp",
    "t0",
    "t1",
    "t2",
    "s0",
    "s1",
    "a0",
    "a1",
    "a2",
    "a3",
    "a4",
    "a5",
    "a6",
    "a7",
    "s2",
    "s3",
    "s4",
    "s5",
    "s6",
    "s7",
    "s8",
    "s9",
    "s10",
    "s11",
    "t3",
    "t4",
    "t5",
    "t6",
};

const interrupt_mask = 1 << 31;

const Frame = packed struct {
    registers: [32]usize,

    mepc: usize,
    mstatus: usize,
    mtval: usize,
};

export fn machineTrapHandler(cause: usize, frame: Frame) void {
    if (cause & interrupt_mask == interrupt_mask) {
        // TODO: handle interrupts
        return;
    }

    debug.println("\x1b[97;104m", .{});
    debug.println("{0} An exception has occurred :( {0}", .{"=" ** 16});

    // Print the exception name, code, and the privilege mode
    const name = if (cause < exceptions.len) exceptions[cause] else "Reserved";
    const mode = frame.mstatus >> 11 & 0b11;
    debug.println("{} (code: {}) from {}\n", .{ name, cause, modes[mode] });

    // Print registers
    debug.println("Registers:", .{});

    var i: usize = 0;
    while (i < registers.len) : (i += 1) {
        const sep = if (i % 4 == 3) "\n" else "  ";
        debug.print("{:<4} = 0x{x:<8}{}", .{ registers[i], frame.registers[i], sep });
    }

    debug.println("", .{});

    // Print CSRs
    debug.println("Control and Status Registers:", .{});
    debug.println("mepc    = 0x{x}", .{frame.mepc});
    debug.println("mstatus = 0x{x}", .{frame.mstatus});
    debug.print("mtval   = 0x{x}", .{frame.mtval});

    debug.println("\x1b[0m", .{});

    // Halt
    asm volatile ("1: j 1b");
}
