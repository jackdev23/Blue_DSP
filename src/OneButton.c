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
#include "xc.h"
#include "../h/OneButton.h"
#include "../h/timers.h"


#define maxPeriod 2000 //max time to read switches

callbackFunction _clickFunc;
callbackFunction _doubleClickFunc;
callbackFunction _pressFunc;

callbackFunction _clickFuncS2;
callbackFunction _doubleClickFuncS2;
callbackFunction _pressFuncS2;

int _clickTicks; // number of ticks that have to pass by before a click is detected
int _pressTicks; // number of ticks that have to pass by before a lonn button press is detected

int _buttonReleased;
int _buttonPressed;
// These variables that hold information across the upcomming tick calls.
// They are initialized once on program start and are updated every time the tick function is called.
int _state;
unsigned int _startTime; // will be set in state 1
//unsigned long _startTimeS2; // will be set in state 1


// ----- Initialization and Default Values -----

void OneButtonSetUp() {

//    YELLOW_LED_TRIS = 0;
//    RED_LED_TRIS = 0;
//    GREEN_LED_TRIS = 0;
//
//    YELLOW_LED = LED_OFF;
//    RED_LED = LED_OFF;
//    GREEN_LED = LED_OFF;
    /* The LEDS and their ports	*/

    SWITCH_S1_TRIS = 1;
    SWITCH_S2_TRIS = 1;
    
    CNPU2bits.CN19PUE = 1; //  PIN 5 pull-up
    CNPU2bits.CN20PUE = 1; //  PIN 4 pull-up

    _clickTicks = 250; // number of millisec that have to pass by before a click is detected.
    _pressTicks = 1000; // number of millisec that have to pass by before a lonn button press is detected.

    _state = 0; // starting with state 0: waiting for button to be pressed

    // button connects ground to the pin when pressed.
    _buttonReleased = 1; // notPressed
    _buttonPressed = 0;

}


// explicitely set the number of millisec that have to pass by before a click is detected.

void setClickTicks(int ticks) {
    _clickTicks = ticks;
} // setClickTicks


// explicitely set the number of millisec that have to pass by before a lonn button press is detected.

void setPressTicks(int ticks) {
    _pressTicks = ticks;
} // setPressTicks


// save function for click event

void attachClick(callbackFunction newFunction) {
    _clickFunc = newFunction;
}
// save function for doubleClick event

void attachDoubleClick(callbackFunction newFunction) {
    _doubleClickFunc = newFunction;
} // attachDoubleClick

void attachPress(callbackFunction newFunction) {
    _pressFunc = newFunction;
} // attachPress

void attachClickS2(callbackFunction newFunction) {
    _clickFuncS2 = newFunction;
}
// save function for doubleClick event

void attachDoubleClickS2(callbackFunction newFunction) {
    _doubleClickFuncS2 = newFunction;
} // attachDoubleClick

void attachPressS2(callbackFunction newFunction) {
    _pressFuncS2 = newFunction;
} // attachPress

void tick(void) {
    // Detect the input information 
    int buttonLevel = SWITCH_S1; //	_RD8  digitalRead(_pin); // current button signal.
    int buttonLevelS2 = SWITCH_S2;
    unsigned int now = maxPeriod - millisCount; // current (relative) time in msecs.

    switch (_state) {
            // Implementation of the state machine
        case 0:
        { // waiting for menu pin being pressed.
            set_delay_counter(maxPeriod);
            if (buttonLevel == _buttonPressed) {
                _state = 1; // step to state 1
                _startTime = now; // remember starting time
            } else if (buttonLevelS2 == _buttonPressed) {
                _state = 21; // step to state 1
                _startTime = now; // remember starting time
            }

        }
            break;
        case 1:
        { // waiting for menu pin being released.
            if (buttonLevel == _buttonReleased) {
                _state = 2; // step to state 2

            } else if ((buttonLevel == _buttonPressed) && (now > _startTime + _pressTicks)) {
                if (_pressFunc) _pressFunc();
                _state = 6; // step to state 6

            } else {
                // wait. Stay in this state.
            } // if

        }
            break;
        case 2:
        { // waiting for menu pin being pressed the second time or timeout.
            if (now > _startTime + _clickTicks) {
                // this was only a single short click
                if (_clickFunc) _clickFunc();
                _state = 0; // restart.

            } else if (buttonLevel == _buttonPressed) {
                _state = 3; // step to state 3
            } // if

        }
            break;
        case 3:
        { // waiting for menu pin being released finally.
            if (buttonLevel == _buttonReleased) {
                // this was a 2 click sequence.
                if (_doubleClickFunc) _doubleClickFunc();
                _state = 0; // restart.
            } // if

        }
            break;
        case 6:
        { // waiting for menu pin being release after long press.
            if (buttonLevel == _buttonReleased) {
                _state = 0; // restart.
            } // if  

        } // if  
            break;

        case 21:
        { // waiting for menu pin being released.
            if (buttonLevelS2 == _buttonReleased) {
                _state = 22; // step to state 2

            } else if ((buttonLevelS2 == _buttonPressed) && (now > _startTime + _pressTicks)) {
                if (_pressFuncS2) _pressFuncS2();
                _state = 26; // step to state 6

            } else {
                // wait. Stay in this state.
            } // if

        }
            break;
        case 22:
        { // waiting for menu pin being pressed the second time or timeout.
            if (now > _startTime + _clickTicks) {
                // this was only a single short click
                if (_clickFuncS2) _clickFuncS2();
                _state = 0; // restart.

            } else if (buttonLevelS2 == _buttonPressed) {
                _state = 23; // step to state 3
            } // if

        }
            break;
        case 23:
        { // waiting for menu pin being released finally.
            if (buttonLevelS2 == _buttonReleased) {
                // this was a 2 click sequence.
                if (_doubleClickFuncS2) _doubleClickFuncS2();
                _state = 0; // restart.
            } // if

        }
            break;
        case 26:
        { // waiting for menu pin being release after long press.
            if (buttonLevelS2 == _buttonReleased) {
                _state = 0; // restart.
            } // if  

        } // if  
            break;
        default:break;
    }
} // OneButton.tick()

