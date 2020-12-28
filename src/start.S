.global _start
_start:
	# TODO: set up one stack per hart
	la sp, stack
	la a0, stack_size
	lw a0, 0(a0)
	add sp, sp, a0
	call start
