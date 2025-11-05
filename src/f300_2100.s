; ..............................................................................
;    File   f300_2100.s
; ..............................................................................

		.equ f300_2100NumTaps, 128

; ..............................................................................
; Allocate and initialize filter taps

		.section .f300_2100const, code
		.align 256

f300_2100Taps:
.hword 0x003D
.hword 0x0057
.hword 0xFFAE
.hword 0xFE8C
.hword 0xFE6E
.hword 0xFFE2
.hword 0x0135
.hword 0x00E3
.hword 0x000B
.hword 0x005B
.hword 0x010F
.hword 0x00A8
.hword 0xFFF5
.hword 0x0050
.hword 0x00CA
.hword 0x002D
.hword 0xFF9C
.hword 0x0023
.hword 0x0060
.hword 0xFF84
.hword 0xFF30
.hword 0xFFEC
.hword 0xFFDE
.hword 0xFEDD
.hword 0xFEF7
.hword 0xFFE4
.hword 0xFF7C
.hword 0xFE8C
.hword 0xFF43
.hword 0x0043
.hword 0xFF75
.hword 0xFED5
.hword 0x003B
.hword 0x0106
.hword 0xFFC7
.hword 0xFFB5
.hword 0x01A5
.hword 0x01CC
.hword 0x001D
.hword 0x00CB
.hword 0x02E4
.hword 0x01E8
.hword 0xFFF0
.hword 0x0184
.hword 0x0333
.hword 0x00AB
.hword 0xFED4
.hword 0x0172
.hword 0x0203
.hword 0xFDC0
.hword 0xFCDB
.hword 0x00A7
.hword 0xFF3B
.hword 0xF95B
.hword 0xFACB
.hword 0xFFF2
.hword 0xFB11
.hword 0xF3D3
.hword 0xFA88
.hword 0x0195
.hword 0xF425
.hword 0xE9D9
.hword 0x0786
.hword 0x34A3
.hword 0x34A3
.hword 0x0786
.hword 0xE9D9
.hword 0xF425
.hword 0x0195
.hword 0xFA88
.hword 0xF3D3
.hword 0xFB11
.hword 0xFFF2
.hword 0xFACB
.hword 0xF95B
.hword 0xFF3B
.hword 0x00A7
.hword 0xFCDB
.hword 0xFDC0
.hword 0x0203
.hword 0x0172
.hword 0xFED4
.hword 0x00AB
.hword 0x0333
.hword 0x0184
.hword 0xFFF0
.hword 0x01E8
.hword 0x02E4
.hword 0x00CB
.hword 0x001D
.hword 0x01CC
.hword 0x01A5
.hword 0xFFB5
.hword 0xFFC7
.hword 0x0106
.hword 0x003B
.hword 0xFED5
.hword 0xFF75
.hword 0x0043
.hword 0xFF43
.hword 0xFE8C
.hword 0xFF7C
.hword 0xFFE4
.hword 0xFEF7
.hword 0xFEDD
.hword 0xFFDE
.hword 0xFFEC
.hword 0xFF30
.hword 0xFF84
.hword 0x0060
.hword 0x0023
.hword 0xFF9C
.hword 0x002D
.hword 0x00CA
.hword 0x0050
.hword 0xFFF5
.hword 0x00A8
.hword 0x010F
.hword 0x005B
.hword 0x000B
.hword 0x00E3
.hword 0x0135
.hword 0xFFE2
.hword 0xFE6E
.hword 0xFE8C
.hword 0xFFAE
.hword 0x0057
.hword 0x003D


; ..............................................................................
; Allocate delay line in (uninitialized) Y data space

		.section .ybss,bss,ymemory
		.align 256

f300_2100Delay:
		.space f300_2100NumTaps*2

; ..............................................................................
; Allocate and intialize filter structure

		.section .data
		.global _f300_2100Filter

_f300_2100Filter:
.hword f300_2100NumTaps
.hword psvoffset(f300_2100Taps)
.hword psvoffset(f300_2100Taps)+f300_2100NumTaps*2-1
.hword psvpage(f300_2100Taps)
.hword f300_2100Delay
.hword f300_2100Delay+f300_2100NumTaps*2-1
.hword f300_2100Delay

; ..............................................................................
; ..............................................................................
; Sample assembly language calling program
;  The following declarations can be cut and pasted as needed into a program
;		.extern	_FIRFilterInit
;		.extern	_BlockFIRFilter
;		.extern	_f300_2100Filter
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
;		mov	#_f300_2100Filter, W0	; Initalize W0 to filter structure
;		call	_FIRFilterInit	; call this function once
;
; The next 4 instructions are required prior to each subroutine call
; to _BlockFIRFilter
;		mov	#_f300_2100Filter, W0	; Initalize W0 to filter structure
;		mov	#input, W1	; Initalize W1 to input buffer 
;		mov	#output, W2	; Initalize W2 to output buffer
;		mov	#20, W3	; Initialize W3 with number of required output samples
;		call	_BlockFIRFilter	; call as many times as needed
