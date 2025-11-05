/*******************************************************************************
Copyright 2015 Luca Facchinetti, IW2NDH
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
#ifndef __ONEBUTTON_H__
#define	__ONEBUTTON_H__

#include <xc.h> // include processor files - each processor file is guarded.  

// ----- Callback function types -----

/* The Switches and their ports */

#define SWITCH_S2_TRIS	 TRISCbits.TRISC8 //PIN 4
#define SWITCH_S1_TRIS	TRISCbits.TRISC9 //PIN 5

#define SWITCH_S2	 PORTCbits.RC8
#define SWITCH_S1	PORTCbits.RC9

typedef void (*callbackFunction)(void);


// ----- Constructor -----
void OneButtonSetUp();

// ----- Set runtime parameters -----

// set # millisec after single click is assumed.
void setClickTicks(int ticks);

// set # millisec after press is assumed.
void setPressTicks(int ticks);

// attach functions that will be called when button was pressed in th especified way.
void attachClick(callbackFunction newFunction);
void attachDoubleClick(callbackFunction newFunction);
void attachPress(callbackFunction newFunction);

// attach functions that will be called when button was pressed in th especified way.
void attachClickS2(callbackFunction newFunction);
void attachDoubleClickS2(callbackFunction newFunction);
void attachPressS2(callbackFunction newFunction);
// ----- State machine functions -----

// call this function every some milliseconds for handling button events.
void tick(void);


// These variables will hold functions acting as event source.
extern callbackFunction _clickFunc;
extern callbackFunction _doubleClickFunc;
extern callbackFunction _pressFunc;

extern callbackFunction _clickFuncS2;
extern callbackFunction _doubleClickFuncS2;
extern callbackFunction _pressFuncS2;

#endif	/* XC_HEADER_TEMPLATE_H */

