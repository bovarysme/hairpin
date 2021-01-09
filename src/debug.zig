const uart = @import("uart.zig").uart;

pub fn print(comptime fmt: []const u8, args: anytype) void {
    const writer = uart.writer();
    writer.print(fmt, args) catch unreachable;
}

pub fn println(comptime fmt: []const u8, args: anytype) void {
    print(fmt ++ "\n", args);
}
