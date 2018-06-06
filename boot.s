BOOT    = 0x07c0
INIT    = 0x8000
STACK   = 0x8000
SYS     = 0x2000
SYSLEN  = 1

entry _start
_start:
! Copy itself from BOOT to INIT
    mov ax, #BOOT
    mov ds, ax
    mov ax, #INIT
    mov es, ax
    mov cx, #256
    xor si, si
    xor di, di
    rep
    movw
! jmp to INIT
    jmpi go, INIT 
go:
! Set system stack
    mov ax, #STACK
    mov ss, ax
    xor si, si

! Load sys
load:
    mov ax, #0x0000             ! ah = 0x00 service reset
    mov dx, #0x0080             ! hd 0x80, head 0
    int 0x13                    ! Reset hd
    mov ax, #SYS
    mov es, ax
    xor bx, bx                  ! Read to es: bx
    mov ax, #0x0200 + SYSLEN    ! ah = 0x02 service read, al = read len
    mov dx, #0x0080             ! hd 0x80, head 0
    mov cx, #0x0002             ! cyd 0, sec 1
    int 0x13
    jnc success
    mov ah, #0x0e
    mov al, #0x46
    mov bx, #0x0007
    int 0x10
    jc load
success:
    mov ah, #0x0e
    mov al, #0x53
    mov bx, #0x0007
    int 0x10
! jmp to SYS
    mov ax, #SYS 
    mov ds, ax
    mov es, ax
    jmpi 0, SYS

.org 510
boot_flag:
    .word 0xAA55

