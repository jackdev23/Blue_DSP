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
#if defined(__dsPIC33F__)
#include "p33Fxxxx.h"
#elif defined(__PIC24H__)
#include "p24Hxxxx.h"
#endif

#include "../h/I2CSlaveDrv.h"
#include "../h/dspProtocol.h"

unsigned char RAMBuffer[256];	//RAM area which will work as EEPROM for Master I2C device
unsigned char *RAMPtr;			//Pointer to RAM memory locations
struct FlagType Flag;

/*****************************************************************
		Init I2C1 Bus
*****************************************************************/
void i2c1_init(void)
{
	#if !defined(USE_I2C_Clock_Stretch)
		I2C1CON = 0x8000;	//Enable I2C1 module
	#else
		I2C1CON = 0x9040;	//Enable I2C1 module, enable clock stretching
	#endif
	

	I2C1ADD = 0x40;			// 7-bit I2C slave address must be initialised here. 
	
	IFS1=0;
	RAMPtr = &RAMBuffer[0];	//set the RAM pointer and points to beginning of RAMBuffer
	Flag.AddrFlag = 0;	//Initlize AddFlag
	Flag.DataFlag = 0;	//Initlize DataFlag
	_SI2C1IE = 1;
}

/*
Function Name: SI2C1Interrupt
Description : This is the ISR for I2C1 Slave interrupt.
Arguments	 : None
*/
void __attribute__((interrupt,no_auto_psv)) _SI2C1Interrupt(void)
{
	unsigned char Temp;	//used for dummy read
    
	if((I2C1STATbits.R_W == 0)&&(I2C1STATbits.D_A == 0))	//Address matched
		{
			Temp = I2C1RCV;		//dummy read
			Flag.AddrFlag = 1;	//next byte will be address
		}
	else if((I2C1STATbits.R_W == 0)&&(I2C1STATbits.D_A == 1))	//check for data	
		{
			if(Flag.AddrFlag)
			{
				Flag.AddrFlag = 0;	
				Flag.DataFlag = 1;	//next byte is data
                Temp = I2C1RCV;
                RAMBuffer[DSP_WHAT_parameters] = Temp; //store register to modify 
				RAMPtr = RAMPtr + Temp;
				#if defined(USE_I2C_Clock_Stretch)
					I2C1CONbits.SCLREL = 1;	//Release SCL1 line
				#endif
			}
			else if(Flag.DataFlag)
			{
				*RAMPtr = (unsigned char)I2C1RCV;// store data into RAM
				Flag.AddrFlag = 0;//end of tx
				Flag.DataFlag = 0;
                RAMBuffer[DSP_parameters_change] = DSP_TRUE;//signal to main loop to change parameters
				RAMPtr = &RAMBuffer[0];	//reset the RAM pointer
				#if defined(USE_I2C_Clock_Stretch)
					I2C1CONbits.SCLREL = 1;	//Release SCL1 line
				#endif
			}
		}
	else if((I2C1STATbits.R_W == 1)&&(I2C1STATbits.D_A == 0))
	{
		Temp = I2C1RCV;
		I2C1TRN = *RAMPtr;	//Read data from RAM & send data to I2C master device
		I2C1CONbits.SCLREL = 1;	//Release SCL1 line
		while(I2C1STATbits.TBF);//Wait till all 
		RAMPtr = &RAMBuffer[0];	//reset the RAM pointer
	}
	_SI2C1IF = 0;	//clear I2C1 Slave interrupt flag
}	
