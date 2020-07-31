fmt0: .asciz "%d"
fmt1: .asciz "input = "
fmt2: .asciz "output = %d\n"
fmt3: .asciz "error\n"
      .align 4
      .global main

main: save  %sp, -120, %sp
loop: set   fmt1, %o0
      call  printf
      nop
      set   fmt0, %o0
      add   %fp, -4, %o1
      call  scanf
      nop
      add   %fp, -4, %o0
      ld    [%o0], %l0     !첫번째수 %l0에저장
      cmp   %l0, %g0
      bl    exit_r          !첫번째수가음수면 종료
      nop
      set   fmt1, %o0
      call  printf
      nop
      set   fmt0, %o0
      add   %fp, -4, %o1
      call  scanf
      nop
      add    %fp, -4, %o0
      ld    [%o0], %l1       !두번째수 %l1에저장
      set   fmt1, %o0
      call  printf
      nop
      set   fmt0, %o0
      add   %fp, -4, %o1
      call  scanf
      nop
      add   %fp, -4, %o0
      ld    [%o0], %l2      !세번째수 %l2에저장
      call  loop2            !loop2로 이동
      nop
      mov   %o2, %l3        ! %o2를 %l3에 저장
      set   fmt2, %o0
      mov   %l3, %o1        !%l3를 %o1에 저장
      call  printf         ! output = %d
      nop
      ba    loop
      nop

loop2:mov   %l0, %o0     !첫번째수를 %o0
      mov   %l1, %o1     !두번째수를 %o1
      cmp   %l2, 1       !세번째수가 1이면 sub1함수로
      be    sub1
      nop
      cmp   %l2, 2       !세번째수가 2이면 sub2함수로
      be    sub2
      nop
      set   fmt3,%o0
      call   printf       !세번째수가 0 1아니면 에러프린트
      nop
      ba    loop
      nop
sub1: save  %sp, -96, %sp
sub1_r:subcc %i1, %i0, %g0    ! %i1이 %i0보다 작으면 종료   
       bl    exit_r
       nop
       mov   %i0, %o0    
       call  .mul
       mov   %i0, %o1          !첫번째입력수의 제곱
       add   %i2, %o0, %i2     !결과값 %i2에 누적
       inc   %i0               !첫번째수 +1
       ba    sub1_r
       nop
sub2: cmp %o1, %o0             ! %o1이 %o0보다 작으면 종료
      bl  exit_r2
      nop
      add %o2, %o0, %o2
      ba  sub2
      inc %o0

exit_r: ret
        restore
exit_r2:retl
        nop
