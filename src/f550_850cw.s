; ..............................................................................
;    File   f550_850cw.s
; ..............................................................................

		.equ f550_850cwNumTaps, 128

; ..............................................................................
; Allocate and initialize filter taps

		.section .f550_850cwconst, code
		.align 256

f550_850cwTaps:
.hword 0xFFF2
.hword 0xFFF0
.hword 0xFFF0
.hword 0xFFF8
.hword 0x0009
.hword 0x0020
.hword 0x0033
.hword 0x0039
.hword 0x002C
.hword 0x000B
.hword 0xFFE0
.hword 0xFFB9
.hword 0xFFA5
.hword 0xFFAF
.hword 0xFFD2
.hword 0x0001
.hword 0x0029
.hword 0x0039
.hword 0x002F
.hword 0x0015
.hword 0x0001
.hword 0x0009
.hword 0x0032
.hword 0x006D
.hword 0x0097
.hword 0x008A
.hword 0x0030
.hword 0xFF94
.hword 0xFEE5
.hword 0xFE69
.hword 0xFE61
.hword 0xFEEB
.hword 0xFFEC
.hword 0x0115
.hword 0x01FE
.hword 0x024E
.hword 0x01E5
.hword 0x00EB
.hword 0xFFC1
.hword 0xFEDA
.hword 0xFE87
.hword 0xFECF
.hword 0xFF6C
.hword 0xFFED
.hword 0xFFEF
.hword 0xFF57
.hword 0xFE70
.hword 0xFDCD
.hword 0xFE0E
.hword 0xFF87
.hword 0x0202
.hword 0x04B7
.hword 0x068A
.hword 0x0675
.hword 0x0407
.hword 0xFFA7
.hword 0xFA95
.hword 0xF685
.hword 0xF507
.hword 0xF6E9
.hword 0xFBD8
.hword 0x0267
.hword 0x0884
.hword 0x0C2F
.hword 0x0C2F
.hword 0x0884
.hword 0x0267
.hword 0xFBD8
.hword 0xF6E9
.hword 0xF507
.hword 0xF685
.hword 0xFA95
.hword 0xFFA7
.hword 0x0407
.hword 0x0675
.hword 0x068A
.hword 0x04B7
.hword 0x0202
.hword 0xFF87
.hword 0xFE0E
.hword 0xFDCD
.hword 0xFE70
.hword 0xFF57
.hword 0xFFEF
.hword 0xFFED
.hword 0xFF6C
.hword 0xFECF
.hword 0xFE87
.hword 0xFEDA
.hword 0xFFC1
.hword 0x00EB
.hword 0x01E5
.hword 0x024E
.hword 0x01FE
.hword 0x0115
.hword 0xFFEC
.hword 0xFEEB
.hword 0xFE61
.hword 0xFE69
.hword 0xFEE5
.hword 0xFF94
.hword 0x0030
.hword 0x008A
.hword 0x0097
.hword 0x006D
.hword 0x0032
.hword 0x0009
.hword 0x0001
.hword 0x0015
.hword 0x002F
.hword 0x0039
.hword 0x0029
.hword 0x0001
.hword 0xFFD2
.hword 0xFFAF
.hword 0xFFA5
.hword 0xFFB9
.hword 0xFFE0
.hword 0x000B
.hword 0x002C
.hword 0x0039
.hword 0x0033
.hword 0x0020
.hword 0x0009
.hword 0xFFF8
.hword 0xFFF0
.hword 0xFFF0
.hword 0xFFF2

; ..............................................................................
; Allocate delay line in (uninitialized) Y data space

		.section .ybss,bss,ymemory
		.align 256

f550_850cwDelay:
		.space f550_850cwNumTaps*2

; ..............................................................................
; Allocate and intialize filter structure

		.section .data
		.global _f550_850cwFilter

_f550_850cwFilter:
.hword f550_850cwNumTaps
.hword psvoffset(f550_850cwTaps)
.hword psvoffset(f550_850cwTaps)+f550_850cwNumTaps*2-1
.hword psvpage(f550_850cwTaps)
.hword f550_850cwDelay
.hword f550_850cwDelay+f550_850cwNumTaps*2-1
.hword f550_850cwDelay

; ..............................................................................
; ..............................................................................
; Sample assembly language calling program
;  The following declarations can be cut and pasted as needed into a program
;		.extern	_FIRFilterInit
;		.extern	_BlockFIRFilter
;		.extern	_f550_850cwFilter
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
;		mov	#_f550_850cwFilter, W0	; Initalize W0 to filter structure
;		call	_FIRFilterInit	; call this function once
;
; The next 4 instructions are required prior to each subroutine call
; to _BlockFIRFilter
;		mov	#_f550_850cwFilter, W0	; Initalize W0 to filter structure
;		mov	#input, W1	; Initalize W1 to input buffer 
;		mov	#output, W2	; Initalize W2 to output buffer
;		mov	#20, W3	; Initialize W3 with number of required output samples
;		call	_BlockFIRFilter	; call as many times as needed
