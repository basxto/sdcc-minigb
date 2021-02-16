CPP=sdcpp
CPPFLAGS=
CC=sdcc
CFLAGS=-mgbz80 
AR=sdar
ARFLAGS=-rcSD
AS=sdasgb
ASFLAGS=

VPATH = ../src:../lib/include

.PHONY: build
build: ../lib/minigb.lib

../lib/minigb.lib: minigb.o
	$(AR) $(ARFLAGS) $@ $^

.PHONY: clean
clean:
	-$(RM) *.asm *.gb *.gbc *.ihx *.lk *.lst *.map *.noi *.o *.sym