; ..............................................................................
;    File   f300_1300cw.s
; ..............................................................................

		.equ f300_1300cwNumTaps, 128

; ..............................................................................
; Allocate and initialize filter taps

		.section .f300_1300cwconst, code
		.align 256

f300_1300cwTaps:
.hword 0x0000
.hword 0xFFE3
.hword 0xFFAE
.hword 0xFF71
.hword 0xFF5D
.hword 0xFF9C
.hword 0x002B
.hword 0x00C8
.hword 0x0117
.hword 0x00E9
.hword 0x0066
.hword 0xFFF6
.hword 0xFFF0
.hword 0x0048
.hword 0x0099
.hword 0x0081
.hword 0x0002
.hword 0xFF7F
.hword 0xFF67
.hword 0xFFBF
.hword 0x0019
.hword 0xFFFC
.hword 0xFF65
.hword 0xFED3
.hword 0xFED0
.hword 0xFF62
.hword 0xFFF7
.hword 0xFFF3
.hword 0xFF55
.hword 0xFEC9
.hword 0xFF01
.hword 0xFFF9
.hword 0x00E8
.hword 0x00FD
.hword 0x0040
.hword 0xFF9E
.hword 0x0001
.hword 0x0156
.hword 0x027E
.hword 0x0263
.hword 0x0121
.hword 0x0008
.hword 0x0058
.hword 0x01E2
.hword 0x030B
.hword 0x0258
.hword 0x0009
.hword 0xFE12
.hword 0xFE3B
.hword 0x002F
.hword 0x0184
.hword 0x0004
.hword 0xFC23
.hword 0xF8FF
.hword 0xF986
.hword 0xFD3C
.hword 0xFFFD
.hword 0xFD92
.hword 0xF645
.hword 0xF005
.hword 0xF25C
.hword 0xFFF7
.hword 0x1333
.hword 0x2122
.hword 0x2122
.hword 0x1333
.hword 0xFFF7
.hword 0xF25C
.hword 0xF005
.hword 0xF645
.hword 0xFD92
.hword 0xFFFD
.hword 0xFD3C
.hword 0xF986
.hword 0xF8FF
.hword 0xFC23
.hword 0x0004
.hword 0x0184
.hword 0x002F
.hword 0xFE3B
.hword 0xFE12
.hword 0x0009
.hword 0x0258
.hword 0x030B
.hword 0x01E2
.hword 0x0058
.hword 0x0008
.hword 0x0121
.hword 0x0263
.hword 0x027E
.hword 0x0156
.hword 0x0001
.hword 0xFF9E
.hword 0x0040
.hword 0x00FD
.hword 0x00E8
.hword 0xFFF9
.hword 0xFF01
.hword 0xFEC9
.hword 0xFF55
.hword 0xFFF3
.hword 0xFFF7
.hword 0xFF62
.hword 0xFED0
.hword 0xFED3
.hword 0xFF65
.hword 0xFFFC
.hword 0x0019
.hword 0xFFBF
.hword 0xFF67
.hword 0xFF7F
.hword 0x0002
.hword 0x0081
.hword 0x0099
.hword 0x0048
.hword 0xFFF0
.hword 0xFFF6
.hword 0x0066
.hword 0x00E9
.hword 0x0117
.hword 0x00C8
.hword 0x002B
.hword 0xFF9C
.hword 0xFF5D
.hword 0xFF71
.hword 0xFFAE
.hword 0xFFE3
.hword 0x0000


; ..............................................................................
; Allocate delay line in (uninitialized) Y data space

		.section .ybss,bss,ymemory
		.align 256

f300_1300cwDelay:
		.space f300_1300cwNumTaps*2

; ..............................................................................
; Allocate and intialize filter structure

		.section .data
		.global _f300_1300cwFilter

_f300_1300cwFilter:
.hword f300_1300cwNumTaps
.hword psvoffset(f300_1300cwTaps)
.hword psvoffset(f300_1300cwTaps)+f300_1300cwNumTaps*2-1
.hword psvpage(f300_1300cwTaps)
.hword f300_1300cwDelay
.hword f300_1300cwDelay+f300_1300cwNumTaps*2-1
.hword f300_1300cwDelay

; ..............................................................................
; ..............................................................................
; Sample assembly language calling program
;  The following declarations can be cut and pasted as needed into a program
;		.extern	_FIRFilterInit
;		.extern	_BlockFIRFilter
;		.extern	_f300_1300cwFilter
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
;		mov	#_f300_1300cwFilter, W0	; Initalize W0 to filter structure
;		call	_FIRFilterInit	; call this function once
;
; The next 4 instructions are required prior to each subroutine call
; to _BlockFIRFilter
;		mov	#_f300_1300cwFilter, W0	; Initalize W0 to filter structure
;		mov	#input, W1	; Initalize W1 to input buffer 
;		mov	#output, W2	; Initalize W2 to output buffer
;		mov	#20, W3	; Initialize W3 with number of required output samples
;		call	_BlockFIRFilter	; call as many times as needed
