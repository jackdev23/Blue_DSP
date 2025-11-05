#include "rotaryEncoder.h"
#include "timers.h"

#define MENU_PRESS_DURATION 2
#define BUTTON_TICKS        ((unsigned int)(MENU_PRESS_DURATION/TIMER1_CYCLE_TIME))

sEncoderData encoder1Data;

void Init_QED(void) {
    QED_1A_tris = 1;
    QED_1B_tris = 1;
    Button1_tris = 1;

//    _QEA1R = 10; // Connect QEI1 QEA1 input rp10 pin 8 
//    _QEB1R = 11; // Connect QEI1 QEB1 input rp11 pin 9
//    _INDX1R = 9; // Connect QEI1 INDEX1 input rb9 pin 1
    
        RPINR14bits.QEA1R = 10; // Connect QEI1 QEA1 input rp10 pin 8 
        RPINR14bits.QEB1R = 11; // Connect QEI1 QEB1 input rp11 pin 9
        RPINR15bits.INDX1R = 9;  // Connect QEI1 INDEX1 input rp12 pin 5
    ////    RPINR15bits.INDX1R = 14;  // Connect QEI1 INDEX1 input rp14 pin 14

    QEICONbits.UPDN_SRC = 0;
    QEICONbits.TQCS = 0;
    QEICONbits.POSRES = 0;
    QEICONbits.TQCKPS = 0;
    QEICONbits.TQGATE = 0;
    QEICONbits.PCDOUT = 0;
    QEICONbits.SWPAB = 0;
    QEICONbits.QEIM = 7;
    QEICONbits.QEISIDL = 0;
    QEICONbits.CNTERR = 0;
    DFLTCONbits.QECK = 7; /* 1:256 clock divide */
    DFLTCONbits.QEOUT = 1; /* Filter outputs enabled */
    DFLTCONbits.CEID = 1; /* Count Error Interrupt disabled */
    DFLTCONbits.IMV = 0; /* Index matching (don't care) */
    POS1CNT = 100;
    MAX1CNT = 0xFFFF;
    //CNPU1bits.CN11PUE	=	1; /* Button1 */

    CNPU1bits.CN15PUE = 1; /* QED_1A PIN 9 */
    CNPU2bits.CN16PUE = 1; /* QED_1B PIN 8*/
    CNPU2bits.CN21PUE = 1; /* IDX PIN 1*/
    //CNPU1bits.CN12PUE = 1; /* QED_1B PIN 14*/

    IFS3bits.QEI1IF = 0;
    IEC3bits.QEI1IE = 0;

}

/*******************************************************************************
 * Encoder 1 Status updates the encoder rotation count and push button status.
 * The 16 detent rotary encoder changes 4 states per detent
 * The 12 detent rotary encoder changes 8 states per detent
 * The last 2 or 3 bits are masked (ignored) before testing for a position change.
 * The final count is /4 or /8 so that items increment once per detent.
 * The encoder and PB counts need to be cleared after use by other functions.
 * The push button count tells how long the button has been pressed.
 * IMPORTANT! The encoderDatax.count member is cumulative per ISR. You MUST
 * clear it after servicing the UI is finished
 *******************************************************************************/
void Encoder1_Update() {
    int16 encoder1_new;

    encoder1Data.oldButtonState = encoder1Data.buttonState;

    encoder1_new = (POS1CNT & 0xFFFC); // 16-detent read encoder1 position mask last two bits
    //encoder1_new = (POS1CNT & 0xFFF8); // 12-detent read encoder1 position mask last three bits
    if (encoder1_new != encoder1Data.oldCount) // if position has changed
    {

        encoder1Data.count += ((encoder1_new - encoder1Data.oldCount) >> 2); // 16-detent update new count
       // encoder1Data.count += ((encoder1_new - encoder1Data.oldCount) >> 3); // 12-detent update new count
        encoder1Data.oldCount = encoder1_new; // Store last read
    }

    if (!QEI1CONbits.INDX) //Don't care about state, just count
    {
        encoder1Data.buttonCount++;
    } else //Button not depressed so reset count
    {
        encoder1Data.buttonCount = 0;
        encoder1Data.buttonState = NONE;
    }

    if (encoder1Data.buttonCount) // If button is being pressed
    {
        if (encoder1Data.buttonCount > BUTTON_TICKS) // If button was held for defined duration
        {
            encoder1Data.buttonState = EXTENDED;
            //TODO cambia set opzioni
            encoder1Data.buttonCount = 0;
        } else // Button has a short duration press
        {
            encoder1Data.buttonState = QUICK;
        }
    }
}

int16 Encoder1Count(void) {
    return encoder1Data.count;
}

void Encoder1CountZero(void) {
    encoder1Data.count = 0;
}

eButtonState Encoder1ButtonEvent(void) {
    return encoder1Data.buttonState;
}

void Encoder1ButtonEventReset(void) {
    encoder1Data.buttonState = NONE;
}