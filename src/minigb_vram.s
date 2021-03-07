; ASXXXX assembly
; Has to follow SDDC's calling convention
; For parts which have to be more Efficient

; extern void *vram_memcpy (void * dest, const void * src, size_t n);
_vram_memcpy::
  ldhl sp, #7
  ; n
  ld a, (hl-)
  ld b, a
  ld a, (hl-)
  ld c, a
  ; return if n==0
  or  a, b
  ret  Z
  ; src
  ld a, (hl-)
  ld d, a
  ld a, (hl-)
  ld e, a
  ; dest
  ld a, (hl-)
  ld l, (hl)
  ld h, a

  ; we quit when it becomes 0 ... 0x00 would become 0xF0!=0
  inc b
0$:
  ldh a, (0xFF41)
  ; if second bit is zero, it can be 0 or 1
  and a, #0x02
  jr NZ, 0$
  ld  a, (de)
  ; 24/6 cycles since test, but that's enough
  ; mode 2 is long enough
  ld  (hl+), a
  inc de
  dec c
  jr  NZ, 0$
  dec b
  jr  NZ, 0$
  ret


; extern void *vram_memset (void *s, int c, size_t n);

_vram_memset::
  ldhl sp, #7
  ; n
  ld a, (hl-)
  ld b, a
  ld a, (hl-)
  ld c, a
  ; return if n==0
  or  a, b
  ret  Z
  ; char
  dec hl
  ld a, (hl-)
  ld e, a
  ; dest
  ld a, (hl-)
  ld l, (hl)
  ld h, a

  ; busy mask for STAT
  ld  d, #0x02
  ; we quit when it _gets_ 0
  inc b
0$:
  ldh a, (0xFF41)
  and a, d
  jr NZ, 0$
  ld  a, e
  ld  (hl+), a
  dec c
  jr  NZ, 0$
  dec b
  jr  NZ, 0$
  ret


; extern char *vram_strcpynz (char * dest, const char * src);
_vram_strcpynz::
  ldhl sp, #2
  ; dest
  ld a, (hl+)
  ld e, a
  ld a, (hl+)
  ld d, a
  ; src
  ld a, (hl+)
  ld h, (hl)
  ld l, a
  ; b: second bit of STAT
  ; 0xFF41 STAT register
  ld bc, #0x0241
0$:
  ldh a, (c)
  and a, b
  jr NZ, 0$
  ld  a, (hl+)
  or  a
  jr  Z, .vram_strcpynz_zero
  ld  (de), a
  inc de
  jr  0$
.vram_strcpynz_zero:
  ; TODO: return something
  ret

; extern void *vram_regcpy (void * dest, const void * src, size_t n);
_vram_regcpy::
  ldhl sp, #7
  ; n
  ld a, (hl-)
  ld b, a
  ld a, (hl-)
  ld c, a
  ; return if n==0
  or  a, b
  ret  Z
  ldhl sp, #2
  ; src
  ld a, (hl+)
  ld e, a
  ld a, (hl+)
  ld d, a
  ; dest
  ld a, (hl+)
  ld h, (hl)
  ld l, a

  ; we quit when it becomes 0 ... 0x00 would become 0xF0!=0
  inc b
0$:
  ldh a, (0xFF41)
  ; if second bit is zero, it can be 0 or 1
  and a, #0x02
  jr NZ, 0$
  ld  a, (hl+)
  ; 24/6 cycles since test, but that's enough
  ; mode 2 is long enough
  ld  (de), a
  dec c
  jr  NZ, 0$
  dec b
  jr  NZ, 0$
  ret

; extern unsigned char *vram_regset (void * dest, unsigned char c);
_vram_regset::
  ldhl sp, #4
  ; c
  ld a, (hl-)
  ld e, a
  ; dest
  ld a, (hl-)
  ld l, (hl)
  ld h, a
  ; busy mask for STAT
  ld  d, #0x02
0$:
  ldh a, (0xFF41)
  and a, d
  jr NZ, 0$
  ld  (hl), e
  ret

; extern unsigned char *vram_regsetbits (void * dest, unsigned char c);
_vram_regsetbits::
  ldhl sp, #4
  ; c
  ld a, (hl-)
  ld e, a
  ; dest
  ld a, (hl-)
  ld l, (hl)
  ld h, a
  ; busy mask for STAT
  ld  d, #0x02
0$:
  ldh a, (0xFF41)
  and a, d
  jr NZ, 0$
  ld  a, e
  or  a, (hl)
  ld  (hl), a
  ld  e, a
  ret

; extern unsigned char *vram_regresbits (void * dest, unsigned char c);
_vram_regresbits::
  ldhl sp, #4
  ; c
  ld a, (hl-)
  cpl
  ld e, a
  ; dest
  ld a, (hl-)
  ld l, (hl)
  ld h, a
  ; busy mask for STAT
  ld  d, #0x02
0$:
  ldh a, (0xFF41)
  and a, d
  jr NZ, 0$
  ld  a, e
  and  a, (hl)
  ld  (hl), a
  ld  e, a
  ret