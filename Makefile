AS = as86 -0 -a
LD = ld86 -0
CC = bcc -0

all: yee.img

yee.img: boot sys
	dd if=/dev/zero of=yee.img bs=1M count=16
	dd if=boot of=yee.img conv=notrunc ibs=32 skip=1
	dd if=sys of=yee.img conv=notrunc seek=1
#	dd if=sys of=yee.img conv=notrunc seek=1 ibs=32 skip=1
	
boot: boot.s
	$(AS) boot.s -o boot.o
	$(LD) -s boot.o -o boot

sys: sys.c
#	$(CC) sys.c -o sys
	$(CC) -c -0 sys.c -o sys.o -x
	$(LD) sys.o -d -M -m -T 0x0000 -o sys
	
#sys: sys2.s
#	$(AS) sys2.s -o sys2.o
#	$(LD) -s sys2.o -o sys

clean:
	rm boot.o boot sys.o sys yee.img
