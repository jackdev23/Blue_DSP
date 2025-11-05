; ..............................................................................
;    File   f450_950cw.s
; ..............................................................................

		.equ f450_950cwNumTaps, 128

; ..............................................................................
; Allocate and initialize filter taps

		.section .f450_950cwconst, code
		.align 256

f450_950cwTaps:
.hword 0x0004
.hword 0x0003
.hword 0x000B
.hword 0x0008
.hword 0xFFF7
.hword 0xFFDB
.hword 0xFFBC
.hword 0xFFAB
.hword 0xFFB9
.hword 0xFFEF
.hword 0x0047
.hword 0x00A4
.hword 0x00DF
.hword 0x00D7
.hword 0x0082
.hword 0xFFF5
.hword 0xFF65
.hword 0xFF08
.hword 0xFF02
.hword 0xFF4E
.hword 0xFFC0
.hword 0x001A
.hword 0x0030
.hword 0x0000
.hword 0xFFB7
.hword 0xFF97
.hword 0xFFD3
.hword 0x0069
.hword 0x011E
.hword 0x0198
.hword 0x018E
.hword 0x00F6
.hword 0x0010
.hword 0xFF48
.hword 0xFEF8
.hword 0xFF35
.hword 0xFFBD
.hword 0x0019
.hword 0xFFE7
.hword 0xFF19
.hword 0xFE0F
.hword 0xFD6B
.hword 0xFDB8
.hword 0xFF10
.hword 0x00FE
.hword 0x02B0
.hword 0x0360
.hword 0x02CC
.hword 0x0168
.hword 0x0027
.hword 0xFFF4
.hword 0x0119
.hword 0x02F1
.hword 0x041F
.hword 0x033B
.hword 0xFFAA
.hword 0xFA2C
.hword 0xF4C8
.hword 0xF201
.hword 0xF3B7
.hword 0xFA22
.hword 0x0382
.hword 0x0CB0
.hword 0x1256
.hword 0x1256
.hword 0x0CB0
.hword 0x0382
.hword 0xFA22
.hword 0xF3B7
.hword 0xF201
.hword 0xF4C8
.hword 0xFA2C
.hword 0xFFAA
.hword 0x033B
.hword 0x041F
.hword 0x02F1
.hword 0x0119
.hword 0xFFF4
.hword 0x0027
.hword 0x0168
.hword 0x02CC
.hword 0x0360
.hword 0x02B0
.hword 0x00FE
.hword 0xFF10
.hword 0xFDB8
.hword 0xFD6B
.hword 0xFE0F
.hword 0xFF19
.hword 0xFFE7
.hword 0x0019
.hword 0xFFBD
.hword 0xFF35
.hword 0xFEF8
.hword 0xFF48
.hword 0x0010
.hword 0x00F6
.hword 0x018E
.hword 0x0198
.hword 0x011E
.hword 0x0069
.hword 0xFFD3
.hword 0xFF97
.hword 0xFFB7
.hword 0x0000
.hword 0x0030
.hword 0x001A
.hword 0xFFC0
.hword 0xFF4E
.hword 0xFF02
.hword 0xFF08
.hword 0xFF65
.hword 0xFFF5
.hword 0x0082
.hword 0x00D7
.hword 0x00DF
.hword 0x00A4
.hword 0x0047
.hword 0xFFEF
.hword 0xFFB9
.hword 0xFFAB
.hword 0xFFBC
.hword 0xFFDB
.hword 0xFFF7
.hword 0x0008
.hword 0x000B
.hword 0x0003
.hword 0x0004

; ..............................................................................
; Allocate delay line in (uninitialized) Y data space

		.section .ybss,bss,ymemory
		.align 256

f450_950cwDelay:
		.space f450_950cwNumTaps*2

; ..............................................................................
; Allocate and intialize filter structure

		.section .data
		.global _f450_950cwFilter

_f450_950cwFilter:
.hword f450_950cwNumTaps
.hword psvoffset(f450_950cwTaps)
.hword psvoffset(f450_950cwTaps)+f450_950cwNumTaps*2-1
.hword psvpage(f450_950cwTaps)
.hword f450_950cwDelay
.hword f450_950cwDelay+f450_950cwNumTaps*2-1
.hword f450_950cwDelay

; ..............................................................................
; ..............................................................................
; Sample assembly language calling program
;  The following declarations can be cut and pasted as needed into a program
;		.extern	_FIRFilterInit
;		.extern	_BlockFIRFilter
;		.extern	_f450_950cwFilter
;
;		.section	.bss
;
;	 The input and output buffers can be made any desired size
;	   the value 40 is just an example - however, one must ensure
;	   that the output buffer is at least as long as the number of samples
;	   to be filtered (parameter 4)
;input:		.space	40
;output:	.space	40
;		.text
;
;
;  This code can be copied and pasted as needed into a program
;
;
; Set up pointers to access input samples, filter taps, delay line and
; output samples.
;		mov	#_f450_950cwFilter, W0	; Initalize W0 to filter structure
;		call	_FIRFilterInit	; call this function once
;
; The next 4 instructions are required prior to each subroutine call
; to _BlockFIRFilter
;		mov	#_f450_950cwFilter, W0	; Initalize W0 to filter structure
;		mov	#input, W1	; Initalize W1 to input buffer 
;		mov	#output, W2	; Initalize W2 to output buffer
;		mov	#20, W3	; Initialize W3 with number of required output samples
;		call	_BlockFIRFilter	; call as many times as needed
