; ..............................................................................
;    File   test700hz.s
; ..............................................................................

		.equ test700hzNumTaps, 128

; ..............................................................................
; Allocate and initialize filter taps

		.section .test700hzconst, code
		.align 256

test700hzTaps:
.hword 0xFFFE
.hword 0xFFFC
.hword 0xFFFC
.hword 0xFFFE
.hword 0x0003
.hword 0x000A
.hword 0x0010
.hword 0x0013
.hword 0x0010
.hword 0x0004
.hword 0xFFF1
.hword 0xFFDC
.hword 0xFFCC
.hword 0xFFCB
.hword 0xFFDE
.hword 0x0003
.hword 0x0033
.hword 0x005F
.hword 0x0075
.hword 0x0069
.hword 0x0034
.hword 0xFFE0
.hword 0xFF83
.hword 0xFF3B
.hword 0xFF27
.hword 0xFF58
.hword 0xFFCB
.hword 0x0066
.hword 0x00FC
.hword 0x0159
.hword 0x0154
.hword 0x00E0
.hword 0x0011
.hword 0xFF1E
.hword 0xFE50
.hword 0xFDF2
.hword 0xFE2F
.hword 0xFF08
.hword 0x004A
.hword 0x0198
.hword 0x028A
.hword 0x02C9
.hword 0x022F
.hword 0x00D8
.hword 0xFF1F
.hword 0xFD89
.hword 0xFC95
.hword 0xFC9E
.hword 0xFDB2
.hword 0xFF8D
.hword 0x01A7
.hword 0x035D
.hword 0x0424
.hword 0x03B2
.hword 0x021C
.hword 0xFFD4
.hword 0xFD85
.hword 0xFBE4
.hword 0xFB74
.hword 0xFC5E
.hword 0xFE63
.hword 0x00EA
.hword 0x0332
.hword 0x048A
.hword 0x048A
.hword 0x0332
.hword 0x00EA
.hword 0xFE63
.hword 0xFC5E
.hword 0xFB74
.hword 0xFBE4
.hword 0xFD85
.hword 0xFFD4
.hword 0x021C
.hword 0x03B2
.hword 0x0424
.hword 0x035D
.hword 0x01A7
.hword 0xFF8D
.hword 0xFDB2
.hword 0xFC9E
.hword 0xFC95
.hword 0xFD89
.hword 0xFF1F
.hword 0x00D8
.hword 0x022F
.hword 0x02C9
.hword 0x028A
.hword 0x0198
.hword 0x004A
.hword 0xFF08
.hword 0xFE2F
.hword 0xFDF2
.hword 0xFE50
.hword 0xFF1E
.hword 0x0011
.hword 0x00E0
.hword 0x0154
.hword 0x0159
.hword 0x00FC
.hword 0x0066
.hword 0xFFCB
.hword 0xFF58
.hword 0xFF27
.hword 0xFF3B
.hword 0xFF83
.hword 0xFFE0
.hword 0x0034
.hword 0x0069
.hword 0x0075
.hword 0x005F
.hword 0x0033
.hword 0x0003
.hword 0xFFDE
.hword 0xFFCB
.hword 0xFFCC
.hword 0xFFDC
.hword 0xFFF1
.hword 0x0004
.hword 0x0010
.hword 0x0013
.hword 0x0010
.hword 0x000A
.hword 0x0003
.hword 0xFFFE
.hword 0xFFFC
.hword 0xFFFC
.hword 0xFFFE
; ..............................................................................
; Allocate delay line in (uninitialized) Y data space

		.section .ybss,bss,ymemory
		.align 256

test700hzDelay:
		.space test700hzNumTaps*2

; ..............................................................................
; Allocate and intialize filter structure

		.section .data
		.global _test700hzFilter

_test700hzFilter:
.hword test700hzNumTaps
.hword psvoffset(test700hzTaps)
.hword psvoffset(test700hzTaps)+test700hzNumTaps*2-1
.hword psvpage(test700hzTaps)
.hword test700hzDelay
.hword test700hzDelay+test700hzNumTaps*2-1
.hword test700hzDelay

; ..............................................................................
; ..............................................................................
; Sample assembly language calling program
;  The following declarations can be cut and pasted as needed into a program
;		.extern	_FIRFilterInit
;		.extern	_BlockFIRFilter
;		.extern	_test700hzFilter
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
;		mov	#_test700hzFilter, W0	; Initalize W0 to filter structure
;		call	_FIRFilterInit	; call this function once
;
; The next 4 instructions are required prior to each subroutine call
; to _BlockFIRFilter
;		mov	#_test700hzFilter, W0	; Initalize W0 to filter structure
;		mov	#input, W1	; Initalize W1 to input buffer 
;		mov	#output, W2	; Initalize W2 to output buffer
;		mov	#20, W3	; Initialize W3 with number of required output samples
;		call	_BlockFIRFilter	; call as many times as needed
