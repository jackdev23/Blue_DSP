/*******************************************************************************
Copyright 2018 Luca Facchinetti, IW2NDH
 All trademarks referred to in source code and documentation 
 are copyright their respective owners.
 
    This program is free software: you can redistribute it and/or modify
    it under the terms of the GNU General Public License as published by
    the Free Software Foundation, either version 3 of the License, or
    (at your option) any later version.
 
    This program is distributed WITHOUT ANY WARRANTY.
    If you offer a hardware kit using this software, 
    show your appreciation by sending the author
    a complimentary kit or a donation to a cats refuge ;-)
 *****************************************************************************/
#include <dsp.h>

#include "../h/fft.h"

fractcomplex FFT_buffer[FFT_BLOCK_LENGTH] __attribute__((section(".ydata, data, ymemory"), aligned(FFT_BLOCK_LENGTH * 2 * 2))) = {}; // FFT in place calculation buffer
fractional sample_i_buf[FFT_BLOCK_LENGTH];

fractional window_mult[FFT_BLOCK_LENGTH]; // pre calculated window function multipliers

/*   Table of 16 * log2(x) for x from 1.0 to 2.0   */

static const unsigned int log_tbl[] ={
    0, 0, 0, 1,
    1, 1, 2, 2,
    2, 3, 3, 3,
    3, 4, 4, 4,
    5, 5, 5, 6,
    6, 6, 6, 7,
    7, 7, 7, 8,
    8, 8, 8, 9,
    9, 9, 9, 10,
    10, 10, 10, 10,
    11, 11, 11, 11,
    12, 12, 12, 12,
    12, 13, 13, 13,
    13, 13, 14, 14,
    14, 14, 14, 15,
    15, 15, 15, 15
};
// OH2UG  16 * log2(n), 8 bit resolution 

unsigned int intlog2(unsigned int n) {
    unsigned int i;

    /* prevent endless loop for zero input */

    if (n == 0)
        return 0;

    /* move most significant one to 1 << 6 and count its position to i   */

    i = 6;

    if ((n & 0xFF80) != 0) {
        /* ones above target, shift right */

        do {
            i++;
            n >>= 1;
        } while ((n & 0xFF80) != 0);
    } else {
        /* first one maybe below target, shift left */

        while ((n & 0x40) == 0) {
            i--;
            n <<= 1;
        }
    }

    /* combine inetger part from i with fraction from table */

    return (i << 4) +log_tbl[n & 0x3F];
}
// set window multipliers. 0=rectangular, 1=Blackman, 2=Hanning

void init_window_mult(int type) {
    int x;

    switch (type) {
        case 0: // Rectangular
            for (x = 0; x < FFT_BLOCK_LENGTH; x++) {
                window_mult[x] = 32767; // set rectangular multipliers
            }
            break;

        case 1: // Blackman
            BlackmanInit(FFT_BLOCK_LENGTH, window_mult); // calculate Blackman window multipliers
            break;

        case 2: default: // Hanning
            HanningInit(FFT_BLOCK_LENGTH, window_mult); // calculate Hanning window multipliers
            break;
    }
}

void fftCompute(fractional *sample_i, unsigned char*test_scope) {
    int x, i, dta;
    VectorCopy(FFT_BLOCK_LENGTH, sample_i_buf, sample_i);
    // apply window function
    VectorMultiply(FFT_BLOCK_LENGTH, sample_i_buf, sample_i_buf, window_mult);

    // copy data to FFT calc buffer
    for (x = 0; x < FFT_BLOCK_LENGTH; x++) {
        //		FFT_buffer[x].real =  sample_i_buf[x] >> 1;		// copy windowed real data, multiply with 0.5
        FFT_buffer[x].real = sample_i_buf[x]; // copy windowed real data, more gain

        //		FFT_buffer[x].imag =  sample_q_buf[x] >> 1;		// copy windowed real data, multiply with 0.5
        FFT_buffer[x].imag = 0x0000; // copy windowed real data, more gain
    }

    /* Perform FFT operation */
#ifndef FFTTWIDCOEFFS_IN_PROGMEM
    FFTComplexIP(LOG2_BLOCK_LENGTH, &sigCmpx[0], &twiddleFactors[0], COEFFS_IN_DATA);
#else
    FFTComplexIP(LOG2_BLOCK_LENGTH, FFT_buffer, (fractcomplex *) __builtin_psvoffset(&twiddleFactors[0]), (int) __builtin_psvpage(&twiddleFactors[0]));
#endif

    //  Do necessary bit reversals, or after FFT
    BitReverseComplex(LOG2_BLOCK_LENGTH, FFT_buffer);

    //Compute the square of the magnitude of the complex FFT so we havea Real output vector
    SquareMagnitudeCplx(FFT_BLOCK_LENGTH, FFT_buffer, sample_i_buf);

    // fast attach slow release display
    //	i = 63;
    i = FFT_BLOCK_LENGTH_HALF; // frequency scale corrected 7.3.2013

    for (x = 0; x < FFT_BLOCK_LENGTH_HALF; x++) {
        //		dta = intlog2(sample_i_buf[i--]) >> eeprom.defval.bandscope_mode;	// eeprom variable meaning changed to bandscope gain 05.05.2011
        dta = intlog2(sample_i_buf[i--]) >> 2; //bandscope_mode meaning changed to bandscope gain, 0=1, 1=0.5, 2=0.25, 3=0.125 4=0.0625 

        if (dta >= test_scope[x]) // uppdate display data
            test_scope[x] = dta;
        else {
            if (test_scope[x] > 0) // if not 0 then decay one step
                test_scope[x]--;
            if (test_scope[x] > 0) // if not 0 then decay one step
                test_scope[x]--;

        }
    }

    //	i = 127;
    i = FFT_BLOCK_LENGTH - 1;
    test_scope[FFT_BLOCK_LENGTH_HALF - 1] = 0;

    //	for(x=63; x<128; x++)
    for (x = FFT_BLOCK_LENGTH_HALF; x < FFT_BLOCK_LENGTH; x++) // frequency scale corrected 7.3.2013
    {
        //		dta = intlog2(sample_i_buf[i--]) >> eeprom.defval.bandscope_mode;	// eeprom variable meaning changed to bandscope gain 05.05.2011
        dta = intlog2(sample_i_buf[i--]) >> 2; //bandscope_mode meaning changed to bandscope gain, 0=1, 1=0.5, 2=0.25, 3=0.125 4=0.0625 

        if (dta >= test_scope[x]) // uppdate display data
            test_scope[x] = dta;
        else {
            if (test_scope[x] > 0) // if not 0 then decay one step
                test_scope[x]--;
            if (test_scope[x] > 0) // if not 0 then decay one step
                test_scope[x]--;
        }
    }
}