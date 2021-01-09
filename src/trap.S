.global machine_trap_vector
machine_trap_vector:
	# TODO: save and restore registers
    csrrw sp, mscratch, sp
	csrr a0, mcause
	call machineTrapHandler

    csrrw sp, mscratch, sp
	mret
