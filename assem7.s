.section ".data"
x: .word 0
y: .single 0r1.0
z: .single 0r999.0
w: .single 0r0.0
fmt1: .asciz "input= "
fmt2: .asciz "%g"
fmt3: .asciz "output = %g\n"

.section ".text"
.align 4
.global main, scanf, printf
main:   save %sp, -104, %sp
loop:   set fmt1, %o0
	call printf
	nop
	set fmt2, %o0
	set x, %o1           !input=x
	call scanf
	nop
	set x, %l0
	ld [%l0], %f1
	st %f1, [%fp-4]      !x to [%fp-8]
	set y, %l0
	ld [%l0], %f2        ! %f2=1.0
	set z, %l1 
	ld [%l1], %f3        ! %f3=999.0 
	set w, %l2
	ld [%l2], %f4
	fcmps %f1, %f2       ! input < 1.0 then loop
	nop
	fbl loop
	nop
	fcmps %f1, %f3       ! input = 999.0 then print
	nop
	fbe print
	nop
	fba add	             ! input>1.0 and input!=999.0 then add
	nop
print:
	set fmt3,%o0
	ld [%fp-8],%f4
	fstod %f4,%f6
	std %f6,[%fp-16]
	ldd [%fp-16], %o2
	mov %o2,%o1
    mov %o3,%o2
    call printf
	nop
	fba exit_r
add:
	ld[%fp-8],%f4
    fadds %f1, %f4, %f4   !%f4=%f4+%f1
	st %f4, [%fp-8]     !%f4 space [%fp-8]
	fba loop
	nop

exit_r:	ret
      	restore 
