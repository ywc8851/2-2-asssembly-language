fmt0: .asciz "%d"
fmt1: .asciz " array element is %d\n"
fmt2: .asciz " array input = "
fmt3: .asciz " n input = "
        .align 4
        .global main
main: save %sp, -160, %sp
loop:   set fmt3, %o0
        call printf
        nop
        set fmt0, %o0
        add %fp, -4, %o1
        call scanf
        nop
        ld [%o1], %l0
        cmp %l0, 2
        ble exit_r
        nop
        cmp %l0, 15
        bg exit
	mov -64, %l1
        mov 0, %l2
        mov %g0, %o2
        mov 0, %l3
loop_r: set fmt2, %o0
        call printf
        add %l1, %o2, %l3
        set fmt0, %o0
        add %fp, %l3, %o1
        call scanf
        inc %l2
        sll %l2, 2, %o2
        cmp %l2, %l0
        bl loop_r
        nop
        mov -64, %l1
        mov %g0, %l2
        mov 4, %o2
        mov 0, %o3
        mov 0, %l3
        mov 0, %l4
        sll %l0, 2, %l0
        sub %l0, 8, %l7
sort:   add %l1, %o2, %l3
        add %l1, %o3, %l4
        add %fp, %l3, %o1
        add %fp, %l4, %o4
        ld [%o1], %l5
        ld [%o4], %l6
        cmp %l6, %l5
        ble sort_r
        nop
        cmp %o2, %l7
        ble,a sort
        add %o2, 4, %o2
        add %o3, 4, %o3
        add %o3, 4, %o2
        cmp %o3, %l7
        ble sort
        nop
print:  ld [%fp-4], %l0
        mov 0, %l1
print_r:mov %l1, %o0
        call .mul
        mov 4, %o1
        add %o0, -64, %o0
        add %fp, %o0, %o0
        ld [%o0], %l2
        set fmt1, %o0
        mov %l2, %o1
        call printf
        nop
        inc %l1
        subcc %l0, %l1, %g0
        bg print_r
        nop
        ba loop
        nop
sort_r: mov %l5, %o5
        st %l6, [%o1]
        st %o5, [%o4]
        ba sort
        nop
exit_r: ret
        restore
