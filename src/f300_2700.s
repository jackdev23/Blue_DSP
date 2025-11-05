; ..............................................................................
;    File   f300_2700.s
; ..............................................................................

		.equ f300_2700NumTaps, 128

; ..............................................................................
; Allocate and initialize filter taps

		.section .f300_2700const, code
		.align 256

f300_2700Taps:
.hword 0xFFE2
.hword 0xFF19
.hword 0xFE96
.hword 0x0010
.hword 0x017D
.hword 0x007E
.hword 0xFFEA
.hword 0x00E2
.hword 0x0080
.hword 0xFFF0
.hword 0x00AF
.hword 0x0054
.hword 0xFFD6
.hword 0x0086
.hword 0x000E
.hword 0xFF9F
.hword 0x0052
.hword 0xFFB2
.hword 0xFF5C
.hword 0x001C
.hword 0xFF51
.hword 0xFF24
.hword 0xFFF9
.hword 0xFF06
.hword 0xFF16
.hword 0x0002
.hword 0xFEE9
.hword 0xFF4B
.hword 0x0048
.hword 0xFF07
.hword 0xFFCD
.hword 0x00C8
.hword 0xFF58
.hword 0x008B
.hword 0x0165
.hword 0xFFBE
.hword 0x0161
.hword 0x01ED
.hword 0x0003
.hword 0x0218
.hword 0x0220
.hword 0xFFEE
.hword 0x0277
.hword 0x01C0
.hword 0xFF50
.hword 0x025C
.hword 0x00A9
.hword 0xFE16
.hword 0x01C4
.hword 0xFECD
.hword 0xFC51
.hword 0x00DF
.hword 0xFC40
.hword 0xFA3D
.hword 0x001A
.hword 0xF916
.hword 0xF831
.hword 0x0047
.hword 0xF4F0
.hword 0xF68D
.hword 0x03DE
.hword 0xEBE7
.hword 0xF5A4
.hword 0x400A
.hword 0x400A
.hword 0xF5A4
.hword 0xEBE7
.hword 0x03DE
.hword 0xF68D
.hword 0xF4F0
.hword 0x0047
.hword 0xF831
.hword 0xF916
.hword 0x001A
.hword 0xFA3D
.hword 0xFC40
.hword 0x00DF
.hword 0xFC51
.hword 0xFECD
.hword 0x01C4
.hword 0xFE16
.hword 0x00A9
.hword 0x025C
.hword 0xFF50
.hword 0x01C0
.hword 0x0277
.hword 0xFFEE
.hword 0x0220
.hword 0x0218
.hword 0x0003
.hword 0x01ED
.hword 0x0161
.hword 0xFFBE
.hword 0x0165
.hword 0x008B
.hword 0xFF58
.hword 0x00C8
.hword 0xFFCD
.hword 0xFF07
.hword 0x0048
.hword 0xFF4B
.hword 0xFEE9
.hword 0x0002
.hword 0xFF16
.hword 0xFF06
.hword 0xFFF9
.hword 0xFF24
.hword 0xFF51
.hword 0x001C
.hword 0xFF5C
.hword 0xFFB2
.hword 0x0052
.hword 0xFF9F
.hword 0x000E
.hword 0x0086
.hword 0xFFD6
.hword 0x0054
.hword 0x00AF
.hword 0xFFF0
.hword 0x0080
.hword 0x00E2
.hword 0xFFEA
.hword 0x007E
.hword 0x017D
.hword 0x0010
.hword 0xFE96
.hword 0xFF19
.hword 0xFFE2


; ..............................................................................
; Allocate delay line in (uninitialized) Y data space

		.section .ybss,bss,ymemory
		.align 256

f300_2700Delay:
		.space f300_2700NumTaps*2

; ..............................................................................
; Allocate and intialize filter structure

		.section .data
		.global _f300_2700Filter

_f300_2700Filter:
.hword f300_2700NumTaps
.hword psvoffset(f300_2700Taps)
.hword psvoffset(f300_2700Taps)+f300_2700NumTaps*2-1
.hword psvpage(f300_2700Taps)
.hword f300_2700Delay
.hword f300_2700Delay+f300_2700NumTaps*2-1
.hword f300_2700Delay

; ..............................................................................
; ..............................................................................
; Sample assembly language calling program
;  The following declarations can be cut and pasted as needed into a program
;		.extern	_FIRFilterInit
;		.extern	_BlockFIRFilter
;		.extern	_f300_2700Filter
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
;		mov	#_f300_2700Filter, W0	; Initalize W0 to filter structure
;		call	_FIRFilterInit	; call this function once
;
; The next 4 instructions are required prior to each subroutine call
; to _BlockFIRFilter
;		mov	#_f300_2700Filter, W0	; Initalize W0 to filter structure
;		mov	#input, W1	; Initalize W1 to input buffer 
;		mov	#output, W2	; Initalize W2 to output buffer
;		mov	#20, W3	; Initialize W3 with number of required output samples
;		call	_BlockFIRFilter	; call as many times as needed
