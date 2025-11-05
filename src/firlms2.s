/**********************************************************************
* © 2007 Microchip Technology Inc.
*
* FileName:        firlms2.c
* Dependencies:    Header (.h) files if applicable, see below
* Processor:       dsPIC33Fxxxx
* Compiler:        MPLAB® C30 v3.01 or higher
*
* SOFTWARE LICENSE AGREEMENT:
* Microchip Technology Incorporated ("Microchip") retains all ownership and 
* intellectual property rights in the code accompanying this message and in all 
* derivatives hereto.  You may use this code, and any derivatives created by 
* any person or entity by or on your behalf, exclusively with Microchip's
* proprietary products.  Your acceptance and/or use of this code constitutes 
* agreement to the terms and conditions of this notice.
*
* CODE ACCOMPANYING THIS MESSAGE IS SUPPLIED BY MICROCHIP "AS IS".  NO 
* WARRANTIES, WHETHER EXPRESS, IMPLIED OR STATUTORY, INCLUDING, BUT NOT LIMITED 
* TO, IMPLIED WARRANTIES OF NON-INFRINGEMENT, MERCHANTABILITY AND FITNESS FOR A 
* PARTICULAR PURPOSE APPLY TO THIS CODE, ITS INTERACTION WITH MICROCHIP'S 
* PRODUCTS, COMBINATION WITH ANY OTHER PRODUCTS, OR USE IN ANY APPLICATION. 
*
* YOU ACKNOWLEDGE AND AGREE THAT, IN NO EVENT, SHALL MICROCHIP BE LIABLE, WHETHER 
* IN CONTRACT, WARRANTY, TORT (INCLUDING NEGLIGENCE OR BREACH OF STATUTORY DUTY), 
* STRICT LIABILITY, INDEMNITY, CONTRIBUTION, OR OTHERWISE, FOR ANY INDIRECT, SPECIAL, 
* PUNITIVE, EXEMPLARY, INCIDENTAL OR CONSEQUENTIAL LOSS, DAMAGE, FOR COST OR EXPENSE OF 
* ANY KIND WHATSOEVER RELATED TO THE CODE, HOWSOEVER CAUSED, EVEN IF MICROCHIP HAS BEEN 
* ADVISED OF THE POSSIBILITY OR THE DAMAGES ARE FORESEEABLE.  TO THE FULLEST EXTENT 
* ALLOWABLE BY LAW, MICROCHIP'S TOTAL LIABILITY ON ALL CLAIMS IN ANY WAY RELATED TO 
* THIS CODE, SHALL NOT EXCEED THE PRICE YOU PAID DIRECTLY TO MICROCHIP SPECIFICALLY TO 
* HAVE THIS CODE DEVELOPED.
*
* You agree that you are solely responsible for testing the code and 
* determining its suitability.  Microchip has no obligation to modify, test, 
* certify, or support the code.
**********************************************************************/
;###################################################################################
;
; FIRLMS.S
;
; This version has been modified to return the error signal instead of the filter
; output. This version may be used to remove a sine wave from an uncorrelated signal
;
; _FIRLMS: FIR filtering with LMS coefficient adaptation.
;
; Operation:
;	y[n] = sum(m=0:M-1){h[m]*x[n-m]},
;
;	h(n+1)[m] = h(n)[m] + mu*(r[n]-y[n])*x[n-m], 0<= m < M.
;
; x[n] defined for 0 <= n < N,
; r[n] defined for 0 <= n < N,
; y[n] defined for 0 <= n < N,
; h[m] defined for 0 <= m < M as an increasing circular buffer,
; mu in [-1, 1).
; NOTE: delay defined for 0 <= m < M as an increasing circular buffer.
; NOTE: filter coefficients should not be allocated in program memory,
;	since in this case they cannot be adapted at run time.
;
; Input:
;	w0 = N, number of input samples (N)
;	w1 = y, ptr output samples (0 <= n < N)
;	w2 = x, ptr input samples (0 <= n < N)
;	w3 = filter structure (FIRStruct, h)
;	w4 = r, ptr reference samples (0 <= n < N)
;	w5 = mu (odd for NULLMODE, even for NORMALMODE)
; Return:
;	w0 = y, ptr output samples (0 <= n < N), or
;	NULL if it was detected that coefficients had been allocated in
;	program memory.
;
;###################################################################################

	.equ	kSof,2				            ;sizeof (frac) or (frac*)
	.equ	kSinPiQ,0x5A82			        ;sin (pi/4)
	.equ	kInvSqrt2,kSinPiQ		        ;1/sqrt(2) = sin (pi/4)
	.equ	PSVPAG,0x0034
	.equ	CORCON,0x0044
	.equ	MODCON,0x0046
	.equ	XBREV,0x0050
	.equ	XMODSRT,0x0048
	.equ	XMODEND,0x004A
	.equ	YMODSRT,0x004C
	.equ	YMODEND,0x004E
;========================================================================
; Operational modes for fractional computation
;========================================================================
	.equ	SATA_ON,1<<7			        ;AccA sat. enabled
	.equ	SATB_ON,1<<6			        ;AccB sat. enabled
	.equ	SATDW_ON,1<<5			        ;data write sat. enabled
	.equ	ACCSAT_ON,1<<4			        ;Accs sat. 9.31 enabled
	.equ	FRACT_SET,SATA_ON|SATB_ON|SATDW_ON|ACCSAT_ON	; set mask
	.equ	RND_OFF,~(1<<1)			        ;convergent rnd. enabled
	.equ	IF_OFF,~(1<<0)			        ;multiply fractional enabled
	.equ	FRACT_RESET,RND_OFF&IF_OFF	    ;reset mask
	.equ	FRACT_MODE,FRACT_SET&FRACT_RESET;fractional mask
;========================================================================
; FIR filter structure access
;========================================================================
	.equ	COEFFS_IN_DATA,0xFF00	        ;coeff are in (X) data mem
	.equ	oNumCoeffs,0		            ;FIRFilter->numCoeffs : (int)
	.equ	oCoeffsBase,(oNumCoeffs+kSof)   ;FIRFilter->coeffsBase : (frac*)
	.equ	oCoeffsEnd,(oCoeffsBase+kSof)   ;FIRFilter->coeffsEnd : (frac*)
	.equ	oCoeffsPage,(oCoeffsEnd+kSof)   ;FIRFilter->coeffsPage : (int)
	.equ	oDelayBase,(oCoeffsPage+kSof)   ;FIRFilter->delayBase : (frac*)
	.equ	oDelayEnd,(oDelayBase+kSof)     ;FIRFilter->delayEnd : (frac*)
	.equ	oDelay,(oDelayEnd+kSof)         ;FIRFilter->delay : (frac*)
;========================================================================
; flags
;========================================================================
	.equ    NULLMODE,0                      ; set for null mode       
	
	.global	_FIRLMS2	                    ; export
;------------------------------------------------------------------------
    .section *,data,near                    ; uninitialized data section
;------------------------------------------------------------------------
FLAGS:      .space 1                        ; local storage
                                            ; flags.0 set => null mode 
;------------------------------------------------------------------------
    .text                                   ; code section
;------------------------------------------------------------------------

;========================================================================
; FIRLMS entry point
;========================================================================
_FIRLMS2:
    bclr    FLAGS,#NULLMODE
    btsc    w5,#0                           
    bset    FLAGS,#NULLMODE                 ; make it positive
	push.d  w8				                ; {w8,w9} to TOS
	push.d	w10				                ; {w10,w11} to TOS
	push	    w12				                ; w12 to TOS
	push	    CORCON
	mov	    #FRACT_MODE,w7                  ; prepare for PSV
	mov	    w7,CORCON
	mov	    [w3+oCoeffsPage],w10            ; w10= coefficients page
	mov	    #COEFFS_IN_DATA,w8	            ; w8 = COEFFS_IN_DATA
	cp	    w8,w10				            ; w8 - w10
	bra	    z,_noPSV			            ; if w10 = COEFFS_IN_DATA
	mov	    #0,w0				            ; w0 = 0 (NULL)
	bra	    _restore
_noPSV:
	push	    MODCON
	push	    XMODSRT
	push	    XMODEND
	push	    YMODSRT
	push	    YMODEND
	mov	    #0xC0A8,w10			            ; XWM = w8, YWM = w10
	mov	    w10,MODCON			            ; enable X,Y modulo addressing
	mov	    [w3+oCoeffsEnd],w8		        ; w8 -> last byte of h[M-1]
	mov	    w8,XMODEND			            ; init'ed to coeffs end address
	mov	    [w3+oCoeffsBase],w8		        ; w8 -> h[0]
	mov	    w8,XMODSRT			            ; init'ed to coeffs base address
	mov	    [w3+oDelayEnd],w10		        ; w10-> last byte of d[M-1]
	mov	    w10,YMODEND			            ; init'ed to delay end address
	mov	    [w3+oDelayBase],w10		        ; w10 -> d[0]
	mov	    w10,YMODSRT			            ; init'ed to delay base address
	push	    w1				                ; save return value (y)
	mov	    [w3+oDelay],w10			        ; w10 points at current delay
						                    ; sample d[m], 0 <= m < M
						                    ; referred to as delay[0]
						                    ; for each iteration...
	mov	    w4,w12				            ; w12->r[0]
	mov	    [w3+oNumCoeffs],w4		        ; w4 = M
	sub	    w4,#2,w4			            ; W4 = M-2
	dec	    w0,w0				            ; w0 = N-1
	mov	    w5,w7				            ; w7 = mu
	;---------------------
	; filter
	;---------------------
	do	    w0,_endFilter		            ; do (N-1)+1 times
	mov	    [w2++],[w10]			        ; store new sample into delay
	clr	    a,[w8]+=2,w5,[w10]+=2,w6	    ; a  = 0
						                    ; w5 = h[0]
						                    ; w8-> h[1]
						                    ; w6 = delay[0]
						                    ; w10->delay[1]
	repeat	w4			                    ; do (M-2)+1 times (all but last sample)
	mac	    w5*w6,a,[w8]+=2,w5,[w10]+=2,w6	; a += h[m]*delay[m]
						                    ; w5 = h[m+1]
						                    ; w8-> h[m+2]
						                    ; w6 = delay[m+1]
						                    ; w10->delay[m+2]
	mac	    w5*w6,a				            ; a += h[M-1]*delay[M-1] (last sample)
						                    ; w8-> h[0]
						                    ; w10->delay[0]
    btss 	FLAGS,#NULLMODE                 ; skip for NULLMODE
	sac.r	a,[w1++]			            ; y[n]=r[n] - y[n]
	;----------------------
	; update coefficients
	;----------------------
	lac	    [w12++],b			            ; b  = r[n], w12-> r[n+1]
	sub	    b				                ; b= r[n] - y[n]
	sac.r	b,w5
    btsc		FLAGS,#NULLMODE	                ; skip for NORMALMODE
	sac.r	b,[w1++]			            ; y[n]=r[n] - y[n]
	mpy	    w5*w7,a				            ; a=mu*(r[n]-y[n])
	sac.r	a,w5				            ; w5=attenuated error
    ;--------------------------------------------------------------
	; Adaptation: h[m] = h[m] + attError*x[n-m].
	; Here the h[m] cannot be addressed as a circular buffer,
	; because their values are accessed via a 'LAC' instruction...
	; Thus, use w9 instead.
    ;--------------------------------------------------------------
	dec	    w4,w11				            ; w11= M-3
	mov	    w8,w9				            ; w9-> h[0]
	clr	    a,[w10]+=2,w6		            ; w6 = delay[0]
						                    ; w10->delay[1]
	do	    w11,_endAdapt		            ; do (M-3)+1 times (all but last 2 coeff)
	lac	    [w9],a				            ; a  = h[m]
	mac	    w5*w6,a,[w10]+=2,w6		        ; a += attError*delay[m]
						                    ; w6 = delay[m+1]
						                    ; w9-> delay[m+2]
_endAdapt:
	sac.r	a,[w9++]			            ; store adapted h[m]
						                    ; w9-> h[m+1]
	lac	    [w9],a				            ; a  = h[M-2] )next to last coeff)
	mac	    w5*w6,a,[w10],w6		        ; a += attError*h[M-2]
						                    ; w6 = delay[M-1]
						                    ; w10->delay[M-1]
	sac.r	a,[w9++]			            ; store adapted h[M-2]
	lac	    [w9],a				            ; a  = h[M-1] (last coeff)
	mac	    w5*w6,a				            ; a += attError*h[M-1]
_endFilter:     
	sac.r	a,[w9++]			            ; store adapted h[M-1]
	;-----------------------
	; Update delay pointer
	;-----------------------
	mov	    w10,[w3+oDelay]
	pop	    w0
	pop	    YMODEND
	pop	    YMODSRT
	pop	    XMODEND
	pop	    XMODSRT
	pop	    MODCON
_restore:
	pop	    CORCON
	pop	    w12		
	pop.d	w10			
	pop.d	w8			
	return	
	
	.end

