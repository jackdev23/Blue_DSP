; ..............................................................................
;    File   f300_1800.s
; ..............................................................................

		.equ f300_1800NumTaps, 128

; ..............................................................................
; Allocate and initialize filter taps

		.section .f300_1800const, code
		.align 256

f300_1800Taps:
.hword 0x0002
.hword 0x0025
.hword 0x0077
.hword 0x00B6
.hword 0x004B
.hword 0xFF00
.hword 0xFDB3
.hword 0xFDCD
.hword 0xFF9E
.hword 0x0197
.hword 0x01E9
.hword 0x00BA
.hword 0xFFF0
.hword 0x0097
.hword 0x0179
.hword 0x0110
.hword 0xFFDB
.hword 0xFF8F
.hword 0x0059
.hword 0x009C
.hword 0xFFA1
.hword 0xFECE
.hword 0xFF4E
.hword 0x0013
.hword 0xFF96
.hword 0xFE81
.hword 0xFE9E
.hword 0xFFC2
.hword 0xFFF8
.hword 0xFEE6
.hword 0xFE88
.hword 0xFFCE
.hword 0x00D4
.hword 0x000F
.hword 0xFF1F
.hword 0x0020
.hword 0x01DC
.hword 0x01AA
.hword 0x0021
.hword 0x0050
.hword 0x0265
.hword 0x0302
.hword 0x0103
.hword 0xFFD5
.hword 0x01A9
.hword 0x0342
.hword 0x013F
.hword 0xFE55
.hword 0xFF24
.hword 0x01DE
.hword 0x00B2
.hword 0xFC0D
.hword 0xFAE3
.hword 0xFECA
.hword 0xFFF0
.hword 0xFA07
.hword 0xF55D
.hword 0xFA31
.hword 0x00AE
.hword 0xFAC4
.hword 0xED72
.hword 0xF0A8
.hword 0x0E41
.hword 0x2D89
.hword 0x2D89
.hword 0x0E41
.hword 0xF0A8
.hword 0xED72
.hword 0xFAC4
.hword 0x00AE
.hword 0xFA31
.hword 0xF55D
.hword 0xFA07
.hword 0xFFF0
.hword 0xFECA
.hword 0xFAE3
.hword 0xFC0D
.hword 0x00B2
.hword 0x01DE
.hword 0xFF24
.hword 0xFE55
.hword 0x013F
.hword 0x0342
.hword 0x01A9
.hword 0xFFD5
.hword 0x0103
.hword 0x0302
.hword 0x0265
.hword 0x0050
.hword 0x0021
.hword 0x01AA
.hword 0x01DC
.hword 0x0020
.hword 0xFF1F
.hword 0x000F
.hword 0x00D4
.hword 0xFFCE
.hword 0xFE88
.hword 0xFEE6
.hword 0xFFF8
.hword 0xFFC2
.hword 0xFE9E
.hword 0xFE81
.hword 0xFF96
.hword 0x0013
.hword 0xFF4E
.hword 0xFECE
.hword 0xFFA1
.hword 0x009C
.hword 0x0059
.hword 0xFF8F
.hword 0xFFDB
.hword 0x0110
.hword 0x0179
.hword 0x0097
.hword 0xFFF0
.hword 0x00BA
.hword 0x01E9
.hword 0x0197
.hword 0xFF9E
.hword 0xFDCD
.hword 0xFDB3
.hword 0xFF00
.hword 0x004B
.hword 0x00B6
.hword 0x0077
.hword 0x0025
.hword 0x0002

; ..............................................................................
; Allocate delay line in (uninitialized) Y data space

		.section .ybss,bss,ymemory
		.align 256

f300_1800Delay:
		.space f300_1800NumTaps*2

; ..............................................................................
; Allocate and intialize filter structure

		.section .data
		.global _f300_1800Filter

_f300_1800Filter:
.hword f300_1800NumTaps
.hword psvoffset(f300_1800Taps)
.hword psvoffset(f300_1800Taps)+f300_1800NumTaps*2-1
.hword psvpage(f300_1800Taps)
.hword f300_1800Delay
.hword f300_1800Delay+f300_1800NumTaps*2-1
.hword f300_1800Delay

; ..............................................................................
; ..............................................................................
; Sample assembly language calling program
;  The following declarations can be cut and pasted as needed into a program
;		.extern	_FIRFilterInit
;		.extern	_BlockFIRFilter
;		.extern	_f300_1800Filter
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
;		mov	#_f300_1800Filter, W0	; Initalize W0 to filter structure
;		call	_FIRFilterInit	; call this function once
;
; The next 4 instructions are required prior to each subroutine call
; to _BlockFIRFilter
;		mov	#_f300_1800Filter, W0	; Initalize W0 to filter structure
;		mov	#input, W1	; Initalize W1 to input buffer 
;		mov	#output, W2	; Initalize W2 to output buffer
;		mov	#20, W3	; Initialize W3 with number of required output samples
;		call	_BlockFIRFilter	; call as many times as needed
