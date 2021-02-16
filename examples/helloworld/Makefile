CPP=sdcpp
CPPFLAGS=
CC=sdcc
CFLAGS=-mgbz80 
AR=sdar
ARFLAGS=
AS=sdasgb
ASFLAGS=
ROM=helloworld

.PHONY: build
build: $(ROM).gb

$(ROM).ihx: main.c ../../lib/minigb.lib
	$(CC) $(CFLAGS) -I../../lib/include/ --lib-path ../../lib/ -lminigb --verbose -o $@ $<

%.gb: %.ihx
	makebin -Z -yn "$*" -yS $< $@

../../lib/minigb.lib:
	$(MAKE) ../../build/ ../lib/minigb.lib

.PHONY: clean
clean: 
	$(RM) *.asm *.ihx *.lk *.lst *.map *.noi *.rel *.sym