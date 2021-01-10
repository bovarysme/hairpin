pub const mie_mtie = 1 << 7;
pub const mstatus_mpp_s = 1 << 11;

pub fn read(comptime name: []const u8) usize {
    return asm volatile ("csrr %[ret], " ++ name
        : [ret] "=r" (-> usize)
    );
}

pub fn write(comptime name: []const u8, value: usize) void {
    asm volatile ("csrw " ++ name ++ ", %[value]"
        :
        : [value] "r" (value)
    );
}

pub fn set(comptime name: []const u8, mask: usize) void {
    asm volatile ("csrs " ++ name ++ ", %[mask]"
        :
        : [mask] "r" (mask)
    );
}

pub fn clear(comptime name: []const u8, mask: usize) void {
    asm volatile ("csrc " ++ name ++ ", %[mask]"
        :
        : [mask] "r" (mask)
    );
}
