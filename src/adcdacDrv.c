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
#include <stdbool.h>

#include "p33fxxxx.h"
#include "dsp.h"
#include "../h/adcdacDrv.h"
#include "../h/ns_api.h"
#include "../h/FIR.h"
#include "../h/FIR_Filter.h"
#include "../h/f550_850cw.h"
#include "../h/f300_1800.h"
#include "../h/f300_2100.h"
#include "../h/f300_2400.h"
#include "../h/highpass.h"


extern unsigned char applyNS; /* Indicates if NS should be ON or OFF		*/
extern unsigned char squelch;
//extern int peakValue;

/* Noise Suppression module variables		*/
int nsStateMemX [NS_XSTATE_MEM_SIZE_INT] _XBSS(4);
int nsScratchMemX [NS_XSCRATCH_MEM_SIZE_INT] _XBSS(4);
int nsScratchMemY [NS_YSCRATCH_MEM_SIZE_INT] _YBSS(512);

//SQUELCH
int nsStateMemXSq [NS_XSTATE_MEM_SIZE_INT] _XBSS(4);
fractional signalDENOISESq[NUMSAMP];

const int level[noiseLevels] = {11, 15, 17, 20};//{9, 11, 13, 15, 17, 20}; // 24, 35};
unsigned char nsLevelIdx = 0; /* Selected NS Level			DEEaddr2			*/
//fractional pOutData[NUMSAMP] __attribute__ ((space(xmemory),far,aligned(CHUNK)));
//fractional signalDENOISE[NUMSAMP] __attribute__((space(xmemory), far, aligned(CHUNK)));

extern fractional* FIRLMS2(int, fractional*, fractional*, FIRStruct*, fractional*, fractional);

FIRStruct FIRfilter;
unsigned int LMSmu = 127;

FIRFilterStructure filterSelected;

int overloadInput;
int overloadOutput;
int maxIndex;
int minIndex;
extern fractional VectorMax(int numElems, fractional* srcV, int* maxIndex);
extern fractional VectorMin(int numElems, fractional* srcV, int* minIndex);

int i;
fractional signalDENOISE[NUMSAMP];

static fractional BufferA[NUMSAMP] __attribute__((space(dma))); // Ping-pong buffer A
static fractional BufferB[NUMSAMP] __attribute__((space(dma))); // Ping-pong buffer B

//#define LMS_SIZE 80
//#define MAX_FIR 128
//#define PROC_BLOCK_SIZE 80	//size of data processing block 256
//
//static fractional DelayBufI[MAX_FIR] __attribute__((__section__(".ybss")));
//static fractional LMSCoef[LMS_SIZE] __attribute__((__section__(".xbss")));
//static FIRStruct FIRFilterI;
//static fractional pIBufNoise[PROC_BLOCK_SIZE];
//
//unsigned int LMSmuNoise;
//
//void ProcLMS( fractional* pIn, fractional* pOut)
//{
//	FIRLMS( PROC_BLOCK_SIZE, pOut, pIn, &FIRFilterI, pIBufNoise, LMSmuNoise);
//	VectorCopy(PROC_BLOCK_SIZE, pIBufNoise, pIn);	//create delayed copy of input
//}
//void initLMS() {
//    FIRStructInit(&FIRFilterI, LMS_SIZE, LMSCoef, COEFFS_IN_DATA, DelayBufI);
//    for (i = 0; i < LMS_SIZE; i++)
//        LMSCoef[i] = 0;
//    FIRDelayInit(&FIRFilterI);
//    LMSmuNoise = 10;
//}

void selectFilter(unsigned char _filterIdx) {

    switch (_filterIdx) {
        case 0:
            filterSelected = highpassFilter;
            break;
        case 1:
            filterSelected = f300_2400Filter;
            break;
        case 2:
            filterSelected = f300_2100Filter;
            break;
        case 3:
            filterSelected = f300_1800Filter;
            break;
        case 4:
            filterSelected = f550_850cwFilter;
            break;
        default:
            filterSelected = highpassFilter;
            break;
    }
    FIRFilterInit(&filterSelected);
}

void changeNoiseLevel(unsigned char _nsLevelIdx) {
    NS_setNoiseReduction(nsStateMemX, level[_nsLevelIdx]);
}

void initAdc(void) {
    // initLMS();
    NS_init(nsStateMemX, nsScratchMemX, nsScratchMemY); /* Initialise the Noise Suppression module	*/
    changeNoiseLevel(nsLevelIdx);
    //SQUELCH
    NS_init(nsStateMemXSq, nsScratchMemX, nsScratchMemY); /* Initialise the Noise Suppression module	*/

    NS_setNoiseReduction(nsStateMemXSq, 15);
        NS_setNoiseEstimationFactor(nsStateMemXSq,NS_SLOW);
    NS_setVadHangover(nsStateMemXSq, NS_TRUE, 90);
    //    changeSquelchLevel(3);

    FIRStructInit(&FIRfilter, NY, coeffecients, 0xFF00, z);
    FIRDelayInit(&FIRfilter);

    selectFilter(0);
    AD1CON1bits.FORM = 3; // Data Output Format: Signed Fraction (Q15 format)
    AD1CON1bits.SSRC = 2; // Sample Clock Source: GP Timer starts conversion
    AD1CON1bits.ASAM = 1; // ADC Sample Control: Sampling begins immediately after conversion
    AD1CON1bits.AD12B = 1; // 12-bit ADC operation

    AD1CON2bits.CHPS = 0; // Converts CH0

    AD1CON3bits.ADRC = 0; // ADC Clock is derived from Systems Clock
    AD1CON3bits.ADCS = 3; // ADC Conversion Clock Tad=Tcy*(ADCS+1)= (1/40M)*4 = 100ns
    // ADC Conversion Time for 12-bit Tc=14*Tad = 1.4us

    AD1CON1bits.ADDMABM = 1; // DMA buffers are built in conversion order mode
    AD1CON2bits.SMPI = 0; // SMPI must be 0


    //AD1CHS0: A/D Input Select Register
    AD1CHS0bits.CH0SA = 0; // MUXA +ve input selection (AN4) for CH0
    AD1CHS0bits.CH0NA = 0; // MUXA -ve input selection (Vref-) for CH0

    //AD1PCFGH/AD1PCFGL: Port Configuration Register
    AD1PCFGL = 0xFFFF;
    AD1PCFGLbits.PCFG0 = 0; // AN4 as Analog Input


    IFS0bits.AD1IF = 0; // Clear the A/D interrupt flag bit
    IEC0bits.AD1IE = 0; // Do Not Enable A/D interrupt
    AD1CON1bits.ADON = 1; // Turn on the A/D converter	
}

/*=============================================================================
initDac() is used to configure D/A. 
=============================================================================*/
//void initDac(void) {
//    /* Initiate DAC Clock */
//    ACLKCONbits.SELACLK = 0; // FRC w/ Pll as Clock Source
//    ACLKCONbits.AOSCMD = 0; // Auxiliary Oscillator Disabled
//    ACLKCONbits.ASRCSEL = 0; // Auxiliary Oscillator is the Clock Source
//    ACLKCONbits.APSTSCLR = 7; // Fvco/1 = 158.2 MHz/1 = 158.2 MHz
//
//    DAC1STATbits.ROEN = 1; // Right Channel DAC Output Enabled
//    DAC1DFLT = 0x8000; // DAC Default value is the midpoint
//
//    DAC1CONbits.DACFDIV = 71; // MOD 8KHZ
//
//    DAC1CONbits.FORM = 1; // Data Format is signed integer
//    DAC1CONbits.AMPON = 0; // Analog Output Amplifier is enabled during Sleep Mode/Stop-in Idle mode
//
//    DAC1CONbits.DACEN = 1; // DAC1 Module Enabled
//}

/*=======================================================================================  
Timer 3 is setup to time-out every Ts secs. As a result, the module 
will stop sampling and trigger a conversion on every Timer3 time-out Ts. 
At that time, the conversion process starts and completes Tc=12*Tad periods later.
When the conversion completes, the module starts sampling again. However, since Timer3 
is already on and counting, about (Ts-Tc)us later, Timer3 will expire again and trigger 
next conversion. 
=======================================================================================*/
void initTmr3() {
    TMR3 = 0x0000; // Clear TMR3
    PR3 = SAMPPRD; // Load period value in PR3
    IFS0bits.T3IF = 0; // Clear Timer 3 Interrupt Flag
    IEC0bits.T3IE = 0; // Clear Timer 3 interrupt enable bit
    T3CONbits.TON = 1; // Enable Timer 3
}

/*=============================================================================  
DMA0 configuration
 Direction: Read from peripheral address 0-x300 (ADC1BUF0) and write to DMA RAM 
 AMODE: Register indirect with post increment
 MODE: Continuous, Ping-Pong Mode
 IRQ: ADC Interrupt
 ADC stores results stored alternatively between BufferA[] and BufferB[]
=============================================================================*/
void initDma0(void) {
    DMA0CONbits.AMODE = 0; // Configure DMA for Register indirect with post increment
    DMA0CONbits.MODE = 2; // Configure DMA for Continuous Ping-Pong mode

    DMA0PAD = (int) &ADC1BUF0; // Peripheral Address Register: ADC buffer
    DMA0CNT = (NUMSAMP - 1); // DMA Transfer Count is (NUMSAMP-1)

    DMA0REQ = 13; // ADC interrupt selected for DMA channel IRQ

    DMA0STA = __builtin_dmaoffset(BufferA); // DMA RAM Start Address A
    DMA0STB = __builtin_dmaoffset(BufferB); // DMA RAM Start Address B

    IFS0bits.DMA0IF = 0; // Clear the DMA interrupt flag bit
    IEC0bits.DMA0IE = 1; // Set the DMA interrupt enable bit

    DMA0CONbits.CHEN = 1; // Enable DMA channel
}

/*=============================================================================
_DMA0Interrupt(): ISR name is chosen from the device linker script.
=============================================================================*/
static int DmaBuffer = 0;
int volatile flag = 0;
fractional pInData[NUMSAMP] __attribute__((space(xmemory), far, aligned(CHUNK)));
fractional pIBuf[NUMSAMP] __attribute__((space(xmemory), far, aligned(CHUNK)));
fractional pIBufLMS[NUMSAMP] __attribute__((space(xmemory), far, aligned(CHUNK)));

static fractional *buffer[] = {BufferA, BufferB}; // Index buffer as buffer[a_or_b][sample]
int speechHistory[100];

void __attribute__((interrupt, no_auto_psv)) _DMA0Interrupt(void) {

    VectorMax(NUMSAMP, (fractional*) & buffer[DmaBuffer][0], &maxIndex);
    VectorMin(NUMSAMP, (fractional*) & buffer[DmaBuffer][0], &minIndex);

    if ((buffer[DmaBuffer][maxIndex] > 16000) || (buffer[DmaBuffer][minIndex] < -16000))overloadInput = 1;
    else overloadInput = 0;

    //    if (applyFilter) {
    BlockFIRFilter(&filterSelected, (int *) &buffer[DmaBuffer][0], (int *) pInData, NUMSAMP);
    //    } else
    //        VectorCopy(NUMSAMP, pInData, &buffer[DmaBuffer][0]);


    //AutoNotch
    //    if (AutoNotch) {
    //   // ProcLMS(pInData,signalDENOISE);
    FIRLMS2(NUMSAMP, signalDENOISE, pInData, &FIRfilter, pIBuf, LMSmu);
    VectorCopy(NUMSAMP, pIBuf, pInData); // Copy of frame to be used as delayed frame reference for next block LMS call
    //    } else {
    //        VectorCopy(NUMSAMP, signalDENOISE, pInData);
    //    }

    NS_apply(nsStateMemX, signalDENOISE, applyNS);

    //SQUELCH
    VectorCopy(NUMSAMP, signalDENOISESq, signalDENOISE);
    NS_apply(nsStateMemXSq, signalDENOISESq, 1);
    if (squelch && !NS_getIsSpeech(nsStateMemXSq)) {
        for (i = 0; i < NUMSAMP; i++) {
            signalDENOISE[i] = 0;
        }
    }
    VectorMax(NUMSAMP, signalDENOISE, &maxIndex);
    VectorMin(NUMSAMP, signalDENOISE, &minIndex);
    //peakValue = signalDENOISE[maxIndex] - signalDENOISE[minIndex];
    if ((signalDENOISE[maxIndex] > 16000) || (signalDENOISE[minIndex] < -16000))overloadOutput = 1;
    else overloadOutput = 0;
    DmaBuffer ^= 1; // Ping-pong buffer select flag
    flag = 1; // Ping-pong buffer full flag
    IFS0bits.DMA0IF = 0; // Clear the DMA0 Interrupt Flag
    //            fractional pitch = dywapitch_computepitch( signalDENOISE, 64);
    //            Nop();
}

/*=============================================================================
_DAC1RInterrupt(): ISR name is chosen from the device linker script.
=============================================================================*/
//void __attribute__((interrupt, no_auto_psv)) _DAC1RInterrupt(void) {
//    IFS4bits.DAC1RIF = 0; // Clear Right Channel Interrupt Flag
//}

fractional RightBufferA[NUMSAMP]__attribute__((space(dma)));
fractional RightBufferB[NUMSAMP]__attribute__((space(dma)));
fractional LeftBufferA[NUMSAMP]__attribute__((space(dma)));
fractional LeftBufferB[NUMSAMP]__attribute__((space(dma)));
static fractional *bufferDac[] = {RightBufferA, RightBufferB}; // Index buffer as buffer[a_or_b][sample]

void dacInit1() {
    /* Initiate DAC Clock */
    ACLKCONbits.SELACLK = 0; // FRC w/ Pll as Clock Source
    ACLKCONbits.AOSCMD = 0; // Auxiliary Oscillator Disabled
    ACLKCONbits.ASRCSEL = 0; // Auxiliary Oscillator is the Clock Source
    ACLKCONbits.APSTSCLR = 7; // Fvco/1 = 158.2 MHz/1 = 158.2 MHz


    /* DMA Channel 0 set to DAC1RDAT */
    DMA2CONbits.AMODE = 0;
    DMA2CONbits.MODE = 2;
    DMA2CONbits.DIR = 1;
    /* Register Indirect with Post Increment */
    /* Continuous Mode with Ping-Pong Enabled */
    /* Ram-to-Peripheral Data Transfer */
    DMA2PAD = (volatile unsigned int) &DAC1RDAT; /* Point DMA to DAC1RDAT */
    DMA2CNT = NUMSAMP - 1;
    DMA2REQ = 78;
    DMA2STA = __builtin_dmaoffset(RightBufferA);
    DMA2STB = __builtin_dmaoffset(RightBufferB);
    IFS1bits.DMA2IF = 0;
    IEC1bits.DMA2IE = 1;
    /* 32 DMA Request */
    /* Select DAC1RDAT as DMA Request Source */
    /* Clear DMA Interrupt Flag */
    /* Set DMA Interrupt Enable Bit */
    DMA2CONbits.CHEN = 1;
    /* DMA Channel 1 set to DAC1LDAT */
    DMA1CONbits.AMODE = 0;
    DMA1CONbits.MODE = 2;
    DMA1CONbits.DIR = 1;
    /* Enable DMA Channel 0 */
    /* Register Indirect with Post Increment */
    /* Continuous Mode with Ping-Pong Enabled */
    /* Ram-to-Peripheral Data Transfer */
    DMA1PAD = (volatile unsigned int) &DAC1LDAT; /* Point DMA to DAC1LDAT */
    DMA1CNT = NUMSAMP - 1;
    DMA1REQ = 79;
    DMA1STA = __builtin_dmaoffset(LeftBufferA);
    DMA1STB = __builtin_dmaoffset(LeftBufferB);
    IFS0bits.DMA1IF = 0;
    IEC0bits.DMA1IE = 1;
    DMA1CONbits.CHEN = 1;
    /* DAC1 Code */
    DAC1STATbits.ROEN = 1;
    DAC1STATbits.LOEN = 0;
    DAC1DFLT = 0x8000; // DAC Default value is the midpoint
    DAC1STATbits.RITYPE = 1;
    DAC1STATbits.LITYPE = 1;
    DAC1CONbits.AMPON = 0;
    DAC1CONbits.DACSIDL = 0; //idle mode
    DAC1CONbits.DACFDIV = 71; //https://ww1.microchip.com/downloads/en/DeviceDoc/70211B.pdf page 8 /VALUE 71
    DAC1CONbits.FORM = 1; //= Signed integer
    DAC1CONbits.DACEN = 1;
}

void __attribute__((interrupt, no_auto_psv))_DMA2Interrupt(void) {
    IFS1bits.DMA2IF = 0; /* Clear DMA Channel 0 Interrupt Flag */
    /* User Code to update Right Buffer in DMA*/
    VectorCopy(NUMSAMP, &bufferDac[DmaBuffer][0], signalDENOISE);
}

void __attribute__((interrupt, no_auto_psv))_DMA1Interrupt(void) {
    IFS0bits.DMA1IF = 0; /* Clear DMA Channel 1 Interrupt Flag */
    /* User Code to update Left Buffer in DMA */
}
