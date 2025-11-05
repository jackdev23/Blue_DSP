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

#ifndef __DSPPROTOCOL_H__
#define __DSPPROTOCOL_H__ 

//REGISTERS DSP

#define DSP_Mute 							0x20
#define DSP_Noise_apply            			0x21
#define DSP_Noise_setNoiseReduction			0x22

#define DSP_EQU_apply 						0x30
#define DSP_EQU_MasterGain                  0x31
#define DSP_AutoNotch_apply                 0x32
#define DSP_Filter_apply                    0x33

#define DSP_EQU_31_BAND 					0x00 //0-18
#define DSP_EQU_62_BAND						0x01 //0-18
#define DSP_EQU_125_BAND					0x02 //0-18
#define DSP_EQU_250_BAND					0x03 //0-18
#define DSP_EQU_500_BAND					0x04 //0-18
#define DSP_EQU_1000_BAND					0x05 //0-18
#define DSP_EQU_2000_BAND					0x06 //0-18
#define DSP_EQU_4000_BAND					0x07 //0-18

#define DSP_FIL_filterSelect                0x10

//constants
#define DSP_parameters_change               0x40
#define DSP_WHAT_parameters                 0x41

#define DSP_FIL_300_2700					0x00
#define DSP_FIL_300_2400					0x01
#define DSP_FIL_300_1800					0x02
#define DSP_FIL_300_1500					0x03
#define DSP_FIL_300_1300					0x04
#define DSP_FIL_450_950						0x05
#define DSP_FIL_550_850						0x06

#define DSP_TRUE 					1
#define DSP_FALSE 					0
#endif	/* XC_HEADER_TEMPLATE_H */

