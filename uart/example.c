// source: https://www.pjrc.com/teensy/uart.html

#include <avr/io.h>
#include <avr/pgmspace.h>
#include <stdint.h>
#include "uart.h"

// BGlib includes
#include "commands.c"
#include "cmd_def.h"
#include "cmd_def.c"
#include "apitypes.h"


#define BAUD_RATE 38400

#define CPU_PRESCALE(n) (CLKPR = 0x80, CLKPR = (n))

// write a string to the uart
#define uart_print(s) uart_print_P(PSTR(s))
void uart_print_P(const char *str)
{
	char c;
	while (1) {
		c = pgm_read_byte(str++);
		if (!c) break;
		uart_putchar(c);
	}
}

//this is the callback function which tells the BLE API how to
//send messages via the 123G's UART peripheral library. The messages
//are sent over UART 5
void SendBTMessage(uint8_t len1, uint8_t* data1, uint16_t len2, uint8_t* data2)
{
    //this line assumes the BLE module is in packet mode, meaning the
    //length of the packet must be specified immediately before sending
    //the packet; this line does that
    uart_putchar(len1 + len2);
     
    //this loop sends the header of the BLE message
    for(int i = 0; i < len1; i++)
    {
        uart_putchar(data1[i]);
    }
     
    //this loop sends the payload of the BLE message
    for(int i = 0; i < len2; i++)
    {
        uart_putchar(data2[i]);
    }
     
    //wait until UART is finished sending before continuing
    while(!uart_available());
}

int main(void)
{
	//uint8_t c;
    
	CPU_PRESCALE(0);  // run at 16 MHz
	uart_init(BAUD_RATE);

    ////stop previous operation
    //ble_cmd_gap_end_procedure();
    ////get connection status,current command will be handled in response
    //ble_cmd_connection_get_status(0);
    ble_cmd_gap_set_mode(2,2);

	while (1) {
		if (uart_available()) {
			//c = uart_getchar();
			//uart_putchar(c);
			//uart_putchar('\r');
			//uart_putchar('\n');

            uart_putchar('a');
            uart_putchar('b');
            uart_putchar('c');
            uart_putchar('1');
            uart_putchar('2');
            uart_putchar('3');
		}
	}
}
