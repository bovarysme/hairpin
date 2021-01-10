.global machine_trap_vector
machine_trap_vector:
	csrrw sp, mscratch, sp
	addi sp, sp, -35*4

	# TODO: on interrupts, only save and restore caller-saved registers
	sw zero, 0*4(sp)
	sw ra, 1*4(sp)
	sw sp, 2*4(sp)
	sw gp, 3*4(sp)
	sw tp, 4*4(sp)
	sw t0, 5*4(sp)
	sw t1, 6*4(sp)
	sw t2, 7*4(sp)
	sw s0, 8*4(sp)
	sw s1, 9*4(sp)
	sw a0, 10*4(sp)
	sw a1, 11*4(sp)
	sw a2, 12*4(sp)
	sw a3, 13*4(sp)
	sw a4, 14*4(sp)
	sw a5, 15*4(sp)
	sw a6, 16*4(sp)
	sw a7, 17*4(sp)
	sw s2, 18*4(sp)
	sw s3, 19*4(sp)
	sw s4, 20*4(sp)
	sw s5, 21*4(sp)
	sw s6, 22*4(sp)
	sw s7, 23*4(sp)
	sw s8, 24*4(sp)
	sw s9, 25*4(sp)
	sw s10, 26*4(sp)
	sw s11, 27*4(sp)
	sw t3, 28*4(sp)
	sw t4, 29*4(sp)
	sw t5, 30*4(sp)
	sw t6, 31*4(sp)

	csrr t0, mepc
	sw t0, 32*4(sp)

	csrr t0, mstatus
	sw t0, 33*4(sp)

	csrr t0, mtval
	sw t0, 34*4(sp)

	csrr a0, mcause
	mv a1, sp
	call machineTrapHandler

	lw zero, 0*4(sp)
	lw ra, 1*4(sp)
	lw sp, 2*4(sp)
	lw gp, 3*4(sp)
	lw tp, 4*4(sp)
	lw t0, 5*4(sp)
	lw t1, 6*4(sp)
	lw t2, 7*4(sp)
	lw s0, 8*4(sp)
	lw s1, 9*4(sp)
	lw a0, 10*4(sp)
	lw a1, 11*4(sp)
	lw a2, 12*4(sp)
	lw a3, 13*4(sp)
	lw a4, 14*4(sp)
	lw a5, 15*4(sp)
	lw a6, 16*4(sp)
	lw a7, 17*4(sp)
	lw s2, 18*4(sp)
	lw s3, 19*4(sp)
	lw s4, 20*4(sp)
	lw s5, 21*4(sp)
	lw s6, 22*4(sp)
	lw s7, 23*4(sp)
	lw s8, 24*4(sp)
	lw s9, 25*4(sp)
	lw s10, 26*4(sp)
	lw s11, 27*4(sp)
	lw t3, 28*4(sp)
	lw t4, 29*4(sp)
	lw t5, 30*4(sp)
	lw t6, 31*4(sp)

	addi sp, sp, 35*4
	csrrw sp, mscratch, sp
	mret
