.PHONY: all clean phony_explicit

all: */

clean:
	find . -maxdepth 2 -type f -regex '.*.\(asm\|gb\|gbc\|ihx\|lk\|lst\|map\|noi\|rel\|sym\)' -delete

phony_explicit:

%/: phony_explicit
	$(MAKE) -C $@
