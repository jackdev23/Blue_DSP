  
#ifndef NUE_PSK_CW_H
#define	NUE_PSK_CW_H


typedef unsigned int uint;
typedef unsigned char uchar;

#define PI2 6.2831853071795864765
#define KCONV 10430.37835              /* 		4096*16/PI2 			*/
#define KF 159.1549
#define Sample_Frequency 8000.0

//DIT DAH encoding
#define DIT 1
#define DAH 2  
    
    //MARK group buffer status (c_flag)
#define PRINT_NONE 0	//AD7JT
#define PRINT_CHAR 1	//AD7JT
#define PRINT_SPACE 2	//AD7JT
#define PRINT_OVR 3		//AD7JT
#define PRINT_DLE 4		//AD7JT

#define CANCEL 0x18		//AD7JT
#define CWBWAINDEXMAX 8	//AD7JT
#define CWCURSORMAX 64	//AD7JT

#define WPMMAX 50
#define WPMMIN 5 
    
  #define DELTAFREQ 15.625
 
    
typedef struct{
	char c_flag;
	char mark_count;
	char write_char;
	char sec_char;
	char marks[8];
} markBuffer;


#endif	/* XC_HEADER_TEMPLATE_H */

