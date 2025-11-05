

// This is a guard condition so that contents of this file are not included
// more than once.  
#ifndef __ROTARYENCODER_H__
#define	__ROTARYENCODER_H__

#include <../h/xc.h>  

#define	int8 signed char                // AKA int8_t
#define	uint8 unsigned char             // AKA uint8_t
#define	int16 signed int                // AKA int16_t
#define	uint16 unsigned int             // AKA uint16_t
#define	int32 signed long int           // AKA int32_t
#define	uint32 unsigned long int        // AKA uint32_t
#define	int64 signed long long int      // AKA int64_t
#define	uint64 unsigned long long int   // AKA uint64_t

typedef enum eButtonState {NO_PRESS, PRESS} eButtonState;
typedef enum eButtonEvent {NONE, QUICK, EXTENDED} eButtonEvent;

typedef struct sEncoderData{
    int16 oldCount;
    int16 count;
    uint16 buttonCount;
    eButtonState buttonState;
    eButtonState oldButtonState;
}sEncoderData;

#define	QED_1A_tris			TRISBbits.TRISB10 //PIN 8
#define	QED_1B_tris			TRISBbits.TRISB11 //PIN 9

#define	Button1_tris		TRISBbits.TRISB9 //PIN 1
#define	Button1				PORTBbits.RB9


void 	Init_QED ( void );
 
// Functions
void Encoder1_Update();           // update encoder 1 status

int16 Encoder1Count(void);
void Encoder1CountZero(void);
eButtonState Encoder1ButtonEvent(void);
void Encoder1ButtonEventReset(void);

#ifdef	__cplusplus
extern "C" {
#endif /* __cplusplus */

    // TODO If C++ is being used, regular C code needs function names to have C 
    // linkage so the functions can be used by the c code. 

#ifdef	__cplusplus
}
#endif /* __cplusplus */

#endif	/* XC_HEADER_TEMPLATE_H */

