.section ".text" 
fmt2: .asciz "input=" !문자열 정의
fmt4: .asciz"%d"      !문자열 정의
      
      

	  .global main,scanf,printf
      .align 4
main: save %sp,-104,%sp
      mov %g0,%l7
loop: set fmt2,%o0   
      call printf    !화면에 출력 
	  nop

	  set fmt4,%o0
	  add %fp,-4,%o1 !키보드로부터 
	  call scanf     !읽어서 메모리 x위치에 저장
	  nop

	  ld [%fp-4],%l1  !메모리 x위치에 기억되어있는정보를 레지스터 %l1에복사 (이동) 
	  subcc %l1,0,%g0 !첫번째 수가 음수이면 종료
	  bl exit_r       !아니면 밑으로 
	  nop

	  set fmt2,%o0
	  call printf     !printf("input=");
	  nop

	  set fmt4,%o0
	  add %fp,-8,%o1
	  call scanf      !두번째 수 입력해서 저장 
	  nop

	  ld[%fp-8],%l2  !두번째 수를 레지스터%l2에 저장
	  
loop_r : subcc %l1,%l2,%g0
	     bg loop 
	     nop

		 add %l7,%l1,%l7
		 inc %l1
		 ba loop_r
		 nop
	  
	  ba loop   !레이블 loop으로 분기 
	  nop

exit_r:ret
       restore
