AS = as86 -0 -a
LD = ld86 -0 -d
CC = bcc -0 -c

all: yee.img

yee.img: boot/boot kernel/sys
	dd if=/dev/zero of=yee.img bs=1M count=16
	dd if=boot/boot of=yee.img conv=notrunc
	dd if=kernel/sys of=yee.img conv=notrunc seek=1
#	dd if=sys of=yee.img conv=notrunc seek=1 ibs=32 skip=1
	
boot/boot: boot/boot.s
	cd boot	                &&\
	$(AS) boot.s -o boot.o  &&\
	$(LD) boot.o -o boot

kernel/sys: kernel/sys.c
	cd kernel               &&\
	$(CC) sys.c -o sys.o    &&\
	$(LD) sys.o -T 0x0000 -o sys
	
#sys: sys2.s
#	$(AS) sys2.s -o sys2.o
#	$(LD) -s sys2.o -o sys

clean:
	rm boot/boot.o boot/boot kernel/sys.o kernel/sys yee.img
