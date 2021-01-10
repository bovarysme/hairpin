//! This module provides an interface to the SiFive CLINT (Core Local Interrupt
//! Controller).

/// The time between timer interrupts in milliseconds.
pub const default_delta = 1000;

// 10 Mhz
const timebase_freq = 10_000_000;

const clint_base = 0x2000000;
const time_base = 0xbff8;
const timecmp_base = 0x4000;

pub fn getTime() usize {
    const ptr = @intToPtr(*volatile usize, clint_base + time_base);
    return ptr.*;
}

pub fn getTimecmp() usize {
    const ptr = @intToPtr(*volatile usize, clint_base + timecmp_base);
    return ptr.*;
}

pub fn setTimecmp(value: usize) void {
    // TODO: handle u64 values (privileged spec, page 32)
    const ptr = @intToPtr(*volatile usize, clint_base + timecmp_base);
    ptr.* = value;
}

/// Triggers a timer interrupt `delta` milliseconds from now.
pub fn setTimer(delta: usize) void {
    const now = getTime();
    const freq = timebase_freq / 1000;
    setTimecmp(now + delta * freq);
}
