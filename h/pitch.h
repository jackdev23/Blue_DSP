/* Microchip Technology Inc. and its subsidiaries.  You may use this software 
 * and any derivatives exclusively with Microchip products. 
 * 
 * THIS SOFTWARE IS SUPPLIED BY MICROCHIP "AS IS".  NO WARRANTIES, WHETHER 
 * EXPRESS, IMPLIED OR STATUTORY, APPLY TO THIS SOFTWARE, INCLUDING ANY IMPLIED 
 * WARRANTIES OF NON-INFRINGEMENT, MERCHANTABILITY, AND FITNESS FOR A 
 * PARTICULAR PURPOSE, OR ITS INTERACTION WITH MICROCHIP PRODUCTS, COMBINATION 
 * WITH ANY OTHER PRODUCTS, OR USE IN ANY APPLICATION. 
 *
 * IN NO EVENT WILL MICROCHIP BE LIABLE FOR ANY INDIRECT, SPECIAL, PUNITIVE, 
 * INCIDENTAL OR CONSEQUENTIAL LOSS, DAMAGE, COST OR EXPENSE OF ANY KIND 
 * WHATSOEVER RELATED TO THE SOFTWARE, HOWEVER CAUSED, EVEN IF MICROCHIP HAS 
 * BEEN ADVISED OF THE POSSIBILITY OR THE DAMAGES ARE FORESEEABLE.  TO THE 
 * FULLEST EXTENT ALLOWED BY LAW, MICROCHIP'S TOTAL LIABILITY ON ALL CLAIMS 
 * IN ANY WAY RELATED TO THIS SOFTWARE WILL NOT EXCEED THE AMOUNT OF FEES, IF 
 * ANY, THAT YOU HAVE PAID DIRECTLY TO MICROCHIP FOR THIS SOFTWARE.
 *
 * MICROCHIP PROVIDES THIS SOFTWARE CONDITIONALLY UPON YOUR ACCEPTANCE OF THESE 
 * TERMS. 
 */

/* 
 * File:   
 * Author: 
 * Comments:
 * Revision history: 
 */

// This is a guard condition so that contents of this file are not included
// more than once.  
#ifndef PITCH_H
#define	PITCH_H
#include "xc.h"
#include <dsp.h>
// structure to hold tracking data
typedef struct _dywapitchtracker {
	fractional	_prevPitch;
	int		_pitchConfidence;
} dywapitchtracker;

// returns the number of samples needed to compute pitch for fequencies equal and above the given minFreq (in Hz)
// useful to allocate large enough audio buffer 
// ex : for frequencies above 130Hz, you need 1024 samples (assuming a 44100 Hz samplerate)
int dywapitch_neededsamplecount(int minFreq);

// call before computing any pitch, passing an allocated dywapitchtracker structure
void dywapitch_inittracking();

// computes the pitch. Pass the inited dywapitchtracker structure
// samples : a pointer to the sample buffer
// startsample : the index of teh first sample to use in teh sample buffer
// samplecount : the number of samples to use to compte the pitch
// return 0.0 if no pitch was found (sound too low, noise, etc..)
fractional dywapitch_computepitch( fractional * samples, int samplecount);

#endif	/* XC_HEADER_TEMPLATE_H */

