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

#ifndef __NS_API_H__
#define __NS_API_H__

#define NS_FALSE 						  0
#define NS_TRUE 						  1
#define NS_SLOW 						100
#define NS_NORMAL 						200
#define NS_FAST 						300
#define NS_FRAME   					  	 80
#define NS_XSTATE_MEM_SIZE_INT   	    384
#define NS_XSCRATCH_MEM_SIZE_INT 	     50
#define NS_YSCRATCH_MEM_SIZE_INT   	    128

#define NS_NRLEVELDEFAULT 				 15
#define NS_POWERFACTORDEFAULT			  2
#define NS_VADHANGOVERDEFAULT 			  6
#define NS_NOISEFLOORDEFAULT	   0x1D1917

void NS_init(int* ptrStateX, int* xScratchMem,int * yScratchMem);
void NS_relocateXScratchMem(int* ptrStateX, int* xScratchMem);
void NS_relocateYScratchMem(int* ptrStateX, int* yScratchMem);
void NS_apply(int* ptrStateX, int* signalIn, int enable);

void NS_setNoiseReduction(int* ptrStateX, int leveldB);
int  NS_getNoiseReduction(int* ptrStateX);

void NS_setVadHangover(int* ptrStateX, int enable, int value);
int  NS_getVadHangover(int* ptrStateX);

void NS_setNoiseFactor(int* ptrStateX, int value);
int  NS_getNoiseFactor(int* ptrStateX);

void NS_setNoiseEstimationFactor(int* ptrStateX, int level);
int  NS_getNoiseEstimationFactor(int* ptrStateX);

void NS_setNoiseFloor(int* ptrStateX, long floor);
long NS_getNoiseFloor(int* ptrStateX);

int NS_getIsSpeech(int* ptrStateX);

int NS_estimateSNR(int* preNS, int* postNS);

#endif
