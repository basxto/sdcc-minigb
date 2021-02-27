#ifndef LIB_MINIGB_H
#define LIB_MINIGB_H
#include <string.h>

// special functions which are vram safe

extern void *vram_memcpy (void * dest, const void * src, size_t n);
extern void *vram_memset (void *s, int c, size_t n);
// does not copy \0
extern char *vram_strcpynz (char * dest, const char * src);
// like vram_memcpy but with a constant destination
extern void *vram_regcpy (void * dest, const void * src, size_t n);
// sets register
// *dest = c
// returns new value of dest
extern unsigned char *vram_regset (void * dest, unsigned char c);
// sets bits of register
// *dest |= c
// returns new value of dest
extern unsigned char *vram_regsetbits (void * dest, unsigned char c);
// resets bits of register
// *dest &= ~c
// returns new value of dest
extern unsigned char *vram_regresbits (void * dest, unsigned char c);

extern const unsigned char minigb_font[];
#endif