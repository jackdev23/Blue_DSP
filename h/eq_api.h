/**********************************************************************
* © 2011 Microchip Technology Inc.
*
* FileName:        eq_api.h
* Dependencies:    Header (.h) files if applicable, see below
* Processor:       dsPIC33Fxxxx
* Compiler:        MPLAB® C30 v3.30 or higher
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
* certify, or support the code.*/
/**************************************************************************************/
#ifndef __EQ_API_H__
#define __EQ_API_H__

#define EQ_FALSE                0
#define EQ_TRUE                 1

#define EQ_FRAME                80
#define EQ_DEFAULT_MASTER_GAIN  0

#define EQ_MAX_MASTER_GAIN			12
#define EQ_MAX_BAND_ATTEN			18
#define EQ_NO_FREQS             8

#define EQ_32_BAND		0
#define EQ_62_BAND		1
#define EQ_125_BAND		2
#define EQ_250_BAND		3
#define EQ_500_BAND		4
#define EQ_1000_BAND	5
#define EQ_2000_BAND	6
#define EQ_4000_BAND	7

#define EQ_YSTATE_MEM_SIZE_INT  (EQ_NO_FREQS * 5)
#define EQ_XSTATE_MEM_SIZE_INT  (EQ_YSTATE_MEM_SIZE_INT + 4)


void EQ_init(int* ptrStateX, int* ptrStateY);

void EQ_apply(int* ptrStateX, int* ptrStateY, int* signalIn, int enable);

void EQ_setGain(int* ptrStateX, char* gains);

void EQ_setMasterGain(int* ptrStateX, int input_gain);

void EQ_getGain(int* ptrStateX, char* gains);

int EQ_getMasterGain(int* ptrStateX);


#endif
