        .section ".data"
n:      .word 0
address:.skip 19*19*4
fmt0:   .asciz "%d"
fmt1:   .asciz "n input = "
fmt2:   .asciz "%d "
fmt3:   .asciz "\n"
fmt4:   .asciz "n: %d"
        .section ".text"
        .global main, printf, scanf
main:   save %sp, -96, %sp
start:  set fmt1, %o0
        call printf
        nop
        set fmt0, %o0      
        set n, %o1  
        call scanf            //n을입력
        nop
        set n, %l0            //n을 %l0에 저장  
        ld [%l0], %l0
        cmp %l0, 2  
        ble exit_r           // n<=2 이면종료
        nop
        cmp %l0, 20
        bge exit_r           // n>=20 이면종료
        nop
set:    set address, %l5
        mov 0, %l1
	mov %l0, %o0
	call .div
	mov 2, %o1
 	mov %o0, %l2                //%l0(n)를 2로 나눈 몫을 %l2에 저장
        mov 1, %l3
        sll %l2, 2, %o0         //%o0=%l2 * 4
        st %l3, [%l5 + %o0]
	ba loop_r
	nop
set_i:  subcc %l1, -1, %g0
        bne set_j
        nop
        sub %l0, 1, %l1
set_j:  subcc %l2, %l0, %g0
        bne sort
        nop
        mov 0, %l2
sort:   mov %l1, %o0
        call .mul
        mov %l0, %o1
        add %l3,1,%l3
        add %l2, %o0, %o0
        sll %o0, 2, %o0
        st %l3, [%l5 + %o0]
        mov %l0 ,%o0
        call .mul
        mov %o0, %o1
        subcc %l3, %o0, %g0
        bl loop_r
        nop
print:	set fmt4, %o0
        mov %l0, %o1
        call printf
        mov 0, %l1
        mov %l0, %o0
        call .mul
        mov %o0, %o1
        mov %o0, %l2
        mov -4, %l6
ta1:    set fmt3, %o0
        call printf
        mov 1, %l3
        subcc %l1, %l2, %g0
	bge start
       nop
ta2:    cmp %l3, %l0
        bg ta1
        nop
        add 4, %l6, %l6
        ld [%l5 + %l6], %o1
        set fmt2, %o0
        call printf
        inc %l1
        inc %l3
        ba ta2
        nop
loop_r: mov %l3, %o0
        call .rem
        mov %l0, %o1
        inc %l1
        subcc %o0, 0, %g0
        be set_i
        nop
        inc %l2
        sub %l1, 2, %l1
	ba set_i
	nop
exit_r:   ret
        restore

