#include "../h/funcSelector.h"

void AAUART_PutString(const char *txstr) {
}

void AAUART_GetString() {
}

void USB_PutString(const char *txstr) {
}

void USB_GetString() {
}

void PROTOCOL_Handler(functionGetString getStr, functionPutString putStr) {
    getStr();

    putStr("x");
}