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
#include <stddef.h>
#include <stdlib.h>
#include <stdio.h>
#include <string.h>
#include <math.h>
#include <ctype.h>
#include <stdint.h>

#include <xc.h>

#define FCY 36864000UL//39936000UL						// 39,936 MHz
#include <libpic30.h>
#include "../h/oled.h"
uint8_t x_pos, y_pos, text_size;
bool wrap = true;
//--------------------------------------------------------------------------//

const char Font[] = {
    0x00, 0x00, 0x00, 0x00, 0x00,
    0x00, 0x00, 0x5F, 0x00, 0x00,
    0x00, 0x07, 0x00, 0x07, 0x00,
    0x14, 0x7F, 0x14, 0x7F, 0x14,
    0x24, 0x2A, 0x7F, 0x2A, 0x12,
    0x23, 0x13, 0x08, 0x64, 0x62,
    0x36, 0x49, 0x56, 0x20, 0x50,
    0x00, 0x08, 0x07, 0x03, 0x00,
    0x00, 0x1C, 0x22, 0x41, 0x00,
    0x00, 0x41, 0x22, 0x1C, 0x00,
    0x2A, 0x1C, 0x7F, 0x1C, 0x2A,
    0x08, 0x08, 0x3E, 0x08, 0x08,
    0x00, 0x80, 0x70, 0x30, 0x00,
    0x08, 0x08, 0x08, 0x08, 0x08,
    0x00, 0x00, 0x60, 0x60, 0x00,
    0x20, 0x10, 0x08, 0x04, 0x02,
    0x3E, 0x51, 0x49, 0x45, 0x3E,
    0x00, 0x42, 0x7F, 0x40, 0x00,
    0x72, 0x49, 0x49, 0x49, 0x46,
    0x21, 0x41, 0x49, 0x4D, 0x33,
    0x18, 0x14, 0x12, 0x7F, 0x10,
    0x27, 0x45, 0x45, 0x45, 0x39,
    0x3C, 0x4A, 0x49, 0x49, 0x31,
    0x41, 0x21, 0x11, 0x09, 0x07,
    0x36, 0x49, 0x49, 0x49, 0x36,
    0x46, 0x49, 0x49, 0x29, 0x1E,
    0x00, 0x00, 0x14, 0x00, 0x00,
    0x00, 0x40, 0x34, 0x00, 0x00,
    0x00, 0x08, 0x14, 0x22, 0x41,
    0x14, 0x14, 0x14, 0x14, 0x14,
    0x00, 0x41, 0x22, 0x14, 0x08,
    0x02, 0x01, 0x59, 0x09, 0x06,
    0x3E, 0x41, 0x5D, 0x59, 0x4E,
    0x7C, 0x12, 0x11, 0x12, 0x7C,
    0x7F, 0x49, 0x49, 0x49, 0x36,
    0x3E, 0x41, 0x41, 0x41, 0x22,
    0x7F, 0x41, 0x41, 0x41, 0x3E,
    0x7F, 0x49, 0x49, 0x49, 0x41,
    0x7F, 0x09, 0x09, 0x09, 0x01,
    0x3E, 0x41, 0x41, 0x51, 0x73,
    0x7F, 0x08, 0x08, 0x08, 0x7F,
    0x00, 0x41, 0x7F, 0x41, 0x00,
    0x20, 0x40, 0x41, 0x3F, 0x01,
    0x7F, 0x08, 0x14, 0x22, 0x41,
    0x7F, 0x40, 0x40, 0x40, 0x40,
    0x7F, 0x02, 0x1C, 0x02, 0x7F,
    0x7F, 0x04, 0x08, 0x10, 0x7F,
    0x3E, 0x41, 0x41, 0x41, 0x3E,
    0x7F, 0x09, 0x09, 0x09, 0x06,
    0x3E, 0x41, 0x51, 0x21, 0x5E,
    0x7F, 0x09, 0x19, 0x29, 0x46
};
const char Font2[] = {
    0x26, 0x49, 0x49, 0x49, 0x32,
    0x03, 0x01, 0x7F, 0x01, 0x03,
    0x3F, 0x40, 0x40, 0x40, 0x3F,
    0x1F, 0x20, 0x40, 0x20, 0x1F,
    0x3F, 0x40, 0x38, 0x40, 0x3F,
    0x63, 0x14, 0x08, 0x14, 0x63,
    0x03, 0x04, 0x78, 0x04, 0x03,
    0x61, 0x59, 0x49, 0x4D, 0x43,
    0x00, 0x7F, 0x41, 0x41, 0x41,
    0x02, 0x04, 0x08, 0x10, 0x20,
    0x00, 0x41, 0x41, 0x41, 0x7F,
    0x04, 0x02, 0x01, 0x02, 0x04,
    0x40, 0x40, 0x40, 0x40, 0x40,
    0x00, 0x03, 0x07, 0x08, 0x00,
    0x20, 0x54, 0x54, 0x78, 0x40,
    0x7F, 0x28, 0x44, 0x44, 0x38,
    0x38, 0x44, 0x44, 0x44, 0x28,
    0x38, 0x44, 0x44, 0x28, 0x7F,
    0x38, 0x54, 0x54, 0x54, 0x18,
    0x00, 0x08, 0x7E, 0x09, 0x02,
    0x18, 0xA4, 0xA4, 0x9C, 0x78,
    0x7F, 0x08, 0x04, 0x04, 0x78,
    0x00, 0x44, 0x7D, 0x40, 0x00,
    0x20, 0x40, 0x40, 0x3D, 0x00,
    0x7F, 0x10, 0x28, 0x44, 0x00,
    0x00, 0x41, 0x7F, 0x40, 0x00,
    0x7C, 0x04, 0x78, 0x04, 0x78,
    0x7C, 0x08, 0x04, 0x04, 0x78,
    0x38, 0x44, 0x44, 0x44, 0x38,
    0xFC, 0x18, 0x24, 0x24, 0x18,
    0x18, 0x24, 0x24, 0x18, 0xFC,
    0x7C, 0x08, 0x04, 0x04, 0x08,
    0x48, 0x54, 0x54, 0x54, 0x24,
    0x04, 0x04, 0x3F, 0x44, 0x24,
    0x3C, 0x40, 0x40, 0x20, 0x7C,
    0x1C, 0x20, 0x40, 0x20, 0x1C,
    0x3C, 0x40, 0x30, 0x40, 0x3C,
    0x44, 0x28, 0x10, 0x28, 0x44,
    0x4C, 0x90, 0x90, 0x90, 0x7C,
    0x44, 0x64, 0x54, 0x4C, 0x44,
    0x00, 0x08, 0x36, 0x41, 0x00,
    0x00, 0x00, 0x77, 0x00, 0x00,
    0x00, 0x41, 0x36, 0x08, 0x00,
    0x02, 0x01, 0x02, 0x04, 0x02
};


/////////////////////////////////////////////////////////////////////////
//
// I2C Routines
//

void i2c1Enable(uint8_t flags) {
    // Calculate BGP from FCY
    // brg = ( FCY/FSCL - FCY/10000000) - 1
    uint32_t fscl = (flags & kI2C_400KHZ) ? 400000UL : 100000UL;
    uint16_t brg = ((FCY / fscl) - (FCY / 1000000)) - 1;
    I2C1BRG = brg;
    //I2C1BRG = 179;  // 100 kHz  for 20 MHz
    //I2C1BRG = 29;  // 400 kHz  for 20 MHz
    // enable I2C module
    I2C1CONbits.I2CEN = 1;
}

void i2c1Disable() {
    I2C1CONbits.I2CEN = 0;
}

static int16_t i2c1XferInt(
        uint8_t address,
        uint8_t* wdata, int wsize,
        uint8_t* rdata, int rsize) {
    int16_t count = 0;
    bool hasWrite = (wdata != NULL) && (wsize != 0);
    bool hasRead = (rdata != NULL) && (rsize != 0);
    if (!(hasWrite || hasRead)) return -1;

    // clear bus collision
    I2C1STATbits.BCL = 0;

    // generate start condition
    I2C1CONbits.SEN = 1;
    while (1) {
        if (I2C1STATbits.BCL) return -2;
        if (!I2C1CONbits.SEN) break;
    }

    // Send 7-bit slave address and Read/Write flag
    I2C1TRN = (address << 1) | (hasWrite ? 0x00 : 0x01);
    while (1) {
        if (I2C1STATbits.BCL) return -3;
        if (!I2C1STATbits.TRSTAT) break;
    }

    if (I2C1STATbits.ACKSTAT) return -4;

    // Write data
    int i;
    for (i = 0; i < wsize; i++) {
        I2C1TRN = wdata[ i ];
        while (1) {
            if (I2C1STATbits.BCL) return -5;
            if (!I2C1STATbits.TRSTAT) break;
        }
        if (I2C1STATbits.ACKSTAT) return -6;
    }

    if (hasRead) {
        // if we've been writing, send a Repeated Start
        if (hasWrite) {
            // generate start condition
            I2C1CONbits.RSEN = 1;
            while (1) {
                if (I2C1STATbits.BCL) return -7;
                if (!I2C1CONbits.RSEN) break;
            }

            // Send 7-bit slave address with Read flag
            I2C1TRN = (address << 1) | 0x01;
            while (1) {
                if (I2C1STATbits.BCL) return -8;
                if (!I2C1STATbits.TRSTAT) break;
            }
            if (I2C1STATbits.ACKSTAT) return -9;
        }

        // Read data
        int i;
        for (i = 0; i < rsize; i++) {
            // check idle
            if (I2C1CON & 0x1F) return -10;

            // enable reception
            I2C1CONbits.RCEN = 1;
            while (1) {
                if (I2C1STATbits.BCL) return -11;
                if (!I2C1CONbits.RCEN) break;
            }

            // read data byte from buffer
            rdata[ i ] = I2C1RCV;
            count++;

            // send acknowledge (or not acknowledge for final byte)
            I2C1CONbits.ACKDT = i == (rsize - 1) ? 1 : 0;
            I2C1CONbits.ACKEN = 1;
            while (1) {
                if (I2C1STATbits.BCL) return -12;
                if (!I2C1CONbits.ACKEN) break;
            }
        }
    }

    // Generate stop condition
    I2C1CONbits.PEN = 1;
    while (1) {
        if (I2C1STATbits.BCL) return -13;
        if (!I2C1CONbits.PEN) break;
    }

    return count;
}

int16_t i2c1Xfer(
        uint8_t address,
        uint8_t* wdata, int wsize,
        uint8_t* rdata, int rsize) {
    int16_t result = i2c1XferInt(address, wdata, wsize, rdata, rsize);
    if (result < 0) {
        // clear bus collision
        I2C1STATbits.BCL = 0;
        // clear start condition
        if (I2C1STATbits.S)
            I2C1CONbits.PEN = 1;
    }
    return result;
}

void i2c1Reset() {
    // first make sure I2C module is disabled
    i2c1Disable();

    // hold SCL low for 100 ms to reset I2C bus
    I2C1_SCL_TRIS = 0;
    I2C1_SCL_LAT = 0;
    int i;
    for (i = 0; i < 10; i++)
        __delay_ms(10);
    // tri-date SCL and SDA
    I2C1_SCL_TRIS = 1;
    I2C1_SDA_TRIS = 1;
    __delay_ms(10);
}


/////////////////////////////////////////////////////////////////////////
//
// SSD1308 OLED Routines
//

#define SSD1308_Address                 0x3C 
#define SSD1308_Command_Mode		0x80
#define SSD1308_Data_Mode               0x40
#define SSD1308_Display_Off_Cmd         0xAE
#define SSD1308_Display_On_Cmd          0xAF
#define SSD1308_Normal_Display_Cmd      0xA6
#define SSD1308_Inverse_Display_Cmd	0xA7
#define SSD1308_Activate_Scroll_Cmd	0x2F
#define SSD1308_Dectivate_Scroll_Cmd	0x2E
#define SSD1308_Set_Brightness_Cmd      0x81

//
//const uint8_t OledFont[][8] =
//{
//  {0x00,0x00,0x00,0x00,0x00,0x00,0x00,0x00},
//  {0x00,0x00,0x5F,0x00,0x00,0x00,0x00,0x00},
//  {0x00,0x00,0x07,0x00,0x07,0x00,0x00,0x00},
//  {0x00,0x14,0x7F,0x14,0x7F,0x14,0x00,0x00},
//  {0x00,0x24,0x2A,0x7F,0x2A,0x12,0x00,0x00},
//  {0x00,0x23,0x13,0x08,0x64,0x62,0x00,0x00},
//  {0x00,0x36,0x49,0x55,0x22,0x50,0x00,0x00},
//  {0x00,0x00,0x05,0x03,0x00,0x00,0x00,0x00},
//  {0x00,0x1C,0x22,0x41,0x00,0x00,0x00,0x00},
//  {0x00,0x41,0x22,0x1C,0x00,0x00,0x00,0x00},
//  {0x00,0x08,0x2A,0x1C,0x2A,0x08,0x00,0x00},
//  {0x00,0x08,0x08,0x3E,0x08,0x08,0x00,0x00},
//  {0x00,0xA0,0x60,0x00,0x00,0x00,0x00,0x00},
//  {0x00,0x08,0x08,0x08,0x08,0x08,0x00,0x00},
//  {0x00,0x60,0x60,0x00,0x00,0x00,0x00,0x00},
//  {0x00,0x20,0x10,0x08,0x04,0x02,0x00,0x00},
//  {0x00,0x3E,0x51,0x49,0x45,0x3E,0x00,0x00},
//  {0x00,0x00,0x42,0x7F,0x40,0x00,0x00,0x00},
//  {0x00,0x62,0x51,0x49,0x49,0x46,0x00,0x00},
//  {0x00,0x22,0x41,0x49,0x49,0x36,0x00,0x00},
//  {0x00,0x18,0x14,0x12,0x7F,0x10,0x00,0x00},
//  {0x00,0x27,0x45,0x45,0x45,0x39,0x00,0x00},
//  {0x00,0x3C,0x4A,0x49,0x49,0x30,0x00,0x00},
//  {0x00,0x01,0x71,0x09,0x05,0x03,0x00,0x00},
//  {0x00,0x36,0x49,0x49,0x49,0x36,0x00,0x00},
//  {0x00,0x06,0x49,0x49,0x29,0x1E,0x00,0x00},
//  {0x00,0x00,0x36,0x36,0x00,0x00,0x00,0x00},
//  {0x00,0x00,0xAC,0x6C,0x00,0x00,0x00,0x00},
//  {0x00,0x08,0x14,0x22,0x41,0x00,0x00,0x00},
//  {0x00,0x14,0x14,0x14,0x14,0x14,0x00,0x00},
//  {0x00,0x41,0x22,0x14,0x08,0x00,0x00,0x00},
//  {0x00,0x02,0x01,0x51,0x09,0x06,0x00,0x00},
//  {0x00,0x32,0x49,0x79,0x41,0x3E,0x00,0x00},
//  {0x00,0x7E,0x09,0x09,0x09,0x7E,0x00,0x00},
//  {0x00,0x7F,0x49,0x49,0x49,0x36,0x00,0x00},
//  {0x00,0x3E,0x41,0x41,0x41,0x22,0x00,0x00},
//  {0x00,0x7F,0x41,0x41,0x22,0x1C,0x00,0x00},
//  {0x00,0x7F,0x49,0x49,0x49,0x41,0x00,0x00},
//  {0x00,0x7F,0x09,0x09,0x09,0x01,0x00,0x00},
//  {0x00,0x3E,0x41,0x41,0x51,0x72,0x00,0x00},
//  {0x00,0x7F,0x08,0x08,0x08,0x7F,0x00,0x00},
//  {0x00,0x41,0x7F,0x41,0x00,0x00,0x00,0x00},
//  {0x00,0x20,0x40,0x41,0x3F,0x01,0x00,0x00},
//  {0x00,0x7F,0x08,0x14,0x22,0x41,0x00,0x00},
//  {0x00,0x7F,0x40,0x40,0x40,0x40,0x00,0x00},
//  {0x00,0x7F,0x02,0x0C,0x02,0x7F,0x00,0x00},
//  {0x00,0x7F,0x04,0x08,0x10,0x7F,0x00,0x00},
//  {0x00,0x3E,0x41,0x41,0x41,0x3E,0x00,0x00},
//  {0x00,0x7F,0x09,0x09,0x09,0x06,0x00,0x00},
//  {0x00,0x3E,0x41,0x51,0x21,0x5E,0x00,0x00},
//  {0x00,0x7F,0x09,0x19,0x29,0x46,0x00,0x00},
//  {0x00,0x26,0x49,0x49,0x49,0x32,0x00,0x00},
//  {0x00,0x01,0x01,0x7F,0x01,0x01,0x00,0x00},
//  {0x00,0x3F,0x40,0x40,0x40,0x3F,0x00,0x00},
//  {0x00,0x1F,0x20,0x40,0x20,0x1F,0x00,0x00},
//  {0x00,0x3F,0x40,0x38,0x40,0x3F,0x00,0x00},
//  {0x00,0x63,0x14,0x08,0x14,0x63,0x00,0x00},
//  {0x00,0x03,0x04,0x78,0x04,0x03,0x00,0x00},
//  {0x00,0x61,0x51,0x49,0x45,0x43,0x00,0x00},
//  {0x00,0x7F,0x41,0x41,0x00,0x00,0x00,0x00},
//  {0x00,0x02,0x04,0x08,0x10,0x20,0x00,0x00},
//  {0x00,0x41,0x41,0x7F,0x00,0x00,0x00,0x00},
//  {0x00,0x04,0x02,0x01,0x02,0x04,0x00,0x00},
//  {0x00,0x80,0x80,0x80,0x80,0x80,0x00,0x00},
//  {0x00,0x01,0x02,0x04,0x00,0x00,0x00,0x00},
//  {0x00,0x20,0x54,0x54,0x54,0x78,0x00,0x00},
//  {0x00,0x7F,0x48,0x44,0x44,0x38,0x00,0x00},
//  {0x00,0x38,0x44,0x44,0x28,0x00,0x00,0x00},
//  {0x00,0x38,0x44,0x44,0x48,0x7F,0x00,0x00},
//  {0x00,0x38,0x54,0x54,0x54,0x18,0x00,0x00},
//  {0x00,0x08,0x7E,0x09,0x02,0x00,0x00,0x00},
//  {0x00,0x18,0xA4,0xA4,0xA4,0x7C,0x00,0x00},
//  {0x00,0x7F,0x08,0x04,0x04,0x78,0x00,0x00},
//  {0x00,0x00,0x7D,0x00,0x00,0x00,0x00,0x00},
//  {0x00,0x80,0x84,0x7D,0x00,0x00,0x00,0x00},
//  {0x00,0x7F,0x10,0x28,0x44,0x00,0x00,0x00},
//  {0x00,0x41,0x7F,0x40,0x00,0x00,0x00,0x00},
//  {0x00,0x7C,0x04,0x18,0x04,0x78,0x00,0x00},
//  {0x00,0x7C,0x08,0x04,0x7C,0x00,0x00,0x00},
//  {0x00,0x38,0x44,0x44,0x38,0x00,0x00,0x00},
//  {0x00,0xFC,0x24,0x24,0x18,0x00,0x00,0x00},
//  {0x00,0x18,0x24,0x24,0xFC,0x00,0x00,0x00},
//  {0x00,0x00,0x7C,0x08,0x04,0x00,0x00,0x00},
//  {0x00,0x48,0x54,0x54,0x24,0x00,0x00,0x00},
//  {0x00,0x04,0x7F,0x44,0x00,0x00,0x00,0x00},
//  {0x00,0x3C,0x40,0x40,0x7C,0x00,0x00,0x00},
//  {0x00,0x1C,0x20,0x40,0x20,0x1C,0x00,0x00},
//  {0x00,0x3C,0x40,0x30,0x40,0x3C,0x00,0x00},
//  {0x00,0x44,0x28,0x10,0x28,0x44,0x00,0x00},
//  {0x00,0x1C,0xA0,0xA0,0x7C,0x00,0x00,0x00},
//  {0x00,0x44,0x64,0x54,0x4C,0x44,0x00,0x00},
//  {0x00,0x08,0x36,0x41,0x00,0x00,0x00,0x00},
//  {0x00,0x00,0x7F,0x00,0x00,0x00,0x00,0x00},
//  {0x00,0x41,0x36,0x08,0x00,0x00,0x00,0x00},
//  {0x00,0x02,0x01,0x01,0x02,0x01,0x00,0x00},
//  {0x00,0x02,0x05,0x05,0x02,0x00,0x00,0x00}
//};

void oledCommand(uint8_t ch) {
    uint8_t bytes[2];
    bytes[0] = SSD1308_Command_Mode;
    bytes[1] = ch;
    i2c1Xfer(SSD1308_Address, bytes, 2, NULL, 0);
}

void oledDisplayOffset(uint8_t offset) {
    uint8_t bytes[3];
    bytes[0] = SSD1308_Command_Mode;
    bytes[1] = 0xD3;
    bytes[2] = offset;
    i2c1Xfer(SSD1308_Address, bytes, 3, NULL, 0);
}

void oledData(uint8_t data) {
    uint8_t bytes[2];
    bytes[0] = SSD1308_Data_Mode;
    bytes[1] = data;
    i2c1Xfer(SSD1308_Address, bytes, 2, NULL, 0);
}

void oledGotoYX(unsigned char Row, unsigned char Column) {
    oledCommand(0xB0 + Row);
    oledCommand(0x00 + (8 * Column & 0x0F));
    oledCommand(0x10 + ((8 * Column >> 4)&0x0F));
}

void oledPutChar(char ch) {
    //    if ( ( ch < 32 ) || ( ch > 127 ) )
    //        ch = ' ';
    //
    //    //const uint8_t *base = &OledFont[ch - 32][0];
    //
    //    uint8_t bytes[9];
    //    bytes[0] = SSD1308_Data_Mode;
    //    memmove( bytes + 1, &OledFont[ch - 32][0], 8 );
    //    i2c1Xfer( SSD1308_Address, bytes, 9, NULL, 0 );
}

void oledPrint(char *s) {
    while (*s) oledPutChar(*s++);
}

void oledClear() {
    uint16_t row;
    uint16_t col;
    for (row = 0; row < 8; row++) {
        for (col = 0; col < 16; col++) {
            oledGotoYX(row, col);
            oledPutChar(' ');
        }
    }
}

void ssd1306_command(uint8_t c) {
    uint8_t control = 0x00; // Co = 0, D/C = 0
    uint8_t bytes[2];

    bytes[0] = control;
    bytes[1] = c;
    i2c1Xfer(SSD1308_Address, bytes, 2, NULL, 0);

}

static uint8_t ssd1306_buffer[SSD1306_LCDHEIGHT * SSD1306_LCDWIDTH / 8];
#define ssd1306_swap(a, b) { int16_t t = a; a = b; b = t; }

void SSD1306_Display(void) {
    ssd1306_command(SSD1306_COLUMNADDR);
    ssd1306_command(0); // Column start address (0 = reset)
    ssd1306_command(SSD1306_LCDWIDTH - 1); // Column end address (127 = reset)

    ssd1306_command(SSD1306_PAGEADDR);
    ssd1306_command(0); // Page start address (0 = reset)
#if SSD1306_LCDHEIGHT == 64
    ssd1306_command(7); // Page end address
#endif
#if SSD1306_LCDHEIGHT == 32
    ssd1306_command(3); // Page end address
#endif
#if SSD1306_LCDHEIGHT == 16
    ssd1306_command(1); // Page end address
#endif
    uint16_t i;

    for (i = 0; i < (SSD1306_LCDWIDTH * SSD1306_LCDHEIGHT / 8); i++) {
        oledData(ssd1306_buffer[i]);
    }
}

#define SH1106_SETCONTRAST 0x81
#define SH1106_DISPLAYALLON_RESUME 0xA4
#define SH1106_DISPLAYALLON 0xA5
#define SH1106_NORMALDISPLAY 0xA6
#define SH1106_INVERTDISPLAY 0xA7
#define SH1106_DISPLAYOFF 0xAE
#define SH1106_DISPLAYON 0xAF

#define SH1106_SETDISPLAYOFFSET 0xD3
#define SH1106_SETCOMPINS 0xDA

#define SH1106_SETVCOMDETECT 0xDB

#define SH1106_SETDISPLAYCLOCKDIV 0xD5
#define SH1106_SETPRECHARGE 0xD9

#define SH1106_SETMULTIPLEX 0xA8

#define SH1106_SETLOWCOLUMN 0x00
#define SH1106_SETHIGHCOLUMN 0x10

#define SH1106_SETSTARTLINE 0x40

#define SH1106_MEMORYMODE 0x20
#define SH1106_COLUMNADDR 0x21
#define SH1106_PAGEADDR   0x22

#define SH1106_COMSCANINC 0xC0
#define SH1106_COMSCANDEC 0xC8

#define SH1106_SEGREMAP 0xA0

#define SH1106_CHARGEPUMP 0x8D

#define SH1106_EXTERNALVCC 0x1
#define SH1106_SWITCHCAPVCC 0x2

void SSD1306_DisplaySH1106(void) {

    ssd1306_command(SH1106_SETLOWCOLUMN | 0x0); // low col = 0
    ssd1306_command(SH1106_SETHIGHCOLUMN | 0x0); // hi col = 0
    ssd1306_command(SH1106_SETSTARTLINE | 0x0); // line #0

    // I2C
    //height >>= 3;
    //width >>= 3;
    uint8_t height = 64;
    uint8_t width = 132;
    uint8_t m_row = 0;
    uint8_t m_col = 2;


    height >>= 3;
    width >>= 3;
    //Serial.println(width);

    int p = 0;

    uint8_t i, j, k = 0;

    for (i = 0; i < height; i++) {

        // send a bunch of data in one xmission
        ssd1306_command(0xB0 + i + m_row); //set page address
        ssd1306_command(m_col & 0xf); //set lower column address
        ssd1306_command(0x10 | (m_col >> 4)); //set higher column address

        for (j = 0; j < 8; j++) {

            for (k = 0; k < width; k++, p++) {
                oledData(ssd1306_buffer[p]);
            }
        }
    }
}

void SSD1306_ClearDisplay(void) {
    uint16_t i;
    for (i = 0; i < (SSD1306_LCDWIDTH * SSD1306_LCDHEIGHT / 8); i++)
        ssd1306_buffer[i] = 0;
}

void SSD1306_DrawPixel(uint8_t x, uint8_t y, bool color) {
    if ((x >= SSD1306_LCDWIDTH) || (y >= SSD1306_LCDHEIGHT))
        return;

    if (color)
        ssd1306_buffer[x + (uint16_t) (y / 8) * SSD1306_LCDWIDTH] |= (1 << (y & 7));
    else
        ssd1306_buffer[x + (uint16_t) (y / 8) * SSD1306_LCDWIDTH] &= ~(1 << (y & 7));
}

void SSD1306_DrawLine(int16_t x0, int16_t y0, int16_t x1, int16_t y1, bool color) {
    bool steep;
    int8_t ystep;
    uint8_t dx, dy;
    int16_t err;
    steep = abs(y1 - y0) > abs(x1 - x0);
    if (steep) {
        ssd1306_swap(x0, y0);
        ssd1306_swap(x1, y1);
    }
    if (x0 > x1) {
        ssd1306_swap(x0, x1);
        ssd1306_swap(y0, y1);
    }
    dx = x1 - x0;
    dy = abs(y1 - y0);

    err = dx / 2;
    if (y0 < y1)
        ystep = 1;
    else
        ystep = -1;

    for (; x0 <= x1; x0++) {
        if (steep) {
            if (color) SSD1306_DrawPixel(y0, x0, true);
            else SSD1306_DrawPixel(y0, x0, false);
        } else {
            if (color) SSD1306_DrawPixel(x0, y0, true);
            else SSD1306_DrawPixel(x0, y0, false);
        }
        err -= dy;
        if (err < 0) {
            y0 += ystep;
            err += dx;
        }
    }
}

void SSD1306_DrawFastHLine(uint8_t x, uint8_t y, uint8_t w, bool color) {
    SSD1306_DrawLine(x, y, x + w - 1, y, color);
}

void SSD1306_DrawFastVLine(uint8_t x, uint8_t y, uint8_t h, bool color) {
    SSD1306_DrawLine(x, y, x, y + h - 1, color);
}

void SSD1306_FillRect(uint8_t x, uint8_t y, uint8_t w, uint8_t h, bool color) {
    int16_t i;
    for (i = x; i < x + w; i++)
        SSD1306_DrawFastVLine(i, y, h, color);
}

void SSD1306_FillScreen(bool color) {
    SSD1306_FillRect(0, 0, SSD1306_LCDWIDTH, SSD1306_LCDHEIGHT, color);
}

void SSD1306_DrawCircle(int16_t x0, int16_t y0, int16_t r) {
    int16_t f = 1 - r;
    int16_t ddF_x = 1;
    int16_t ddF_y = -2 * r;
    int16_t x = 0;
    int16_t y = r;

    SSD1306_DrawPixel(x0, y0 + r, true);
    SSD1306_DrawPixel(x0, y0 - r, true);
    SSD1306_DrawPixel(x0 + r, y0, true);
    SSD1306_DrawPixel(x0 - r, y0, true);

    while (x < y) {
        if (f >= 0) {
            y--;
            ddF_y += 2;
            f += ddF_y;
        }
        x++;
        ddF_x += 2;
        f += ddF_x;

        SSD1306_DrawPixel(x0 + x, y0 + y, true);
        SSD1306_DrawPixel(x0 - x, y0 + y, true);
        SSD1306_DrawPixel(x0 + x, y0 - y, true);
        SSD1306_DrawPixel(x0 - x, y0 - y, true);
        SSD1306_DrawPixel(x0 + y, y0 + x, true);
        SSD1306_DrawPixel(x0 - y, y0 + x, true);
        SSD1306_DrawPixel(x0 + y, y0 - x, true);
        SSD1306_DrawPixel(x0 - y, y0 - x, true);
    }

}

void SSD1306_DrawCircleHelper(int16_t x0, int16_t y0, int16_t r, uint8_t cornername) {
    int16_t f = 1 - r;
    int16_t ddF_x = 1;
    int16_t ddF_y = -2 * r;
    int16_t x = 0;
    int16_t y = r;

    while (x < y) {
        if (f >= 0) {
            y--;
            ddF_y += 2;
            f += ddF_y;
        }
        x++;
        ddF_x += 2;
        f += ddF_x;
        if (cornername & 0x4) {
            SSD1306_DrawPixel(x0 + x, y0 + y, true);
            SSD1306_DrawPixel(x0 + y, y0 + x, true);
        }
        if (cornername & 0x2) {
            SSD1306_DrawPixel(x0 + x, y0 - y, true);
            SSD1306_DrawPixel(x0 + y, y0 - x, true);
        }
        if (cornername & 0x8) {
            SSD1306_DrawPixel(x0 - y, y0 + x, true);
            SSD1306_DrawPixel(x0 - x, y0 + y, true);
        }
        if (cornername & 0x1) {
            SSD1306_DrawPixel(x0 - y, y0 - x, true);
            SSD1306_DrawPixel(x0 - x, y0 - y, true);
        }
    }

}

void SSD1306_FillCircle(int16_t x0, int16_t y0, int16_t r, bool color) {
    SSD1306_DrawFastVLine(x0, y0 - r, 2 * r + 1, color);
    SSD1306_FillCircleHelper(x0, y0, r, 3, 0, color);
}

// Used to do circles and roundrects

void SSD1306_FillCircleHelper(int16_t x0, int16_t y0, int16_t r, uint8_t cornername, int16_t delta, bool color) {
    int16_t f = 1 - r;
    int16_t ddF_x = 1;
    int16_t ddF_y = -2 * r;
    int16_t x = 0;
    int16_t y = r;

    while (x < y) {
        if (f >= 0) {
            y--;
            ddF_y += 2;
            f += ddF_y;
        }
        x++;
        ddF_x += 2;
        f += ddF_x;

        if (cornername & 0x01) {
            SSD1306_DrawFastVLine(x0 + x, y0 - y, 2 * y + 1 + delta, color);
            SSD1306_DrawFastVLine(x0 + y, y0 - x, 2 * x + 1 + delta, color);
        }
        if (cornername & 0x02) {
            SSD1306_DrawFastVLine(x0 - x, y0 - y, 2 * y + 1 + delta, color);
            SSD1306_DrawFastVLine(x0 - y, y0 - x, 2 * x + 1 + delta, color);
        }
    }

}

// Draw a rectangle

void SSD1306_DrawRect(uint8_t x, uint8_t y, uint8_t w, uint8_t h) {
    SSD1306_DrawFastHLine(x, y, w, true);
    SSD1306_DrawFastHLine(x, y + h - 1, w, true);
    SSD1306_DrawFastVLine(x, y, h, true);
    SSD1306_DrawFastVLine(x + w - 1, y, h, true);
}

// Draw a rounded rectangle

void SSD1306_DrawRoundRect(uint8_t x, uint8_t y, uint8_t w, uint8_t h, uint8_t r) {
    // smarter version
    SSD1306_DrawFastHLine(x + r, y, w - 2 * r, true); // Top
    SSD1306_DrawFastHLine(x + r, y + h - 1, w - 2 * r, true); // Bottom
    SSD1306_DrawFastVLine(x, y + r, h - 2 * r, true); // Left
    SSD1306_DrawFastVLine(x + w - 1, y + r, h - 2 * r, true); // Right
    // draw four corners
    SSD1306_DrawCircleHelper(x + r, y + r, r, 1);
    SSD1306_DrawCircleHelper(x + w - r - 1, y + r, r, 2);
    SSD1306_DrawCircleHelper(x + w - r - 1, y + h - r - 1, r, 4);
    SSD1306_DrawCircleHelper(x + r, y + h - r - 1, r, 8);
}

// Fill a rounded rectangle

void SSD1306_FillRoundRect(uint8_t x, uint8_t y, uint8_t w, uint8_t h, uint8_t r, bool color) {
    // smarter version
    SSD1306_FillRect(x + r, y, w - 2 * r, h, color);
    // draw four corners
    SSD1306_FillCircleHelper(x + w - r - 1, y + r, r, 1, h - 2 * r - 1, color);
    SSD1306_FillCircleHelper(x + r, y + r, r, 2, h - 2 * r - 1, color);
}

// Draw a triangle

void SSD1306_DrawTriangle(uint8_t x0, uint8_t y0, uint8_t x1, uint8_t y1, uint8_t x2, uint8_t y2) {
    SSD1306_DrawLine(x0, y0, x1, y1, true);
    SSD1306_DrawLine(x1, y1, x2, y2, true);
    SSD1306_DrawLine(x2, y2, x0, y0, true);
}

// Fill a triangle

void SSD1306_FillTriangle(int16_t x0, int16_t y0, int16_t x1, int16_t y1, int16_t x2, int16_t y2, bool color) {
    int16_t a, b, y, last;
    // Sort coordinates by Y order (y2 >= y1 >= y0)
    if (y0 > y1) {
        ssd1306_swap(y0, y1);
        ssd1306_swap(x0, x1);
    }
    if (y1 > y2) {
        ssd1306_swap(y2, y1);
        ssd1306_swap(x2, x1);
    }
    if (y0 > y1) {
        ssd1306_swap(y0, y1);
        ssd1306_swap(x0, x1);
    }

    if (y0 == y2) { // Handle awkward all-on-same-line case as its own thing
        a = b = x0;
        if (x1 < a) a = x1;
        else if (x1 > b) b = x1;
        if (x2 < a) a = x2;
        else if (x2 > b) b = x2;
        SSD1306_DrawFastHLine(a, y0, b - a + 1, color);
        return;
    }

    int16_t
    dx01 = x1 - x0,
            dy01 = y1 - y0,
            dx02 = x2 - x0,
            dy02 = y2 - y0,
            dx12 = x2 - x1,
            dy12 = y2 - y1;
    int32_t sa = 0, sb = 0;

    // For upper part of triangle, find scanline crossings for segments
    // 0-1 and 0-2.  If y1=y2 (flat-bottomed triangle), the scanline y1
    // is included here (and second loop will be skipped, avoiding a /0
    // error there), otherwise scanline y1 is skipped here and handled
    // in the second loop...which also avoids a /0 error here if y0=y1
    // (flat-topped triangle).
    if (y1 == y2) last = y1; // Include y1 scanline
    else last = y1 - 1; // Skip it

    for (y = y0; y <= last; y++) {
        a = x0 + sa / dy01;
        b = x0 + sb / dy02;
        sa += dx01;
        sb += dx02;
        /* longhand:
        a = x0 + (x1 - x0) * (y - y0) / (y1 - y0);
        b = x0 + (x2 - x0) * (y - y0) / (y2 - y0);
         */
        if (a > b) ssd1306_swap(a, b);
        SSD1306_DrawFastHLine(a, y, b - a + 1, color);
    }

    // For lower part of triangle, find scanline crossings for segments
    // 0-2 and 1-2.  This loop is skipped if y1=y2.
    sa = dx12 * (y - y1);
    sb = dx02 * (y - y0);
    for (; y <= y2; y++) {
        a = x1 + sa / dy12;
        b = x0 + sb / dy02;
        sa += dx12;
        sb += dx02;
        /* longhand:
        a = x1 + (x2 - x1) * (y - y1) / (y2 - y1);
        b = x0 + (x2 - x0) * (y - y0) / (y2 - y0);
         */
        if (a > b) ssd1306_swap(a, b);
        SSD1306_DrawFastHLine(a, y, b - a + 1, color);
    }
}

// invert the display

void SSD1306_InvertDisplay(bool i) {
    if (i)
        ssd1306_command(SSD1306_INVERTDISPLAY_);
    else
        ssd1306_command(SSD1306_NORMALDISPLAY);
}

void SSD1306_SetTextWrap(bool w) {
    wrap = w;
}

void SSD1306_DrawChar(uint8_t x, uint8_t y, uint8_t c, uint8_t size) {
    SSD1306_GotoXY(x, y);
    SSD1306_TextSize(size);
    SSD1306_Print(c);
}

void SSD1306_DrawText(uint8_t x, uint8_t y, char *_text, uint8_t size) {
    SSD1306_GotoXY(x, y);
    SSD1306_TextSize(size);
    while (*_text != '\0')
        SSD1306_Print(*_text++);

}

// move cursor to position (x, y)

void SSD1306_GotoXY(uint8_t x, uint8_t y) {
    if ((x >= SSD1306_LCDWIDTH) || (y >= SSD1306_LCDHEIGHT))
        return;
    x_pos = x;
    y_pos = y;
}

// set text size

void SSD1306_TextSize(uint8_t t_size) {
    if (t_size < 1)
        t_size = 1;
    text_size = t_size;
}

/* print single char
    \a  Set cursor position to upper left (0, 0)
    \b  Move back one position
    \n  Go to start of current line
    \r  Go to line below
 */
void SSD1306_Print(uint8_t c) {
    bool _color;
    uint8_t i, j, line;

    if (c == ' ' && x_pos == 0 && wrap)
        return;
    if (c == '\a') {
        x_pos = y_pos = 0;
        return;
    }
    if ((c == '\b') && (x_pos >= text_size * 6)) {
        x_pos -= text_size * 6;
        return;
    }
    if (c == '\r') {
        x_pos = 0;
        return;
    }
    if (c == '\n') {
        y_pos += text_size * 8;
        if ((y_pos + text_size * 7) > SSD1306_LCDHEIGHT)
            y_pos = 0;
        return;
    }

    if ((c < ' ') || (c > '~'))
        c = '?';

    for (i = 0; i < 5; i++) {
        if (c < 'S')
            line = Font[(c - ' ') * 5 + i];
        else
            line = Font2[(c - 'S') * 5 + i];

        for (j = 0; j < 7; j++, line >>= 1) {
            if (line & 0x01)
                _color = true;
            else
                _color = false;
            if (text_size == 1) SSD1306_DrawPixel(x_pos + i, y_pos + j, _color);
            else SSD1306_FillRect(x_pos + (i * text_size), y_pos + (j * text_size), text_size, text_size, _color);
        }
    }

    SSD1306_FillRect(x_pos + (5 * text_size), y_pos, text_size, 7 * text_size, false);

    x_pos += text_size * 6;

    if (x_pos > (SSD1306_LCDWIDTH + text_size * 6))
        x_pos = SSD1306_LCDWIDTH;

    if (wrap && (x_pos + (text_size * 5)) > SSD1306_LCDWIDTH) {
        x_pos = 0;
        y_pos += text_size * 8;
        if ((y_pos + text_size * 7) > SSD1306_LCDHEIGHT)
            y_pos = 0;
    }
}

//// print custom char (dimension: 7x5 pixel)
//void SSD1306_PutCustomC(rom uint8_t *c)
//{
//  bool _color;
//  uint8_t i, j, line;
//  
//  for(i = 0; i < 5; i++ ) {
//    line = c[i];
//
//    for(j = 0; j < 7; j++, line >>= 1) {
//      if(line & 0x01)
//        _color = true;
//      else
//        _color = false;
//      if(text_size == 1) SSD1306_DrawPixel(x_pos + i, y_pos + j, _color);
//      else               SSD1306_FillRect(x_pos + (i * text_size), y_pos + (j * text_size), text_size, text_size, _color);
//    }
//  }
//
//  SSD1306_FillRect(x_pos + (5 * text_size), y_pos, text_size, 7 * text_size, false);
//
//  x_pos += (text_size * 6);
//
//  if( x_pos > (SSD1306_LCDWIDTH + text_size * 6) )
//    x_pos = SSD1306_LCDWIDTH;
//
//  if (wrap && (x_pos + (text_size * 5)) > SSD1306_LCDWIDTH)
//  {
//    x_pos = 0;
//    y_pos += text_size * 8;
//    if((y_pos + text_size * 7) > SSD1306_LCDHEIGHT)
//      y_pos = 0;
//  }
//}

void oledInitSH1106() {

    char vccstate = SH1106_EXTERNALVCC;
    // Init sequence for 128x64 OLED module
    oledCommand(SH1106_DISPLAYOFF); // 0xAE
    oledCommand(SH1106_SETDISPLAYCLOCKDIV); // 0xD5
    oledCommand(0x80); // the suggested ratio 0x80
    oledCommand(SH1106_SETMULTIPLEX); // 0xA8
    oledCommand(0x3F);
    oledCommand(SH1106_SETDISPLAYOFFSET); // 0xD3
    oledCommand(0x00); // no offset

    oledCommand(SH1106_SETSTARTLINE | 0x0); // line #0 0x40
    oledCommand(SH1106_CHARGEPUMP); // 0x8D
    if (vccstate == SH1106_EXTERNALVCC) {
        oledCommand(0x10);
    } else {
        oledCommand(0x14);
    }
    oledCommand(SH1106_MEMORYMODE); // 0x20
    oledCommand(0x00); // 0x0 act like ks0108
    oledCommand(SH1106_SEGREMAP | 0x1);
    oledCommand(SH1106_COMSCANDEC);
    oledCommand(SH1106_SETCOMPINS); // 0xDA
    oledCommand(0x12);
    oledCommand(SH1106_SETCONTRAST); // 0x81
    if (vccstate == SH1106_EXTERNALVCC) {
        oledCommand(0x9F);
    } else {
        oledCommand(0xCF);
    }
    oledCommand(SH1106_SETPRECHARGE); // 0xd9
    if (vccstate == SH1106_EXTERNALVCC) {
        oledCommand(0x22);
    } else {
        oledCommand(0xF1);
    }
    oledCommand(SH1106_SETVCOMDETECT); // 0xDB
    oledCommand(0x40);
    oledCommand(SH1106_DISPLAYALLON_RESUME); // 0xA4
    oledCommand(SH1106_NORMALDISPLAY); // 0xA6
}

void oledInit() {
    /*
        oledCommand( SSD1308_Display_Off_Cmd );
        __delay_ms( 100 );
        oledCommand( SSD1308_Display_On_Cmd );
        __delay_ms( 100 );
        oledCommand( SSD1308_Normal_Display_Cmd );
        oledCommand( SSD1308_Dectivate_Scroll_Cmd );
     */
    // olex way : 
#define OLED_SETCONTRAST 0x81
#define OLED_DISPLAYALLON_RESUME 0xA4
#define OLED_DISPLAYALLON 0xA5
#define OLED_NORMALDISPLAY 0xA6
#define OLED_INVERTDISPLAY 0xA7
#define OLED_DISPLAYOFF 0xAE
#define OLED_DISPLAYON 0xAF
#define OLED_SETDISPLAYOFFSET 0xD3
#define OLED_SETCOMPINS 0xDA
#define OLED_SETVCOMDETECT 0xDB
#define OLED_SETDISPLAYCLOCKDIV 0xD5
#define OLED_SETPRECHARGE 0xD9
#define OLED_SETMULTIPLEX 0xA8
#define OLED_SETLOWCOLUMN 0x00
#define OLED_SETHIGHCOLUMN 0x10
#define OLED_SETSTARTLINE 0x40
#define OLED_MEMORYMODE 0x20
#define OLED_COLUMNADDR 0x21
#define OLED_PAGEADDR   0x22
#define OLED_COMSCANINC 0xC0
#define OLED_COMSCANDEC 0xC8
#define OLED_SEGREMAP 0xA0
#define OLED_CHARGEPUMP 0x8D


    oledCommand(OLED_DISPLAYOFF);
    __delay_ms(100);
    oledCommand(OLED_SETDISPLAYCLOCKDIV);
    oledCommand(0x80); // the suggested ratio 0x80
    __delay_ms(100);
    oledCommand(OLED_SETMULTIPLEX);
    oledCommand(0x3F); //OKKIO 0x3F = 64 0x1F = 32
    __delay_ms(100);
    oledCommand(OLED_SETDISPLAYOFFSET);
    oledCommand(0x0); // no offset
    __delay_ms(100);
    oledCommand(OLED_SETSTARTLINE | 0x0); // line #0
    __delay_ms(100);
    oledCommand(OLED_CHARGEPUMP);
    oledCommand(0x14); //OKKIO 0xAF  =>ssd1306_command1((vccstate == SSD1306_EXTERNALVCC) ? 0x10 : 0x14);
    __delay_ms(100);
    oledCommand(OLED_MEMORYMODE);
    oledCommand(0x0); // 0x0 act like ks0108
    __delay_ms(100);
    // 0x0 act like ks0108
    oledCommand(OLED_SEGREMAP | 0x1);
    oledCommand(OLED_COMSCANDEC);
    oledCommand(OLED_SETCOMPINS); // 0xDA
    oledCommand(0x12); //OKKIO 0x12 = 64 0x02 = 32
    oledCommand(OLED_SETCONTRAST); // 0x81
    oledCommand(0xCF); //OKKIO 0x8F  =>ssd1306_command1((vccstate == SSD1306_EXTERNALVCC) ? 0x9F : 0xCF);
    oledCommand(OLED_SETPRECHARGE); // 0xd9
    oledCommand(0xF1);
    oledCommand(OLED_SETVCOMDETECT); // 0xDB
    oledCommand(0x40);
    oledCommand(OLED_DISPLAYALLON_RESUME); // 0xA4
    oledCommand(OLED_NORMALDISPLAY); // 0xA6
    oledCommand(SSD1306_DEACTIVATE_SCROLL);
    oledCommand(OLED_DISPLAYON); //--turn on oled panel

}
