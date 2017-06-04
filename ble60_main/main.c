#include <avr/io.h>
#include <avr/pgmspace.h>
#include <util/delay.h>
#include <stdint.h>
#include "uart.h"
#include "bglib_ugly.h"

// Teensy 2.0: LED is active high
#define LED_ON		(PORTD |= (1<<6))
#define LED_OFF		(PORTD &= ~(1<<6))
#define LED_CONFIG	(DDRD |= (1<<6))
#define CPU_PRESCALE(n)	(CLKPR = 0x80, CLKPR = (n))
#define BAUD_RATE 38452


void TURN_LED_ON(uint8_t n) {
    if (n == 0) {
        LED_ON;
    } else {
        PORTB |= (1<<n);
    }
}

void TURN_LED_OFF(uint8_t n) {
    if (n == 0) {
        LED_OFF;
    } else {
        PORTB &= ~(1<<n);
    }
}

// http://stackoverflow.com/questions/31577866/c-programming-convert-integer-to-binary-array
void int_to_bin_digit(uint8_t in, uint8_t count, uint8_t* out)
{
    /* assert: count <= sizeof(int)*CHAR_BIT */
    uint8_t mask = 1 << (count-1);
    uint8_t i;
    for (i = 0; i < count; i++) {
        out[i] = (in & mask) ? 1 : 0;
        in <<= 1;
    }
}

void write_to_leds(uint8_t byte) {
    uint8_t i = 0;
    for (i=0; i<8; i++) {
        TURN_LED_ON(i);
    }
    _delay_ms(1000);
    for (i=0; i<8; i++) {
        TURN_LED_OFF(i);
    }
    _delay_ms(1000);

    uint8_t led_array[8];
    int_to_bin_digit(byte, 8, led_array); 

    for (i=0; i<8; i++) {
        if (led_array[i] == 0) {
            TURN_LED_OFF(i);
        } else if (led_array[i] == 1) {
            TURN_LED_ON(i);
        }
    }

    _delay_ms(8000);

    for (i=0; i<8; i++) {
        TURN_LED_OFF(i);
    }
}

void night_rider_leds(void) {
    int k;
    int i;
    for (k=0; k<3; k++) {
        for (i=0; i<8; i++) {
            TURN_LED_ON(i);
            if (i > 0) {
                TURN_LED_OFF(i-1);
            }
            _delay_ms(100);
        }
        for (i=7; i>-1; i--) {
            TURN_LED_ON(i);
            if (i < 7) {
                TURN_LED_OFF(i+1);
            }
            _delay_ms(100);
        }
        TURN_LED_OFF(0);
    }
}

void blink_slow(uint8_t k) {
    uint8_t i;
    for (i=0; i<k; i++) {
        LED_ON;
        _delay_ms(250);
        LED_OFF;
        _delay_ms(250);
    }
}

void blink_fast(uint8_t k) {
    uint8_t i;
    for (i=0; i<k; i++) {
        LED_ON;
        _delay_ms(100);
        LED_OFF;
        _delay_ms(100);
    }
}


const uint8_t byte_array_A[8]       = {0x02, 0x00, 0x04, 0x00, 0x00, 0x00, 0x00, 0x00};
const uint8_t byte_array_release[8] = {0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00};

int main(void)
{
    uint8_t c;
    int i;

    LED_OFF;
    CPU_PRESCALE(0);  // run at 16 MHz
    uart_init(BAUD_RATE);

    LED_ON;

    while (1) {

        uart_putchar(0xFF);
        for (i=0; i<8; i++) {
            uart_putchar(byte_array_A[i]);
        }

        //uart_putchar(0xFF);
        //for (i=0; i<8; i++) {
        //    uart_putchar(byte_array_release[i]);
        //}

        _delay_ms(1000);
    }
}
