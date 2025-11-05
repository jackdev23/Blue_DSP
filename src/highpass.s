; ..............................................................................
;    File   highpass.s
; ..............................................................................

		.equ highpassNumTaps, 127

; ..............................................................................
; Allocate and initialize filter taps

		.section .highpassconst, code
		.align 256

highpassTaps:
.hword 0xFEB3
.hword 0x004F
.hword 0x0049
.hword 0x0047
.hword 0x0045
.hword 0x0045
.hword 0x0044
.hword 0x0043
.hword 0x0040
.hword 0x003C
.hword 0x0035
.hword 0x002C
.hword 0x0020
.hword 0x0012
.hword 0x0001
.hword 0xFFEF
.hword 0xFFDB
.hword 0xFFC6
.hword 0xFFB1
.hword 0xFF9E
.hword 0xFF8C
.hword 0xFF7E
.hword 0xFF74
.hword 0xFF6E
.hword 0xFF6E
.hword 0xFF75
.hword 0xFF82
.hword 0xFF96
.hword 0xFFB1
.hword 0xFFD2
.hword 0xFFF9
.hword 0x0025
.hword 0x0054
.hword 0x0085
.hword 0x00B6
.hword 0x00E5
.hword 0x010F
.hword 0x0134
.hword 0x0150
.hword 0x0162
.hword 0x0167
.hword 0x015D
.hword 0x0145
.hword 0x011B
.hword 0x00E0
.hword 0x0094
.hword 0x0037
.hword 0xFFC9
.hword 0xFF4C
.hword 0xFEC1
.hword 0xFE2C
.hword 0xFD8F
.hword 0xFCEC
.hword 0xFC47
.hword 0xFBA4
.hword 0xFB06
.hword 0xFA70
.hword 0xF9E6
.hword 0xF96B
.hword 0xF903
.hword 0xF8AF
.hword 0xF871
.hword 0xF84B
.hword 0x783F
.hword 0xF84B
.hword 0xF871
.hword 0xF8AF
.hword 0xF903
.hword 0xF96B
.hword 0xF9E6
.hword 0xFA70
.hword 0xFB06
.hword 0xFBA4
.hword 0xFC47
.hword 0xFCEC
.hword 0xFD8F
.hword 0xFE2C
.hword 0xFEC1
.hword 0xFF4C
.hword 0xFFC9
.hword 0x0037
.hword 0x0094
.hword 0x00E0
.hword 0x011B
.hword 0x0145
.hword 0x015D
.hword 0x0167
.hword 0x0162
.hword 0x0150
.hword 0x0134
.hword 0x010F
.hword 0x00E5
.hword 0x00B6
.hword 0x0085
.hword 0x0054
.hword 0x0025
.hword 0xFFF9
.hword 0xFFD2
.hword 0xFFB1
.hword 0xFF96
.hword 0xFF82
.hword 0xFF75
.hword 0xFF6E
.hword 0xFF6E
.hword 0xFF74
.hword 0xFF7E
.hword 0xFF8C
.hword 0xFF9E
.hword 0xFFB1
.hword 0xFFC6
.hword 0xFFDB
.hword 0xFFEF
.hword 0x0001
.hword 0x0012
.hword 0x0020
.hword 0x002C
.hword 0x0035
.hword 0x003C
.hword 0x0040
.hword 0x0043
.hword 0x0044
.hword 0x0045
.hword 0x0045
.hword 0x0047
.hword 0x0049
.hword 0x004F
.hword 0xFEB3


; ..............................................................................
; Allocate delay line in (uninitialized) Y data space

		.section .ybss,bss,ymemory
		.align 256

highpassDelay:
		.space highpassNumTaps*2

; ..............................................................................
; Allocate and intialize filter structure

		.section .data
		.global _highpassFilter

_highpassFilter:
.hword highpassNumTaps
.hword psvoffset(highpassTaps)
.hword psvoffset(highpassTaps)+highpassNumTaps*2-1
.hword psvpage(highpassTaps)
.hword highpassDelay
.hword highpassDelay+highpassNumTaps*2-1
.hword highpassDelay

; ..............................................................................
; ..............................................................................
; Sample assembly language calling program
;  The following declarations can be cut and pasted as needed into a program
;		.extern	_FIRFilterInit
;		.extern	_BlockFIRFilter
;		.extern	_highpassFilter
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
;		mov	#_highpassFilter, W0	; Initalize W0 to filter structure
;		call	_FIRFilterInit	; call this function once
;
; The next 4 instructions are required prior to each subroutine call
; to _BlockFIRFilter
;		mov	#_highpassFilter, W0	; Initalize W0 to filter structure
;		mov	#input, W1	; Initalize W1 to input buffer 
;		mov	#output, W2	; Initalize W2 to output buffer
;		mov	#20, W3	; Initialize W3 with number of required output samples
;		call	_BlockFIRFilter	; call as many times as needed
