const io = @import("std").io;

/// Receiver Holding Register (R)
const register_rhr = 0;
/// Transmitter Holding Register (W)
const register_thr = 0;
/// Interrupt Enable Register (R/W)
const register_ier = 1;
/// Interrupt Status Register (R)
const register_isr = 2;
/// FIFO Control Register (W)
const register_fcr = 2;
/// Line Control Register (R/W)
const register_lcr = 3;
/// Modem Control Register (R/W)
const register_mcr = 4;
/// Line Status Register (R)
const register_lsr = 5;
/// Modem Status Register (R)
const register_msr = 6;
/// Scratch Pad Register (R/W)
const register_spr = 7;

/// Divisor Latch, LSB (R/W)
const register_dll = 0;
/// Divisor Latch, MSB (R/W)
const register_dlm = 1;
/// Prescaler Division (W)
const register_psd = 5;

const fcr_fifo_enable = 0x01;
const fcr_rx_fifo_reset = 0x02;
const fcr_tx_fifo_reset = 0x04;
const fcr_dma_mode = 0x08;
const fcr_enable_dma_end = 0x10;

const lcr_word_size_5bits = 0x00;
const lcr_word_size_6bits = 0x01;
const lcr_word_size_7bits = 0x02;
const lcr_word_size_8bits = 0x03;

const lsr_data_ready = 0x01;
const lsr_overrun_error = 0x02;
const lsr_parity_error = 0x04;
const lsr_framing_error = 0x08;
const lsr_break_interrupt = 0x10;
const lsr_thr_empty = 0x20;
const lsr_transmitter_empty = 0x40;
const lsr_fifo_data_error = 0x80;

const base = 0x10000000;
const ptr = @intToPtr([*]volatile u8, base);

fn set(register: u8, mask: u8) void {
    ptr[register] |= mask;
}

fn isSet(register: u8, mask: u8) bool {
    return ptr[register] & mask == mask;
}

// Singleton struct to make `std.io.Writer` happy
const Uart = struct {
    const Writer = io.Writer(Uart, error{}, write);

    pub fn init(self: Uart) void {
        // Enable FIFO
        set(register_fcr, fcr_fifo_enable);

        // Set the word length to 8 bits
        set(register_lcr, lcr_word_size_8bits);

        // TODO: set the baud rate, and check if other options need to be set
    }

    fn writeChar(self: Uart, char: u8) void {
        while (!isSet(register_lsr, lsr_thr_empty)) {}
        set(register_thr, char);
    }

    pub fn write(self: Uart, string: []const u8) !usize {
        for (string) |char| {
            self.writeChar(char);
        }

        return string.len;
    }

    pub fn writer(self: Uart) Writer {
        return .{ .context = self };
    }
};

pub const uart = Uart{};
