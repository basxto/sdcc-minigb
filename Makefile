.PHONY: all clean phony_explicit
all:
	$(MAKE) -C build/
	$(MAKE) -C examples/

clean:
	$(MAKE) -C build/ clean
	$(MAKE) -C examples/ clean

phony_explicit:

build/%: phony_explicit
	$(MAKE) -C build/ $*

lib/%: phony_explicit
	$(MAKE) -C build/ ../$@

examples/%: phony_explicit
	$(MAKE) -C examples/ $*