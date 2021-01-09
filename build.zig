const std = @import("std");
const Builder = std.build.Builder;
const fs = std.fs;

pub fn build(b: *Builder) void {
    const hairpin = b.addExecutable("hairpin", "src/main.zig");

    const assembly_files = [_][]const u8{ "start.S", "trap.S" };
    for (assembly_files) |file| {
        const path = fs.path.join(
            b.allocator,
            &[_][]const u8{ "src", file },
        ) catch unreachable;
        hairpin.addAssemblyFile(path);
    }

    hairpin.setLinkerScriptPath("src/kernel.ld");
    hairpin.setTarget(.{
        .cpu_arch = .riscv32,
        .os_tag = .freestanding,
        .abi = .none,
    });

    hairpin.install();
}
