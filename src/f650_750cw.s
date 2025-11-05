; ..............................................................................
;    File   f650_750cw.s
; ..............................................................................

		.equ f650_750cwNumTaps, 128

; ..............................................................................
; Allocate and initialize filter taps

		.section .f650_750cwconst, code
		.align 256

f650_750cwTaps:
.hword 0x0011
.hword 0x0008
.hword 0x0003
.hword 0xFFF9
.hword 0xFFEE
.hword 0xFFE5
.hword 0xFFE2
.hword 0xFFEA
.hword 0xFFFB
.hword 0x0012
.hword 0x0026
.hword 0x0031
.hword 0x002D
.hword 0x0019
.hword 0xFFFA
.hword 0xFFDC
.hword 0xFFC9
.hword 0xFFC9
.hword 0xFFDC
.hword 0xFFFA
.hword 0x0018
.hword 0x0026
.hword 0x0020
.hword 0x0006
.hword 0xFFE7
.hword 0xFFD4
.hword 0xFFDD
.hword 0x0008
.hword 0x0048
.hword 0x0084
.hword 0x009A
.hword 0x0071
.hword 0x0005
.hword 0xFF6E
.hword 0xFEDD
.hword 0xFE8E
.hword 0xFEB2
.hword 0xFF59
.hword 0x0066
.hword 0x018F
.hword 0x026E
.hword 0x02A8
.hword 0x0209
.hword 0x00A2
.hword 0xFECA
.hword 0xFD10
.hword 0xFC08
.hword 0xFC21
.hword 0xFD76
.hword 0xFFBF
.hword 0x0259
.hword 0x0478
.hword 0x0567
.hword 0x04C0
.hword 0x029A
.hword 0xFF87
.hword 0xFC6B
.hword 0xFA3B
.hword 0xF9AD
.hword 0xFAFD
.hword 0xFDD4
.hword 0x0160
.hword 0x0493
.hword 0x0675
.hword 0x0675
.hword 0x0493
.hword 0x0160
.hword 0xFDD4
.hword 0xFAFD
.hword 0xF9AD
.hword 0xFA3B
.hword 0xFC6B
.hword 0xFF87
.hword 0x029A
.hword 0x04C0
.hword 0x0567
.hword 0x0478
.hword 0x0259
.hword 0xFFBF
.hword 0xFD76
.hword 0xFC21
.hword 0xFC08
.hword 0xFD10
.hword 0xFECA
.hword 0x00A2
.hword 0x0209
.hword 0x02A8
.hword 0x026E
.hword 0x018F
.hword 0x0066
.hword 0xFF59
.hword 0xFEB2
.hword 0xFE8E
.hword 0xFEDD
.hword 0xFF6E
.hword 0x0005
.hword 0x0071
.hword 0x009A
.hword 0x0084
.hword 0x0048
.hword 0x0008
.hword 0xFFDD
.hword 0xFFD4
.hword 0xFFE7
.hword 0x0006
.hword 0x0020
.hword 0x0026
.hword 0x0018
.hword 0xFFFA
.hword 0xFFDC
.hword 0xFFC9
.hword 0xFFC9
.hword 0xFFDC
.hword 0xFFFA
.hword 0x0019
.hword 0x002D
.hword 0x0031
.hword 0x0026
.hword 0x0012
.hword 0xFFFB
.hword 0xFFEA
.hword 0xFFE2
.hword 0xFFE5
.hword 0xFFEE
.hword 0xFFF9
.hword 0x0003
.hword 0x0008
.hword 0x0011

; ..............................................................................
; Allocate delay line in (uninitialized) Y data space

		.section .ybss,bss,ymemory
		.align 256

f650_750cwDelay:
		.space f650_750cwNumTaps*2

; ..............................................................................
; Allocate and intialize filter structure

		.section .data
		.global _f650_750cwFilter

_f650_750cwFilter:
.hword f650_750cwNumTaps
.hword psvoffset(f650_750cwTaps)
.hword psvoffset(f650_750cwTaps)+f650_750cwNumTaps*2-1
.hword psvpage(f650_750cwTaps)
.hword f650_750cwDelay
.hword f650_750cwDelay+f650_750cwNumTaps*2-1
.hword f650_750cwDelay

; ..............................................................................
; ..............................................................................
; Sample assembly language calling program
;  The following declarations can be cut and pasted as needed into a program
;		.extern	_FIRFilterInit
;		.extern	_BlockFIRFilter
;		.extern	_f650_750cwFilter
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
;		mov	#_f650_750cwFilter, W0	; Initalize W0 to filter structure
;		call	_FIRFilterInit	; call this function once
;
; The next 4 instructions are required prior to each subroutine call
; to _BlockFIRFilter
;		mov	#_f650_750cwFilter, W0	; Initalize W0 to filter structure
;		mov	#input, W1	; Initalize W1 to input buffer 
;		mov	#output, W2	; Initalize W2 to output buffer
;		mov	#20, W3	; Initialize W3 with number of required output samples
;		call	_BlockFIRFilter	; call as many times as needed
