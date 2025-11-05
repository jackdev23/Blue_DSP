
#ifndef FUNCSELECTOR_H
#define	FUNCSELECTOR_H

#include <xc.h> // include processor files - each processor file is guarded.  

typedef void (*functionPutString)(const char *txstr);
typedef void (*functiontype2)(functionPutString putStr);

typedef void (*functionGetString)(void);
typedef void (*functiontype1)(functionGetString getStr);

//typedef void (*functionProtocol)(void);
//typedef void (*functiontype0)(functionGetString getStr,functionPutString putStr);

void PROTOCOL_Handler(functionGetString getStr, functionPutString putStr);

void AAUART_PutString(const char *txstr);
void AAUART_GetString(void);

void USB_PutString(const char *txstr);
void USB_GetString(void);

#endif	/* XC_HEADER_TEMPLATE_H */

