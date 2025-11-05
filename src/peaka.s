; ..............................................................................
;    File   peaka.s
; ..............................................................................

		.equ peakaNumSections, 1

; ..............................................................................
;
; Allocate and initialize filter coefficients
;
; These coefficients have been designed for use in the Transpose filter only

		.section .xdata, xmemory, data

peakaCoefs:
.hword	0x0281	; b( 1,0)/2
.hword	0x0000	; b( 1,1)/2
.hword	0x5541	; a( 1,1)/2
.hword	0xFD7F	; b( 1,2)/2
.hword	0xC504	; a( 1,2)/2

; ..............................................................................
; Allocate states buffers in (uninitialized) Y data space

		.section .ybss,bss,ymemory

peakaStates1:
		.space peakaNumSections*2

peakaStates2:
		.space peakaNumSections*2

; ..............................................................................
; Allocate and intialize filter structure

		.section .data
		.global _peakaFilter

_peakaFilter:
.hword peakaNumSections-1
.hword peakaCoefs
.hword 0xFF00
.hword peakaStates1
.hword peakaStates2
.hword 0x0000

; ..............................................................................
; Sample assembly language calling program
;  The following declarations can be cut and pasted as needed into a program
;		.extern	_IIRTransposeFilterInit
;		.extern	_BlockIIRTransposeFilter
;		.extern	_peakaFilter
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
;		mov	#_peakaFilter, W0	; Initalize W0 to filter structure
;		call	_IIRTransposeFilterInit	; call this function once
;
; The next 4 instructions are required prior to each subroutine call
; to _BlockIIRTransposeFilter
;		mov	#_peakaFilter, W0	; Initalize W0 to filter structure
;		mov	#input, W1	; Initalize W1 to input buffer 
;		mov	#output, W2	; Initalize W2 to output buffer
;		mov	#20, W3	; Initialize W3 with number of required output samples
;		call	_BlockIIRTransposeFilter	; call as many times as needed
