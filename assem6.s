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
      ld    [%o0], %l0     !ù��°�� %l0������
      cmp   %l0, %g0
      bl    exit_r          !ù��°���������� ����
      nop
      set   fmt1, %o0
      call  printf
      nop
      set   fmt0, %o0
      add   %fp, -4, %o1
      call  scanf
      nop
      add    %fp, -4, %o0
      ld    [%o0], %l1       !�ι�°�� %l1������
      set   fmt1, %o0
      call  printf
      nop
      set   fmt0, %o0
      add   %fp, -4, %o1
      call  scanf
      nop
      add   %fp, -4, %o0
      ld    [%o0], %l2      !����°�� %l2������
      call  loop2            !loop2�� �̵�
      nop
      mov   %o2, %l3        ! %o2�� %l3�� ����
      set   fmt2, %o0
      mov   %l3, %o1        !%l3�� %o1�� ����
      call  printf         ! output = %d
      nop
      ba    loop
      nop

loop2:mov   %l0, %o0     !ù��°���� %o0
      mov   %l1, %o1     !�ι�°���� %o1
      cmp   %l2, 1       !����°���� 1�̸� sub1�Լ���
      be    sub1
      nop
      cmp   %l2, 2       !����°���� 2�̸� sub2�Լ���
      be    sub2
      nop
      set   fmt3,%o0
      call   printf       !����°���� 0 1�ƴϸ� ��������Ʈ
      nop
      ba    loop
      nop
sub1: save  %sp, -96, %sp
sub1_r:subcc %i1, %i0, %g0    ! %i1�� %i0���� ������ ����   
       bl    exit_r
       nop
       mov   %i0, %o0    
       call  .mul
       mov   %i0, %o1          !ù��°�Է¼��� ����
       add   %i2, %o0, %i2     !����� %i2�� ����
       inc   %i0               !ù��°�� +1
       ba    sub1_r
       nop
sub2: cmp %o1, %o0             ! %o1�� %o0���� ������ ����
      bl  exit_r2
      nop
      add %o2, %o0, %o2
      ba  sub2
      inc %o0

exit_r: ret
        restore
exit_r2:retl
        nop
