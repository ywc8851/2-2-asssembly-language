.section ".text" 
fmt1: .asciz "input="
fmt2: .asciz "output=prime number\n"
fmt3: .asciz "output=non-prime number(%d)\n"
fmt4: .asciz "%d"
      .align 4
	  .global main,scanf,printf

main: save %sp,-104,%sp
      
loop: mov 0,%l2       !i=0;
      mov 1,%l4       !k=1;
      set fmt1,%o0     
	  call printf
	  nop             !printf("input=");

	  set fmt4,%o0    !fmt4형식으로 저장 
	  add %fp,-4,%o1  !키보드로부터 읽어서 메모리x위치에 저장 
	  call scanf  
	  nop             !scanf("%d",&x);  
	  add %fp,-4,%o0
	  ld [%o0],%l0    !레지스터 %l0에복사 
      
	  subcc %l0,1,%g0 !입력된 수가 1보다 작거나 같으면 exit로 
	  ble exit        !아니면 밑으로 
	  nop

	  mov %l0,%o0
	  mov 2,%o1
	  call .div       ! x/2
	  nop
	  mov %o0,%l1     ! x/2를 %l1에 저장
	  bn loop_r
	  nop
loop_r: inc %l2       ! i++
        subcc %l2,%l1,%g0  !i가 x/2보다 작거나같으면 진행 아니면 print
        bg print
		nop

        mov %l0,%o0
		mov %l2,%o1
        call .rem          !x/i 의 나머지값 구하기 
        nop
		mov %o0,%l3        !그 나머지를 %l3에 저장 

        cmp %l3,%g0        !if((x\i)==0)
		bne loop_r    
		nop
        
		mov %l4,%o0        ! %l4는 k의값을 갖고있음 
		mov %l2,%o1
		call .mul          ! k= k*i의 값을 저장(%o0에)
		nop
		mov %o0,%l4        ! k=k*i을 %l4에 저장 
		ba loop_r
        nop
print: cmp %l4,1            ! if(k>1) 이면 소수가 아님 
      bg print_2
      nop                  
      set fmt2,%o0         ! k<=1이면 소수임
	  call printf          ! 소수임  출력 
	  nop                  
      ba loop
	  nop
print_2:set fmt3,%o0       ! k>1이면 소수가 아님 
      mov %l4,%o1          
      call printf          ! 소수가 아님을 출력
	  nop
	  ba loop
	  nop

exit: ret
      restore
