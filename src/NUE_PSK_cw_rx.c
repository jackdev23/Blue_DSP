
/****************************************
 *		NUE_PSK_cw_rx.c					*
 *										*
 *		David M.Collins	AD7JT			*
 *		Began On:		03/24/2011		*
 *		Current Date:	12/05/2011		*
 *										*
 ****************************************/

#include <stdio.h>
#include <math.h>
#include "dsp.h"
#include "../h/NUE_PSK_cw.h"

double	NCO_Frequency		=	1500.0;
	double	Old_Freq;
	double	m_TxFreq;
/* * * * *  C W   R E C E I V E   S U P P O R T   F U N C T I O N S   * * * *
 *																			*
 *																			*
 ****************************************************************************/
#define SIZE 32
#define SBSIZE 10
#define MARK  1
#define SPACE 0
#define ON    1
#define OFF   0
#define START 0
#define FINISH 1
#define CHAR_SP_MAX 60
#define CHAR_SP_MIN 16
#define WORD_SP_MAX 120
#define WORD_SP_MIN 32
#define SKEW_MAX_MAX 6
#define SKEW_MAX_MIN 2	


/* * * * * * *  F U N C T I O N   D E C L A R A T I O N S  * * * * * * */
void 	char_print(volatile markBuffer *mbuf);
void 	wpm_func(void);
void	mark_func(void);
void	space_func(void);
void 	display(void);
void 	display_value(int v);
void 	adjust_sel(int delta);
void 	genOverlayFont(char c, int row, int col);
void 	genOverlayString(char* s, int row, int col);

void 	Write_String_Positioned_LCD1_Display ( uchar xposition, uchar yposition, char *string );
void 	display_LCD_buffer(void);

/* * * * * * * * * * * * * *  E X T E R N S  * * * * * * * * * * * * * */
extern int CWKey;			// Received key function MARK => key down
extern int dfs;
extern char date_prompt[3][13];
	

/* * * * * * * * * * * * * *  G L O B A L S  * * * * * * * * * * * * * */
int 	cw_state;			// = MARK or SPACE
volatile int rx_wpm;		// current receive wpm, 0 => not calculated
int		char_mul = 20;		// inter-character SPACE = (char_mul * dit_msec)/10
int		word_mul = 50;			// inter-word      SPACE = (word_mul * dit_msec)/10
int		skew_max;			// maxumum number of equal (+/- 1/8) MARKs to process
uchar	write_char;			// (first) character to be displayed	
uchar	sec_char;			// second part of a prosign	
int 	rx_sel;				// last update rx parameters selection
markBuffer rxMarkBuffers[2];

/* * * * * * * * * * * * * *   L O C A L S   * * * * * * * * * * * * * */
int 	count_save;			// save of new LCD_buffer position pointer

int		buffsel;			// selects buffer baeing loaded	
	
int		sp_msec;			// duration of current/last SPACE	
int		sp_c_buffer[SBSIZE];// buffered SPACE durations	
int		sp_ptr;				// index to next buffered SPACE duration
int		sp_sum;				// sum of the contents of the space_buffer	

int		mark_msec;			// duration of current/last MARK	
int		mark_skew_count;	// number of consecutive same elements
int		mark_stack[SIZE];	// buffered MARK durations 	
int		mark_ptr;			// index to next buffered MARK duration
long	mark_avg;			// average of the contents of the mark_stack	
int		mark_fence;			// duration threshold between DITs and DAHs	
	
int		md_mark_stack[SIZE];// buffered MARK duration mean deviations	
int		md_mark_ptr;		// index to next buffered MARK duration mean deviation
long	md_mark_avg;		// average of the contents of md_ptr

/*************************************************************************
 *			G O E R T Z E L  F I L T E R   P R O C E S S I N G           *
 *************************************************************************/
// The Goretzel sample block size determines the CW bandwidth as follows:
// CW Bandwidth :  100, 125, 160, 200, 250, 400, 500, 800, 1000 Hz.
int		cw_bwa[] = {80,  64,  50,  40,  32,  20,  16,  10,    8};
int		cw_bwa_index = 3;
int		cw_n =  40; // Number of samples used for Goertzel algorithm
				
double	cw_f = 796.8750;		// CW frequency offset (start of bin)
double	g_coef = 1.6136951071;	// 2*cos(PI2*(cw_f+7.1825)/SAMPLING_RATE);
double  q0=0, q1=0, q2=0, current;
int		g_t_lock = 0;			// Goertzel threshold lock
int		cspm_lock = 0;			// Character SPace Multiple lock
int		wspm_lock = 0;			// Word SPace Multiple lock
int 	g_sample_count = 0;
double 	g_sample; 
double	g_current;
double	g_scale_factor = 1000.0;
volatile long	g_s, g_ra = 10000, g_threshold = 1000;
volatile int	do_g_ave = 0;
int		g_dup_count = 0;		
int 	preKey;

void do_goertzel(fractional f_samp){
	extern int RXKey, last_trans;

	g_sample = (((double)f_samp)/32768.0);	
	q0 = g_coef*q1 - q2 + g_sample;
	q2 = q1;
	q1 = q0;
	
	if( (++g_sample_count >= cw_n)){
		g_sample_count = 0;
		cw_n = cw_bwa[cw_bwa_index];
		g_current = q1*q1 + q2*q2 - q1*q2*g_coef; 	// ~ energy^2
		q2 = 0;
		q1 = 0;
		g_s = (long)(g_current*g_scale_factor);	//scale and convert to long
		preKey = (g_s > g_threshold) ? 1 : 0;		//sample MARK or SPACE?
		if(preKey == RXKey){		//state transition? 
			last_trans = 0;			//no, clear timer
			g_dup_count++;			//and count duplicate
		}else{
			g_dup_count = 0;		//yes, clear duplicate count
									//and let timer run
		}
		//Change receive "key" if last change was over 15 clocks ago.
		//This adds some of latency but should not have a major
		//affect on durations.
		if(last_trans > 15){
			RXKey = preKey;
			last_trans = 0;
		}
		//add sample to running average if no change in 3 samples	
		if(g_dup_count > 3){
			do_g_ave = 1;
			g_ra = (999*g_ra + g_s)/1000;
		}
		if(g_t_lock){
			g_ra = g_threshold;
		}else{	 
			g_threshold = g_ra > 200 ? g_ra : 200;	
		}		
	}
}	
/*************************************************************************
 *    I N I T I A L I Z E   C W   F R E Q U E N C Y   E L E M E N T S    *
 *																		 *
 *	Recomputes CW receive and transmit variables.  Should be called each *
 *	time a frequency change is made in CW mode.
 *************************************************************************/
void cw_set_freq(void){
//	extern double m_PSKPhaseInc;
	
//	m_PSKPhaseInc = PI2 * m_TxFreq/8000.;			// Tx frequency
	//CPSKInitDet();											// Rx frequency & AGC limits
	g_coef = 2*cos(PI2*(NCO_Frequency+7.1825)/8000.);// Goertzel coefficient
}	

extern markBuffer keyerBuffer;
/*************************************************************************
 *			I N I T I A L I Z E   C W   R X   E L E M E N T S            *
 *************************************************************************/
void init_cw_rx(void){
	extern int 	tx_wpm, usbblock;

	extern int	RXKey;
	extern int 	cursor_position;
	//extern double m_PSKPhaseInc;

	extern markBuffer *mainRxPtr;
	//extern markBuffer keyerBuffer;
	
	int			i, temp, sp_avg;	
	

	CWKey = 0;
	RXKey = 0;
	//keyerBuffer.c_flag 		= PRINT_NONE;
	rxMarkBuffers[0].c_flag = PRINT_NONE;
	rxMarkBuffers[1].c_flag = PRINT_NONE;
	temp = (WPMMIN <= tx_wpm && tx_wpm <= WPMMAX) ? tx_wpm : 20;
	sp_avg	 = 1200 / temp;
	mark_avg = 1200 / temp;
	for(i = 0; i < SIZE; i++){
		mark_stack[i] 		=  mark_avg;	// DITs - preload buffers to set average
		md_mark_stack[i++] 	= -mark_avg;
		mark_stack[i]		=  mark_avg*3;	// DAHs - preload buffers to set average
		md_mark_stack[i]	=  mark_avg;
	}
	sp_sum = SBSIZE * sp_avg;
	for(i = 0; i < SBSIZE; i++){
		sp_c_buffer[i]		= sp_avg;
	}	
	mark_avg *= 2;
	mark_fence 			= mark_avg;		// note:  mean deviation = 0 here
	mark_skew_count 	= 0;
	mark_ptr 			= 0;
	md_mark_ptr 		= 0;
	sp_ptr 				= 0;
	for(i = 0; i < 8; i++)	{	//clear out dit-dah buffer
		rxMarkBuffers[0].marks[i] = NULL;
		rxMarkBuffers[1].marks[i] = NULL;
    }
    mainRxPtr = NULL;
	rxMarkBuffers[0].mark_count = 0;
	rxMarkBuffers[1].mark_count = 0;
	buffsel = 0;

	//set transmit and receive carrier frequencies	
	if(NCO_Frequency > 1500.0){
		NCO_Frequency = 1500.00;
	}	
	cw_set_freq();
	
//	cursor_position = (int)((NCO_Frequency/DELTAFREQ) + 0.5)-32;
//	Clear_Cursor();
//	Display_Cursor(cursor_position);
//	usbblock = 0;				/* AD7JT */
}	 
	 
/* * * * * * * * *   A D J U S T   R X   P A R A M E T E R S   * * * * * * * * *
*
*	This routine processes key presses in RX state.  In all cases, when
*	one of the hot keys is pressed, a status display is shown in the upper
*	right corner of the LCD screen.  The display generally identifies the
*	parameter selected, its current value, and the allowed range for its
*	value.  The value may be changed by the operator using the '+' and '-'
*	keys to increase and decrease the parameter value.  The value will be
*	constrained to stay in the value range shown.  The operator may select
*	a different parameter at any time by pressing and releasing the assigned
*	hot key.  Pressing the Enter key will clear the parameter display.
*
*	The receive operation continues while parameters are displayed and
*	changed.  Changes occur in real time and take affect immediatley.  Some
*	parameters are static (under total operator control), others are dynamic
*	(under total control by the operator), and some are both.  The parameters
*	and their properties are listed in comments in the following routine.
* 	Value ranges are included in the LCD display where appropriate.
*	
*	This routine is also used in all RX operating modes (both CW and non-CW)
*	to display and edit MY CALL, THEIR CALL, and SERIALNO.  This allows an in-process
*	receive operation to continue with the receive data visible to the 
*	operator while entering new call information or incrementing/decrementing the
*	serial number.
*/
//			COL:	 11111111112
//					 01234567890
#define DATE_HDR	"RTCC Date: "
#define TIME_HDR	"RTCC Time:	"
#define FILE_HDR	"File Name: "
#define CHAR_HDR    "Char:      "
#define WORD_HDR	"Word:      "
#define SKEW_HDR    "Zkew:      "
#define THRS_HDR	"Th:     00 "
#define TC_HDR		"Their Call:"
#define MC_HDR		"My Call:   "
#define SN_TC_HDR	"S/N:       "
#define SN_FTR		"- - - - - -"
#define CWBW_HDR	"    CW BW: "
extern int doDisplay;
char inputBuff[14] = "";
int serial_no = 1;
int N_pointer = 0;

void processRxKeys(void){

}		

void genOverlayFont(char c, int row, int col){

}

void genOverlayString(char* s, int row, int col){
	
}

void genMinMaxString(int min, int max, int fractions){
		
}			

void display_number(long n, int exp, int col, int row){

}

void display_decimal(int n){

}				

void display(){

}

void adjust_sel(int delta){
	switch(rx_sel)
	{
		case 'B':
			cw_bwa_index += delta;
			if(cw_bwa_index < 0) cw_bwa_index = 0;
			if(cw_bwa_index > CWBWAINDEXMAX) cw_bwa_index = CWBWAINDEXMAX;
			break;
		case 'C':
			char_mul += delta;
			cspm_lock = 1;
			if(char_mul < CHAR_SP_MIN) char_mul = CHAR_SP_MIN;
			if(char_mul > CHAR_SP_MAX) char_mul = CHAR_SP_MAX;
			if(word_mul < char_mul + 5) word_mul = char_mul + 5;
			break;
		case 'W':
			word_mul += delta;
			wspm_lock = 1;
			if(word_mul < char_mul + 5) word_mul = char_mul + 5;
			if(word_mul > WORD_SP_MAX) word_mul = WORD_SP_MAX;
			break;
		case 'Z':
			skew_max += delta;
			if(skew_max < SKEW_MAX_MIN) skew_max = SKEW_MAX_MIN;
			if(skew_max > SKEW_MAX_MAX) skew_max = SKEW_MAX_MAX;
			break;
		case 'G':
			g_threshold += (g_threshold > 10000) ? 1000*delta : 200*delta;
			g_t_lock = 1;
			if(g_threshold > 250000) g_threshold = 250000;
			if(g_threshold <   200) g_threshold =   200;
			break;
		case 'X':
		case 'S':
			if(delta){
				serial_no += delta;
			}else{
				serial_no = 1;
			}	
			if(serial_no < 1) {
				serial_no = 1;
				//Beep();
			} 
			if(serial_no > 999){
				serial_no = 999;
				//Beep();
			}	
			break;
		default:
			break;
	}	
}

/*************************************************************************
 *				C W   R E C E I V E   P R O C E S S I N G				 *
 *************************************************************************/

/* * * * * * * * * * *  S T A T E   S E Q U E N C I N G  * * * * * * * * */	

void run_cw_rx(void){
	if(cw_state == MARK){
		mark_func();
	}else if(cw_state == SPACE){
		space_func();
	}
}

/* * * * * *   S P A C E   P R O C E S S I N G	  S T A T E	   * * * * * 
 *	             This function monitors and times SPACEs.  
 *
 *	When a SPACE duration reaches the threshold for an inter-character SPACE,
 *	the a call is made to char_print and the current contents of the 
 *	mark buffer are processed and translated to a character.  Valid
 *	Morse characters are then buffered for display.  The current wpm is
 *	calculated after each character.
 *
 *	When the SPACE duration reaches the threshold for an inter-word SPACE,
 *	a SPACE code is buffered.  Note that every inter-word event is 
 *	immediatley preceded by an inter-character event.  No further action 
 *	is taken after an inter-word event until the next MARK is detected.
 *	There is no upper limit on the duration of an inter-word SPACE.
 *
 *	When a MARK is detected, it must be longer than 10 ms to be recognized.
 *	When a MARK is less than this it is discarded, the MARK buffers are
 *	backed up one position, and the cw_state is changed to MARK.  The 
 *	assumption here is that short SPACES are generated by noise or other 
 *	degradation	in the receive channel.  The durations of SPACEs longer 
 *	than this are saved in a ring.  The average duration is calculated.
 *
 */
int		char_flag;	
int		word_flag;
int		dit_msec;
int		csp_fence, wsp_fence;	

void space_func(void){
	// int doDisplay;
	extern markBuffer *mainRxPtr;
	int i;
	dit_msec = mark_avg/2;
	dit_msec = (dit_msec) ? dit_msec : 60;
	if(CWKey == SPACE){
  		/* (1) check for end of character */
  		csp_fence = (sp_sum) ? (2 * sp_sum)/SBSIZE : 120;
  		if((sp_msec > csp_fence)  && (char_flag == START) && (rxMarkBuffers[buffsel].mark_count > 0)){
	  		rxMarkBuffers[buffsel].c_flag = PRINT_CHAR;
	  		mainRxPtr   = &rxMarkBuffers[buffsel];
	  		buffsel    ^= 0x01;		// select next buffer
	  		rxMarkBuffers[buffsel].mark_count = 0;
       		char_flag 	= FINISH;
			rx_wpm 		= (mark_avg <= 0) ? 0 : 2400/mark_avg;	// calculate wpm
        }
        /* (2) check for end of word */
        if(wspm_lock){
	        wsp_fence = (word_mul * dit_msec)/10;
	    }else{
        	wsp_fence = (25 * csp_fence)/10;
        	word_mul  = (10 * wsp_fence)/dit_msec;
        }
		if((sp_msec > wsp_fence) && word_flag == START){
			word_flag = FINISH;
			rxMarkBuffers[buffsel].c_flag = PRINT_SPACE;
	  		mainRxPtr   = &rxMarkBuffers[buffsel];
	  		buffsel    ^= 0x01;		// select next buffer
	  		rxMarkBuffers[buffsel].mark_count = 0;
        }
 	}else{ /* detected MARK in SPACE state */
		/* glitch filter discards false SPACEs caused by noise 
		   that are less than five ms long.  */
		if(sp_msec < 5 && rxMarkBuffers[buffsel].mark_count){
			--rxMarkBuffers[buffsel].mark_count;
			if(--mark_ptr 		< 0) mark_ptr 	 = 9;
			if(--md_mark_ptr	< 0) md_mark_ptr = 9;
			cw_state = MARK;	// return to MARK state
			return;
		} 
		if((char_flag != FINISH) || !csp_fence){
			sp_ptr = (sp_ptr >= SBSIZE) ? 0 : sp_ptr;
			//capture duration of last, non-inter-word space in ring buffer
			sp_c_buffer[sp_ptr++] = sp_msec;
		    /* calculate new character space fence point */
		 	if(cspm_lock){
				sp_sum = (char_mul * dit_msec) / 2;
			}else{
		    	sp_sum = 0;
			 	for(i = 0; i < SBSIZE; i++)
			    	sp_sum += sp_c_buffer[i];
				char_mul = (2 * sp_sum) / dit_msec;
			}
		}	 
		word_flag = START;
		char_flag = START; 
		mark_msec = 2;			// add 2 for initial loop-compensates for sampling time ?????????
	    cw_state  = MARK;		// go to MARK state
		//doDisplay = 1;
	}
}

/* * * * * * * *  M A R K   P R O C E S S I N G	  S T A T E	 * * * * * * *
 *                 This function monitors and times MARKs.  
 *
 * At the end of each MARK, a dit/dah determination is made and recorded.  
 * They are stored in a 9-entry buffer.  If this buffer overflows, a '#' 
 * is displayed in the current display position. This buffer (DIT-DAH buffer) 
 * is cleared only after a character is displayed by the char_print function.
 *
 * The duration of the current MARK is then used to update a number of
 * decision factors used for validation.  The standard deviation of this MARK duration
 * is calculated by subtracting the current average from the current MARK.  The
 * average of the last 32 standard deviations is then calculated.  The average of
 * the last 32 standard deviations is calculated only after filtering out any more than
 * three MARK durations with durations within +/- 12.5% of each other.  This 
 * test is overridden if the current average is less than four times the 
 * absolute value of the current mean deviation.  This avoids skewing the 
 * data when the number of dits and dahs are not close to the same.  
 *
 * The new fence (border between dits and dahs) is calculated
 * as the current MARK duration average plus the current average mean
 * deviation of the last 32 MARK durations.
 */
long	md_val;

void mark_func(void){
	extern markBuffer *mainRxPtr;
	int		i, delta;	
	
	/* wait for end of mark */
    if(CWKey == MARK){
		return;
	}
	
	/* glitch filter discards false MARKs caused by noise 
	   that are less than ten ms long.  */
	if(mark_msec < 5 ){
		if(--sp_ptr < 0) sp_ptr = SIZE-1;
		cw_state = SPACE;	// return to space state
		return;
	} 
	sp_msec = 0;
	if(mark_msec > mark_fence){
		rxMarkBuffers[buffsel].marks[rxMarkBuffers[buffsel].mark_count] = DAH;	//2
	}else{ 
		rxMarkBuffers[buffsel].marks[rxMarkBuffers[buffsel].mark_count] = DIT;	//1
	}	
	if(++rxMarkBuffers[buffsel].mark_count > 8){			// buffer overflow? 
		for(i = 0; i < 8; i++){
			if(rxMarkBuffers[buffsel].marks[i] != DIT){	// check for error (hH)
				rxMarkBuffers[buffsel].c_flag = PRINT_OVR;
				mainRxPtr = &rxMarkBuffers[buffsel];
				rxMarkBuffers[buffsel].mark_count = 0x00;			// start over
				break;
			}		
		}
		if(rxMarkBuffers[buffsel].c_flag != PRINT_OVR){
			rxMarkBuffers[buffsel].mark_count--;
		}		
	}
	 
    /* Avoid corrupting average with skew due to repetition.
       Count number of consecutive marks with durations +/- 12.5% of last one */
    delta = mark_stack[mark_ptr]/8; 
	if((mark_msec < (mark_stack[mark_ptr] + delta)) && (mark_msec > (mark_stack[mark_ptr] - delta)))
		mark_skew_count++;
	else 
		mark_skew_count = 0;
	           
	if((mark_skew_count < skew_max) || (md_val > mark_avg)){	//accept if repeat count less than 4 or 4*md_avg is greater than avg_m.
	 
		/* calculate latest mean deviation and store on stack */
	    if(++md_mark_ptr > SIZE -1)
			md_mark_ptr = 0;		// ring buffer
		md_mark_stack[md_mark_ptr] = mark_msec - mark_avg;	// add latest mark time minus current average
	 
		/* calculate new average of mean deviation */
	    md_mark_avg = 0;
		for(i = 0; i < SIZE; i++)
	    	md_mark_avg = md_mark_avg + md_mark_stack[i];
	    md_mark_avg = md_mark_avg/SIZE;
	    
		/* generate absolute value of mean deviation times 4 */
		md_val = 4 * md_mark_avg;
		if(md_val < 0)
			md_val = -1 * md_val;
	    
		/* load mark_stack with last mark */
	    if(++mark_ptr > SIZE -1)
	    	mark_ptr = 0;
	 	mark_stack[mark_ptr] = mark_msec;
	 	
	    /* calculate new average */
	    mark_avg = 0;
	 	for(i = 0; i < SIZE; i++)
	    	mark_avg = mark_avg + mark_stack[i];
		mark_avg = mark_avg/SIZE;
	    /* calculate new fence point */
	    mark_fence = mark_avg +  md_mark_avg;
	               
	}else{
		mark_skew_count = skew_max;	//keep from rolling over (very unlikely)
	}
	cw_state = SPACE;
}

/* * * * * *  T R A N S L A T E   M O R S E   T O   A S C I I  * * * * * *
 *
 *	c_flag	specifies type of character(s) to generate
 *		c = PRINT_OVER (3)  => buffer overflow, generate '#'
 *		  = PRINT_SPACE (2) => inter-word, generate ' '
 *		  = PRINT_CHAR (1)  => Morse symbol, translate to ASCII
 *		  = PRINT_NONE (0)  => nothing to generate
 *
 *	The receive buffer buffer[8] contains up to eight MARKs 
 *	encoded such that buffer[n] = 2 for DAH and 1 for DIT.  All
 *	buffer entries following the last mark are zeroes.  The
 *	buffer contents are examined to determine the number of
 *	non-zero (MARK) entries in it and to generate the sum 
 *	of the entries whereby each entry is shifted left a
 *	number of bit positions equal to its postion in the buffer.
 *	For example, the contents of buffer[0] are not shifted,
 *	the contents of buffer[1] are left shifted by one position,
 *	the contents of buffer[2] are left shifted by two positions,
 *	etc.  
 *
 *	The number of MARKs determines a character category,
 *	the sum determines the character within the category.  All
 *	the characters of the alphabet have four or less MARKs in
 *	their Morse symbol and have sums between 1 ('E') and 
 *	28 ('Q') with two undefined symbols.  These are translated
 *	in a straightforward manner using a 28-entry translation
 *	table.
 *
 *	Symbols with 5, 6, 7, and 8 MARKs are translated in groups
 *	using comparison logic (if-then or switch).  These categories
 *	include prosign symbols which are translated to two ASCII
 *	characters.
 *
 *	All unrecognized Morse symbols are translated to a single 
 *	astrisk ('*').  All valid alpha characters are translated
 *	to upper-case, ASCII character codes.  All prosigns are
 *	translated to lower-case ASCII character codes representing
 *	the Morse elements in the prosign.  For example, the BREAK
 *	prosign (-...-.-) translates to "bk" while individual letters
 *	"B" and "K" translate to "BK" (requires two calls to char_print).
 *
 *	The results of the translation consist of one or two standard,
 *	ASCII characters, write_char and sec_char.  The contents of
 *	sec_char will be zero except when a prosign has been 
 *	translated.  It is the responsibility of the calling routine
 *	to pass the results on to the transmit queue.
 */
				//	 0000000000111111111122222222223
				//	 0123456789012345678901234567890
const char letter[] ="ETIANMSURWDKGOHVF*LaPJBXCYZQ*m";
				//						 a		   m
				// Note, 18 = "im", 20 = "aa", 29 = "mn"
				
void char_print(volatile markBuffer *mbuf){
//#define write_char mbuf->write_char
//#define sec_char mbuf->sec_char
//
//	int exp, loop, sum, ptr, bs;
//	uchar alpha;
//	char *letter_ptr;
//	
//	sec_char = 0; /* reset special command character value */
//	if(mbuf->c_flag == PRINT_OVR)
//		write_char = '#';
//	else if(mbuf->c_flag == PRINT_SPACE)
//		write_char = ' ';
//	else{
//	    ptr = 7;
//	    sum = 0;
//	    exp = 128;
//        while(mbuf->marks[ptr] == 0){
//	        exp = exp/2;
//            ptr--;
//        }
//	    ptr = 0;
//	    while(exp != 0){ 
//		    sum = sum + ((mbuf->marks[ptr]) * exp);
//	        exp = exp/2;
//	        ptr++;
//		}
//		switch(mbuf->mark_count){
//	    	case 0:		//shouldn't happen
//	    		return;
//	    	case 1:
//	    	case 2:
//	    	case 3:
//	    	case 4:
//			    letter_ptr = (char*) &letter[0];
//		        alpha = *(letter_ptr + (sum - 1));
//		        write_char = alpha;
//		        if(sum == 30) sec_char = 'm';
//		        if(sum == 20) sec_char = 'a';
//			    break;    
//	    	case 5:
//			    switch(sum){
//					case 62: write_char = '0';
//					         break;
//					case 61: write_char = '9';
//					         break;
//					case 59: write_char = '8';
//					         break;
//					case 55: write_char = '7';
//					         break;
//					case 47: write_char = '6';
//					         break;
//					case 31: write_char = '5';
//					         break;
//					case 32: write_char = '4';
//					         break;
//					case 34: write_char = '3';
//					         break;
//					case 38: write_char = '2';
//					         break;
//					case 46: write_char = '1';
//					         break;
//					case 35: write_char = '`';	// 'é'
//							 break;
//					case 33: write_char = 's';	// sn - Sho' 'Nuff
//					         sec_char   = 'n';
//					         break;
//					case 41: write_char = 'a';	// ar - All Right
//					         sec_char   = 'r';
//					         break;
//					case 39: write_char = 'a';	// as - wait A Sec
//					         sec_char   = 's';
//					         break;
//					case 52: write_char = 'c';	// ct - Commence Transmission
//					         sec_char   = 't';
//					         break;
//					case 48: write_char = 'b';	// bt - separator
//							 sec_char   = 't';
//							 break;
//					case 49: write_char = '/';
//					         break;
//					case 53: write_char = 'k';	// kn - Kalled statioN only
//							 sec_char   = 'n';
//					         break;
//					case 57: write_char = 't';	// tc - insert Their Call
//							 sec_char 	= 'c';
//							 break;
//					default: 
//							write_char = '*';
//				}
//				break;
//			case 6:
//				switch(sum){
//					case 68: write_char = 's';	// sk - Silent Key
//		            		 sec_char   = 'k';
//		            		 break;
//					case 72: write_char = '\\';	// uu - Escape
//							 break;
//					case 75: write_char = '?';
//							 break;
//					case 76: write_char = 'i';	// iq - ????
//					         sec_char   = 'q';
//					         break;
//					case 81: write_char = '"';
//					         break;
//					case 83: write_char = 'a';	// al - ????
//					         sec_char   = 'l';
//					         break;
//					case 84: write_char = '.';
//							 break;
//					case 89: write_char = '@';
//							 break;
//					case 93: write_char = '\'';
//					         break;
//					case 96: write_char = '-';
//					         break;
//					case 102: write_char = 'd';	// do - tweak DowN
//							  sec_char   = 'o';
//					          break;
//					case 105: write_char = ';';
//					          break;
//					case 108: write_char = ')';
//					          break;
//					case 114: write_char = ',';
//							  break;
//					case 119: write_char = ':';
//					          break;
//					case 121: write_char = 'm';	// mc - insert My Call
//							  sec_char	 = 'c';
//							  break;
//					default: 
//							write_char = '*';
//				}
//				break;
//	    	case 7:
//			    switch(sum){
//			    case 136:
//		        	write_char = '$';
//		        	break;
//				case 149: 
//					write_char = 'u';	// up - tweak UP
//					sec_char   = 'p';
//					break;
//		        case 196:					// bk - BreaK
//		        	write_char = 'b';
//		        	sec_char   = 'k';
//		        	break;
//		        case 238:					// m1 - F1
//		        	write_char = 'm';
//		        	sec_char   = '1';
//		        	break;
//		        case 230:					// m2 - F2
//		        	write_char = 'm';
//		        	sec_char   = '2';
//		        	break;
//		        case 226:					// m3 - F3
//		        	write_char = 'm';
//		        	sec_char   = '3';
//		        	break;
//		        case 224:					// m4 - F4
//		        	write_char = 'm';
//		        	sec_char   = '4';
//		        	break;
//		        case 223:					// m5 - F5
//		        	write_char = 'm';
//		        	sec_char   = '5';
//		        	break;
//		        case 239:					// m6 - F6
//		        	write_char = 'm';
//		        	sec_char   = '6';
//		        	break;
//		        case 247:					// m7 - F7
//		        	write_char = 'm';
//		        	sec_char   = '7';
//		        	break;
//		        default:
//		        	write_char = '*';
//	     		}
//	     		break;   	
//  			case 8:
//		  		switch(sum){
//		  			case 255:				// hh - HuH? (error)
//			  			write_char = 'h';
//	             		sec_char   = 'h';
//	             		break;
//	             	case 419:				// cl - CLear (CLosing Down)
//	             		write_char = 'c';
//	             		sec_char   = 'l';
//	             		break;
//	     			case 428:				// cq - Calling
//		     			write_char = 'c';
//		     			sec_char   = 'q';
//		     			break;
//		    		default: 
//	        			write_char = '*';
//	     		}
//	     		break;
//	     	default:
//	     		write_char = '*';			// unknown character
//	     		break;   		
//  		}      
//	} /* end of else */
//	for(ptr = 0; ptr < 8; ptr++){
//    	mbuf->marks[ptr] = 0; 		/* clear DIT/DAH buffer */
// 	}
//	mbuf->mark_count = 0;
}
