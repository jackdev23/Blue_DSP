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


//#define USE_I2C_Clock_Stretch	//uncomment this line if you want clock stretching featue
								//to be enabled
//Functions prototype
void i2c1_init(void);
void __attribute__((interrupt,no_auto_psv)) _SI2C1Interrupt(void);

extern unsigned char RAMBuffer[256];	//RAM area which will work as EEPROM for Master I2C device

struct FlagType
{
	unsigned char AddrFlag:1;
	unsigned char DataFlag:1;
};
extern struct FlagType Flag;

/****************ARDUINO*************************************************
 *
#include <Wire.h>
#define  	INDSPSlaveAddress 0x40

#define MASTER_GAIN 9     // This must be an integer in the range 0 (default) to 12 (max volume) 
unsigned char  GAINS[8] =  {18, 18, 18, 0, 0, 18, 18, 18};
//unsigned char  GAINS[8] =  {0, 18, 18, 18, 18, 18, 0, 0};
//unsigned char  GAINS[8] =  {9, 9, 9, 9, 9, 9, 9, 9};==
//unsigned char  GAINS[8] =  {0, 0, 0, 0, 0, 0, 0, 0};
//unsigned char  GAINS[8] =  {18, 18, 18, 18, 18, 18, 18, 18};
//REGISTERS DSP

//REGISTERS DSP

#define DSP_Mute               0x20
#define DSP_Noise_apply                 0x21
#define DSP_Noise_setNoiseReduction     0x22

#define DSP_EQU_apply             0x30
#define DSP_EQU_MasterGain                  0x31
#define DSP_AutoNotch_apply                 0x32
#define DSP_Filter_apply                    0x33

#define DSP_EQU_31_BAND           0x00 //0-18
#define DSP_EQU_62_BAND           0x01 //0-18
#define DSP_EQU_125_BAND          0x02 //0-18
#define DSP_EQU_250_BAND          0x03 //0-18
#define DSP_EQU_500_BAND          0x04 //0-18
#define DSP_EQU_1000_BAND         0x05 //0-18
#define DSP_EQU_2000_BAND         0x06 //0-18
#define DSP_EQU_4000_BAND         0x07 //0-18

#define DSP_FIL_filterSelect                0x10

//constants
#define DSP_parameters_change               0x40
#define DSP_WHAT_parameters                 0x41

#define DSP_FIL_300_2700          0x00
#define DSP_FIL_300_2400          0x01
#define DSP_FIL_300_1800          0x02
#define DSP_FIL_300_1500          0x03
#define DSP_FIL_300_1300          0x04
#define DSP_FIL_450_950           0x05
#define DSP_FIL_550_850           0x06

#define DSP_TRUE          1
#define DSP_FALSE           0

void i2c_eeprom_write_byte( int deviceaddress, byte eeaddress, byte data ) {

  Wire.beginTransmission(deviceaddress);
  Wire.write(eeaddress);
  Wire.write(data);
  Wire.endTransmission();
}
byte i2c_eeprom_read_byte( int deviceaddress, byte eeaddress ) {
  byte rdata;
  Wire.beginTransmission(deviceaddress);
  Wire.write(eeaddress);
  Wire.endTransmission(false);
  // Wire.beginTransmission(deviceaddress);
  Wire.requestFrom(deviceaddress, 1);
  if (Wire.available()) rdata = Wire.read();
  return rdata;
}

void setup() {
  Wire.begin(); // initialise the connection
  Serial.begin(9600);
  i2c_eeprom_write_byte(picSlaveAddress, DSP_Mute, DSP_FALSE); // write to EEPROM
  i2c_eeprom_write_byte(picSlaveAddress, DSP_Noise_setNoiseReduction, 13); // write to EEPROM

  delay(100); //add a small delay
  Serial.println("Memory written");
  Serial.println(i2c_eeprom_read_byte(picSlaveAddress, DSP_Mute));

  i2c_eeprom_write_byte(picSlaveAddress, DSP_EQU_31_BAND, GAINS[DSP_EQU_31_BAND]);
  delay(20);
  i2c_eeprom_write_byte(picSlaveAddress, DSP_EQU_62_BAND, GAINS[DSP_EQU_62_BAND]);
  delay(20);
  i2c_eeprom_write_byte(picSlaveAddress, DSP_EQU_125_BAND, GAINS[DSP_EQU_125_BAND]);
  delay(20);
  i2c_eeprom_write_byte(picSlaveAddress, DSP_EQU_250_BAND, GAINS[DSP_EQU_250_BAND]);
  delay(20);
  i2c_eeprom_write_byte(picSlaveAddress, DSP_EQU_500_BAND, GAINS[DSP_EQU_500_BAND]);
  delay(20);
  i2c_eeprom_write_byte(picSlaveAddress, DSP_EQU_1000_BAND, GAINS[DSP_EQU_1000_BAND]);
  delay(20);
  i2c_eeprom_write_byte(picSlaveAddress, DSP_EQU_2000_BAND, GAINS[DSP_EQU_2000_BAND]);
  delay(20);
  i2c_eeprom_write_byte(picSlaveAddress, DSP_EQU_4000_BAND, GAINS[DSP_EQU_4000_BAND]);
  delay(20);

  i2c_eeprom_write_byte(picSlaveAddress, DSP_EQU_MasterGain, MASTER_GAIN);
  delay(20);
  i2c_eeprom_write_byte(picSlaveAddress, DSP_FIL_filterSelect, DSP_FIL_300_2700);
  delay(20);
  i2c_eeprom_write_byte(picSlaveAddress, DSP_Noise_apply, DSP_TRUE);
  delay(20);
  i2c_eeprom_write_byte(picSlaveAddress, DSP_EQU_apply, DSP_TRUE);
  delay(20);
  i2c_eeprom_write_byte(picSlaveAddress, DSP_Filter_apply, DSP_FALSE);
  delay(20);
  i2c_eeprom_write_byte(picSlaveAddress, DSP_AutoNotch_apply, DSP_TRUE);
  delay(20);
   // i2c_eeprom_write_byte(picSlaveAddress, DSP_Mute, DSP_FALSE); 
}

void loop() {  
}
 * 
 * **********************************************************************/
