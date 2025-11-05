#include "encoder.h"
#include "timers.h"

void Init_QED(void) {


    QED_1A_tris = 1;
    QED_1B_tris = 1;
    Button1_tris = 1;

    RPINR14bits.QEA1R = 10; // Connect QEI1 QEA1 input rp10 pin 8 
    RPINR14bits.QEB1R = 11; // Connect QEI1 QEB1 input rp11 pin 9
    //RPINR15bits.INDX1R = 25;  // Connect QEI1 INDEX1 input rp12 pin 5

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
    POSCNT = 100;
    MAXCNT = 0xFFFF;
    //CNPU1bits.CN11PUE	=	1; /* Button1 */

    CNPU1bits.CN15PUE = 1; /* QED_1A PIN 9 */
    CNPU2bits.CN16PUE = 1; /* QED_1B PIN 8*/
    CNPU2bits.CN19PUE = 1; /* QED_1B PIN 5*/

    IFS3bits.QEI1IF = 0;
    IEC3bits.QEI1IE = 0;

}
