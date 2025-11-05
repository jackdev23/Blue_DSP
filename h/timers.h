// This is a guard condition so that contents of this file are not included
// more than once.  
#ifndef __TIMERS_H__
#define	__TIMERS_H__

#include <../h/xc.h> // include processor files - each processor file is guarded.  
#define FCY 36864000UL//39936000UL						// 39,936 MHz

#define TIMER_PRESCALER_1       0
#define TIMER_PRESCALER_8       1
#define TIMER_PRESCALER_64      2
#define TIMER_PRESCALER_256     3
#define TIMER_PRESCALER TIMER_PRESCALER_256

#if TIMER_PRESCALER == TIMER_PRESCALER_1
#define TIMER_PRESCALER_VALUE 1
#elif TIMER_PRESCALER == TIMER_PRESCALER_8
#define TIMER_PRESCALER_VALUE 8
#elif TIMER_PRESCALER == TIMER_PRESCALER_64
#define TIMER_PRESCALER_VALUE 64
#elif TIMER_PRESCALER == TIMER_PRESCALER_256
#define TIMER_PRESCALER_VALUE 256
#endif

#define TIMER1_CYCLE_TIME 1e-3 //1mSec
#define TIMER1_PERIOD (FCY* TIMER1_CYCLE_TIME/ TIMER_PRESCALER_VALUE)

#define TIMER4_CYCLE_TIME 125e-6 //125uSec
#define TIMER4_PERIOD (FCY* TIMER4_CYCLE_TIME/ TIMER_PRESCALER_VALUE)


//extern unsigned int seconds; // free running second counter
extern unsigned int long_push; // long push timer, count from set value to zero, global visibility
extern unsigned int millisCount;
extern unsigned char ledConfiguration;

void Init_Timer1(void);
void set_delay_counter(unsigned int mils);

#endif	/* XC_HEADER_TEMPLATE_H */

