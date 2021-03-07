CPP=sdcpp
CPPFLAGS=
CC=sdcc
CFLAGS=-mgbz80 
AR=sdar
ARFLAGS=-rvcD
AS=sdasgb
ASFLAGS=
LIB=../lib/minigb.lib

VPATH = ../src:../pix:../lib/include

.PHONY: build
build: $(LIB)

# we just named them %.o so we can us them with implicit rules
%.rel: %.o
	cp $^ $@

%.2bpp: %.png
	rgbgfx -o $@ $^

%.c: %.2bpp
	echo "const unsigned char $*[] = {" > $@
	cat $^ | xxd -i >> $@
	echo "};" >> $@

$(LIB): minigb.o minigb_vram.o minigb_font.o
	$(AR) $(ARFLAGS) $@ $^

.PHONY: clean
clean:
	-$(RM) *.asm *.gb *.gbc *.ihx *.lk *.lst *.map *.noi *.o *.sym
	-$(RM) $(LIB)