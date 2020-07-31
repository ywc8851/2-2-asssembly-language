.section ".text"
fmt1: .asciz "==result==%x\n"
fmt2: .asciz "input="
fmt3: .asciz "n="
fmt4: .asciz "%d"
      .align 4
	  .global main,scanf,printf
main: save %sp,-104,%sp
      set fmt2,%o0
	  call printf      ! printf("input=");
	  nop
	  
	  set fmt4,%o0
	  add %fp,-4,%o1
	  call scanf       ! scanf("%d",&x);
	  nop

	  add %fp,-4,%o0
	  ld [%o0],%l0     !메모리x위치에 기억되어있는 정보를 %l0에 복사
	
	  nop

loop: set fmt3,%o0
      call printf      !printf("n=");
	  nop

	  set fmt4,%o0
	  add %fp,-8,%o1
	  call scanf       !두번째 수 입력하여 저장
	  nop

	  add %fp,-8,%o0
	  ld [%o0],%l2     !두번째 수를 레지스터 %l2에 저장
	  subcc %l2,0,%g0  !두번째수가 음수이면 exit_r 아니면 밑
	  bl exit_r
	  nop
      
	  mov 32,%l4
	  sub %l4,%l2,%l5
	  
	  
	  srl %l0,%l2,%l1    !오른쪽으로 n자리 이동
	  sll %l0,%l5,%l3    !왼쪽으로 (32-n)자리 이동
      add %l3,%l1,%l3
	  nop

	  set fmt1,%o0
	  mov %l3,%o1
	  call printf        !바뀐수 를 화면에 출력
	  nop                !printf("==result==%x\n",y);
	  
	  ba loop
	  nop

exit_r: ret
        restore
	  
