OUTPUT_ARCH(riscv)
ENTRY(_start)

SECTIONS {
    /* QEMU's virt machine loads the kernel from this address */
    . = 0x80000000;

    /* TODO: create a `.init` or `.text.init` section for the `_start` routine
     * and map it here to ensure it's always executed first */

    .text : {
        *(.text)
    }

    .rodata : {
        *(.rodata .rodata.*)
    }

    /* TODO: map the remaining sections */
}
