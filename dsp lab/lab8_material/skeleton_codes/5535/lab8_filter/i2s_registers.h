#ifndef REGISTER_I2S_H_
#define REGISTER_I2S_H_

/* For more information see SPRUFX4A - Section 1.3 - Table 1-13 */

/* I2S2 Register Mapping */

#define I2S2_SCTRL            *(volatile ioport Uint16*)(0x2A00)  //I2S2 Serializer Control Register
#define I2S2_SRATE            *(volatile ioport Uint16*)(0x2A04)  //I2S2 Sample Rate Generator Register

#define I2S2_INTFL            *(volatile ioport Uint16*)(0x2A10)   //I2S2 Interrupt Flag Register
#define I2S2_INTMASK          *(volatile ioport Uint16*)(0x2A14)  //I2S2 Interrupt Mask Register

#define I2S2_TXLT0  			*(volatile ioport Uint16*)(0x2A08)  //I2S2 Transmit Left Data 0 Register
#define I2S2_TXLT1      		*(volatile ioport Uint16*)(0x2A09)  //I2S2 Transmit Left Data 1 Register
#define I2S2_TXRT0     			*(volatile ioport Uint16*)(0x2A0C)  //I2S2 Transmit Right Data 0 Register
#define I2S2_TXRT1     			*(volatile ioport Uint16*)(0x2A0D)  //I2S2 Transmit Right Data 1 Register


#define I2S2_RXLT0      *(volatile ioport Uint16*)(0x2A28) //I2S2 Receive Left Data 0 Register
#define I2S2_RXLT1      *(volatile ioport Uint16*)(0x2A29) //I2S2 Receive Left Data 1 Register
#define I2S2_RXRT0      *(volatile ioport Uint16*)(0x2A2C) //I2S2 Receive Left Data 1 Register
#define I2S2_RXRT1      *(volatile ioport Uint16*)(0x2A2D) //I2S2 Receive Left Data 1 Register

#endif /*REGISTER_I2S_H_*/
