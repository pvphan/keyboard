// source: https://www.pjrc.com/teensy/uart.html

#include <avr/io.h>
#include <avr/pgmspace.h>
#include <util/delay.h>
#include <stdint.h>
#include "uart.h"

// BGlib includes
#include "commands.c"
#include "cmd_def.h"
#include "cmd_def.c"
#include "apitypes.h"


// FROM blinky.c -----------------------
#include "usb_debug_only.h"
#include "print.h"

// Teensy 2.0: LED is active high
#if defined(__AVR_ATmega32U4__) || defined(__AVR_AT90USB1286__)
#define LED_ON		(PORTD |= (1<<6))
#define LED_OFF		(PORTD &= ~(1<<6))

// Teensy 1.0: LED is active low
#else
#define LED_ON	(PORTD &= ~(1<<6))
#define LED_OFF	(PORTD |= (1<<6))
#endif

#define LED_CONFIG	(DDRD |= (1<<6))
#define CPU_PRESCALE(n)	(CLKPR = 0x80, CLKPR = (n))
#define DIT 80		/* unit time for morse code */

void morse_character(char c);
void morse_P(const char *s);
const unsigned char morse_code_table[];

// /FROM blinky.c -----------------------



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
    uint8_t c;
    uint8_t c0;
    uint8_t c1;
    uint8_t c2;
    uint8_t c3;
    uint8_t i;

    CPU_PRESCALE(0);  // run at 16 MHz
    uart_init(BAUD_RATE);
    LED_OFF;

    ////stop previous operation
    //ble_cmd_gap_end_procedure();
    ////get connection status,current command will be handled in response
    //ble_cmd_connection_get_status(0);
    //ble_cmd_gap_set_mode(2,2);

    while (1) {
        if (uart_available()) {
            c0 = uart_getchar();
            if (c0 == 0x80) {
                c1 = uart_getchar();
                if (c1 == 0x0C) {
                    c2 = uart_getchar();
                    if (c2 == 0x00) {
                        c3 = uart_getchar();
                        if (c3 == 0x00) {

                            // get remaining 12 info bytes
                            for (i = 0; i < 12; i++) {
                                c = uart_getchar();
                            }

                            // send GAP set mode request
                            uart_putchar(0x00);
                            uart_putchar(0x02);
                            uart_putchar(0x06);
                            uart_putchar(0x01);
                            uart_putchar(0x02);
                            uart_putchar(0x02);

                            _delay_ms(250);

                            // recv GAP set mode response
                            c = uart_getchar();

                            // TODO: BREAKING HERE! not getting a response from BLE, 
                            //       probably a problem with `uart_putchar()`, maybe try the 
                            //       ble-1.5.0_src/thermometer-demo version of uart.c/.h?
                            if (c == 0x00) {
                                c = uart_getchar();
                                LED_ON;
                                if (c==0x02) {
                                    c = uart_getchar();
                                    LED_ON;
                                    if (c==0x06) {
                                        c = uart_getchar();
                                        LED_ON;
                                        if (c==0x01) {
                                            LED_ON;
                                            c = uart_getchar();
                                            if (c==0x00) {
                                                c = uart_getchar();
                                                if (c==0x00) {
                                                    LED_ON;
                                                }
                                            }
                                        }
                                    }
                                }
                            }
                        }
                    }
                }
            }
            _delay_ms(250);
        }
    }
}
