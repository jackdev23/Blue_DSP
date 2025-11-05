#include "timers.h"
#include "rotaryEncoder.h"
//TEST FREQ
//#define RED_LED         _LATC7  //PIN 4
//#define RED_LED_TRIS  TRISCbits.TRISC7

unsigned int millisCount;
/******************************************************************************
 * Function:       void Init_Timer1( void )
 *
 * PreCondition:   None
 *
 * Input:          None
 *
 * Output:         None
 *
 * Side Effects:   None
 *
 * Overview:       Initialize Timer1 for Period Interrupts
 *                 At 120MHz, Fcy = 60MHz or 16.666nS
 *                 With prescaler set to /64 one timer tick = 1.066uS
 *                 Configure for 12mS cycle --> PR1 = 11250
 *****************************************************************************/
//#define RED_LED         _LATC8  //PIN 4
//#define RED_LED_TRIS  TRISCbits.TRISC8
void Init_Timer1( void )
{
    //RED_LED_TRIS = 0; test freq

    T1CON = 0;          // Timer reset
    T1CONbits.TCKPS = TIMER_PRESCALER;// Set prescaler to /64
    IFS0bits.T1IF = 0;  // Reset Timer1 interrupt flag
    IPC0bits.T1IP = 4;  // Timer1 Interrupt priority level=1
    IEC0bits.T1IE = 1;  // Enable Timer1 interrupt
    TMR1 = 0x0000;
    PR1 = TIMER1_PERIOD;       // Timer1 period register - see macro
    T1CONbits.TON = 1;  // Enable Timer1 and start the counter
}
/******************************************************************************
 * Function:       void __attribute__((interrupt,no_auto_psv)) _T1Interrupt( void )
 *
 * PreCondition:   None
 *
 * Input:          None
 *
 * Output:         None
 *
 * Side Effects:   None
 *
 * Overview:       ISR ROUTINE FOR THE TIMER1 INTERRUPT
 *****************************************************************************/
void __attribute__((interrupt, no_auto_psv)) _T1Interrupt(void) {
    IFS0bits.T1IF = 0;
    T1CONbits.TON = 0;

    if (millisCount != 0) {
        millisCount--;
    }
    //PERIODIC = ~PERIODIC;
    //RED_LED ^=1;  //toggle TEST FREQ
    //Encoder1_Update(); // Get the latest encoder status
    TMR1 = 0;
    PR1 = TIMER1_PERIOD; // Timer1 period register - see macro
    T1CONbits.TON = 1;
    /* reset Timer 1 interrupt flag */
}
void set_delay_counter(unsigned int mils) {
    millisCount = mils;
}