const Builder = @import("std").build.Builder;

pub fn build(b: *Builder) void {
    const hairpin = b.addExecutable("hairpin", "src/main.zig");

    hairpin.addAssemblyFile("src/start.S");
    hairpin.setLinkerScriptPath("src/kernel.ld");
    hairpin.setTarget(.{
        .cpu_arch = .riscv32,
        .os_tag = .freestanding,
        .abi = .none,
    });

    hairpin.install();
}
