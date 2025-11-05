; ..............................................................................
;    File   f300_2400.s
; ..............................................................................

		.equ f300_2400NumTaps, 128

; ..............................................................................
; Allocate and initialize filter taps

		.section .f300_2400const, code
		.align 256

f300_2400Taps:
.hword 0xFFD5
.hword 0xFFD2
.hword 0x0049
.hword 0x004B
.hword 0xFF21
.hword 0xFE96
.hword 0x0004
.hword 0x0133
.hword 0x009E
.hword 0x0051
.hword 0x00E9
.hword 0x008B
.hword 0xFFDE
.hword 0x005E
.hword 0x007B
.hword 0xFFB1
.hword 0xFFEC
.hword 0x0061
.hword 0xFF93
.hword 0xFF64
.hword 0x0020
.hword 0xFF8A
.hword 0xFEEB
.hword 0xFFCB
.hword 0xFFAF
.hword 0xFEB1
.hword 0xFF7A
.hword 0x000B
.hword 0xFEE2
.hword 0xFF4B
.hword 0x0090
.hword 0xFF91
.hword 0xFF53
.hword 0x011D
.hword 0x00A5
.hword 0xFF95
.hword 0x0176
.hword 0x01DC
.hword 0x0003
.hword 0x015F
.hword 0x02D2
.hword 0x007C
.hword 0x00A8
.hword 0x0315
.hword 0x00D8
.hword 0xFF43
.hword 0x0249
.hword 0x00F7
.hword 0xFD59
.hword 0x003C
.hword 0x00CB
.hword 0xFB4D
.hword 0xFCF0
.hword 0x005C
.hword 0xF9C1
.hword 0xF886
.hword 0xFFCD
.hword 0xF9B2
.hword 0xF2CE
.hword 0xFF48
.hword 0xFDAF
.hword 0xE822
.hword 0xFEF9
.hword 0x3AD7
.hword 0x3AD7
.hword 0xFEF9
.hword 0xE822
.hword 0xFDAF
.hword 0xFF48
.hword 0xF2CE
.hword 0xF9B2
.hword 0xFFCD
.hword 0xF886
.hword 0xF9C1
.hword 0x005C
.hword 0xFCF0
.hword 0xFB4D
.hword 0x00CB
.hword 0x003C
.hword 0xFD59
.hword 0x00F7
.hword 0x0249
.hword 0xFF43
.hword 0x00D8
.hword 0x0315
.hword 0x00A8
.hword 0x007C
.hword 0x02D2
.hword 0x015F
.hword 0x0003
.hword 0x01DC
.hword 0x0176
.hword 0xFF95
.hword 0x00A5
.hword 0x011D
.hword 0xFF53
.hword 0xFF91
.hword 0x0090
.hword 0xFF4B
.hword 0xFEE2
.hword 0x000B
.hword 0xFF7A
.hword 0xFEB1
.hword 0xFFAF
.hword 0xFFCB
.hword 0xFEEB
.hword 0xFF8A
.hword 0x0020
.hword 0xFF64
.hword 0xFF93
.hword 0x0061
.hword 0xFFEC
.hword 0xFFB1
.hword 0x007B
.hword 0x005E
.hword 0xFFDE
.hword 0x008B
.hword 0x00E9
.hword 0x0051
.hword 0x009E
.hword 0x0133
.hword 0x0004
.hword 0xFE96
.hword 0xFF21
.hword 0x004B
.hword 0x0049
.hword 0xFFD2
.hword 0xFFD5


; ..............................................................................
; Allocate delay line in (uninitialized) Y data space

		.section .ybss,bss,ymemory
		.align 256

f300_2400Delay:
		.space f300_2400NumTaps*2

; ..............................................................................
; Allocate and intialize filter structure

		.section .data
		.global _f300_2400Filter

_f300_2400Filter:
.hword f300_2400NumTaps
.hword psvoffset(f300_2400Taps)
.hword psvoffset(f300_2400Taps)+f300_2400NumTaps*2-1
.hword psvpage(f300_2400Taps)
.hword f300_2400Delay
.hword f300_2400Delay+f300_2400NumTaps*2-1
.hword f300_2400Delay

; ..............................................................................
; ..............................................................................
; Sample assembly language calling program
;  The following declarations can be cut and pasted as needed into a program
;		.extern	_FIRFilterInit
;		.extern	_BlockFIRFilter
;		.extern	_f300_2400Filter
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
;		mov	#_f300_2400Filter, W0	; Initalize W0 to filter structure
;		call	_FIRFilterInit	; call this function once
;
; The next 4 instructions are required prior to each subroutine call
; to _BlockFIRFilter
;		mov	#_f300_2400Filter, W0	; Initalize W0 to filter structure
;		mov	#input, W1	; Initalize W1 to input buffer 
;		mov	#output, W2	; Initalize W2 to output buffer
;		mov	#20, W3	; Initialize W3 with number of required output samples
;		call	_BlockFIRFilter	; call as many times as needed
