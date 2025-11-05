; ..............................................................................
;    File   f450_750apf.s
; ..............................................................................

		.equ f450_750apfNumTaps, 128

; ..............................................................................
; Allocate and initialize filter taps

		.section .f450_750apfconst, code
		.align 256

f450_750apfTaps:
.hword 0x0000
.hword 0xFFFA
.hword 0xFFF3
.hword 0xFFEB
.hword 0xFFE6
.hword 0xFFE7
.hword 0xFFF2
.hword 0x0009
.hword 0x002A
.hword 0x004B
.hword 0x0063
.hword 0x0066
.hword 0x004E
.hword 0x001B
.hword 0xFFD6
.hword 0xFF90
.hword 0xFF5E
.hword 0xFF4F
.hword 0xFF6A
.hword 0xFFA8
.hword 0xFFF6
.hword 0x003A
.hword 0x0060
.hword 0x005F
.hword 0x003D
.hword 0x0011
.hword 0xFFF9
.hword 0x000B
.hword 0x004C
.hword 0x00AB
.hword 0x0103
.hword 0x0125
.hword 0x00F0
.hword 0x005D
.hword 0xFF88
.hword 0xFEA9
.hword 0xFE05
.hword 0xFDD4
.hword 0xFE2A
.hword 0xFEED
.hword 0xFFDD
.hword 0x00A6
.hword 0x0105
.hword 0x00E3
.hword 0x0064
.hword 0xFFDA
.hword 0xFFAC
.hword 0x0027
.hword 0x0153
.hword 0x02E8
.hword 0x0452
.hword 0x04E3
.hword 0x0410
.hword 0x01AA
.hword 0xFE09
.hword 0xF9FF
.hword 0xF6AA
.hword 0xF520
.hword 0xF616
.hword 0xF99A
.hword 0xFF04
.hword 0x0512
.hword 0x0A43
.hword 0x0D40
.hword 0x0D40
.hword 0x0A43
.hword 0x0512
.hword 0xFF04
.hword 0xF99A
.hword 0xF616
.hword 0xF520
.hword 0xF6AA
.hword 0xF9FF
.hword 0xFE09
.hword 0x01AA
.hword 0x0410
.hword 0x04E3
.hword 0x0452
.hword 0x02E8
.hword 0x0153
.hword 0x0027
.hword 0xFFAC
.hword 0xFFDA
.hword 0x0064
.hword 0x00E3
.hword 0x0105
.hword 0x00A6
.hword 0xFFDD
.hword 0xFEED
.hword 0xFE2A
.hword 0xFDD4
.hword 0xFE05
.hword 0xFEA9
.hword 0xFF88
.hword 0x005D
.hword 0x00F0
.hword 0x0125
.hword 0x0103
.hword 0x00AB
.hword 0x004C
.hword 0x000B
.hword 0xFFF9
.hword 0x0011
.hword 0x003D
.hword 0x005F
.hword 0x0060
.hword 0x003A
.hword 0xFFF6
.hword 0xFFA8
.hword 0xFF6A
.hword 0xFF4F
.hword 0xFF5E
.hword 0xFF90
.hword 0xFFD6
.hword 0x001B
.hword 0x004E
.hword 0x0066
.hword 0x0063
.hword 0x004B
.hword 0x002A
.hword 0x0009
.hword 0xFFF2
.hword 0xFFE7
.hword 0xFFE6
.hword 0xFFEB
.hword 0xFFF3
.hword 0xFFFA
.hword 0x0000

; ..............................................................................
; Allocate delay line in (uninitialized) Y data space

		.section .ybss,bss,ymemory
		.align 256

f450_750apfDelay:
		.space f450_750apfNumTaps*2

; ..............................................................................
; Allocate and intialize filter structure

		.section .data
		.global _f450_750apfFilter

_f450_750apfFilter:
.hword f450_750apfNumTaps
.hword psvoffset(f450_750apfTaps)
.hword psvoffset(f450_750apfTaps)+f450_750apfNumTaps*2-1
.hword psvpage(f450_750apfTaps)
.hword f450_750apfDelay
.hword f450_750apfDelay+f450_750apfNumTaps*2-1
.hword f450_750apfDelay

; ..............................................................................
; ..............................................................................
; Sample assembly language calling program
;  The following declarations can be cut and pasted as needed into a program
;		.extern	_FIRFilterInit
;		.extern	_BlockFIRFilter
;		.extern	_f450_750apfFilter
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
;		mov	#_f450_750apfFilter, W0	; Initalize W0 to filter structure
;		call	_FIRFilterInit	; call this function once
;
; The next 4 instructions are required prior to each subroutine call
; to _BlockFIRFilter
;		mov	#_f450_750apfFilter, W0	; Initalize W0 to filter structure
;		mov	#input, W1	; Initalize W1 to input buffer 
;		mov	#output, W2	; Initalize W2 to output buffer
;		mov	#20, W3	; Initialize W3 with number of required output samples
;		call	_BlockFIRFilter	; call as many times as needed
