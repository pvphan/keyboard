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
#define BAUD_RATE 38400


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


int main(void)
{
    uint8_t c;

    LED_OFF;
    CPU_PRESCALE(0);  // run at 16 MHz
    uart_init(BAUD_RATE);

    // wait for BLE `system_boot` event
    if (wait_for_ble_wake() != 0) {
        blink_fast(10);
        return 0;
    }

    // DO ALL CONFIGURATION HERE PRIOR TO PAIRING
    // set bondable mode
    if (set_bondable_mode() != 0) {
        blink_fast(10);
        return 0;
    }

    // set the GAP mode to discoverable
    if (set_gap_mode() != 0) {
        blink_fast(10);
        return 0;
    }

    // set security manager params
    if (set_sm_params() != 0) {
        blink_fast(10);
        return 0;
    }

    
    uint8_t *handle = (uint8_t*) malloc(sizeof(uint8_t));
    uint8_t *payload = (uint8_t*) malloc(16*(sizeof(uint8_t)));


    // WAIT FOR PAIRING ===========================================
    // get Attribute Database Status Event ==> "notifications are enabled"
    if (get_attribute_database_status() != 0) {
        blink_fast(10);
        return 0;
    }
    // WE SHOULD BE PAIRED NOW! ===================================

    // get Connection Status Event
    if (get_connection_status(handle, payload) != 0) {
        blink_fast(10);
        return 0;
    }


    //blink_slow(5);
    //// blink the payload
    //uint8_t i;
    //for (i=0; i<16; i++) {
    //    write_to_leds(payload+i);
    //}
    //blink_slow(5);

    
    // TODO: this doesnt work yet, gets error
    // start encryption
    uint8_t *result = (uint8_t*) malloc(2*(sizeof(uint8_t)));

    int encrypt_rc = start_encryption(handle, &result);

    if (encrypt_rc == 0) {
        // we're good!
        night_rider_leds();
        //TURN_LED_ON(0);
        //_delay_ms(2000);
        //TURN_LED_OFF(0);
    } else {
        if (encrypt_rc == 1) {
            // not quite right, write the error code to LEDs
            blink_fast(8);
            write_to_leds(*result);
            write_to_leds(*(result+1));
            blink_fast(8);
        } else if (encrypt_rc == -1) {
            // this is bad
            blink_slow(5);
        } else {
            // this is really bad
            blink_slow(10);
        }
    }


    while (1) {

        while (uart_available()) {
            c = uart_getchar();
            write_to_leds(c);
        }
        _delay_ms(25);


        //    if (can_bond == 1 && has_sm_params_set == 1) {

        //        // WAIT FOR BONDING REQUEST
        //        
        //        // try to send keystrokes
        //        
        //        // send 'press A' payload
        //        for (i=0; i<8; i++) {
        //            c = ble_keystroke_header[i];
        //            uart_putchar(c);
        //        }
        //        for (i=0; i<8; i++) {
        //            c = hid_press_A[i];
        //            uart_putchar(c);
        //        }

        //        // get response
        //        for (i=0; i<6; i++) {
        //            c = uart_getchar();

        //            if (c == host_received_A_response[i]) {
        //                host_received_A_response_score++;
        //            } else {
        //                if (i == 4) {
        //                    error_code[0] = c;
        //                } else if (i == 5) {
        //                    error_code[1] = c;
        //                }
        //            }
        //        }

        //        // blink back the error code: 0x03, 0x04 ==> 0x0403 (Write not permitted)
        //        if (host_received_A_response_score == 6) {
        //            got_A = 1;
        //        } else {
        //            for (i=0; i<2; i++) {
        //                blink_slow(error_code[i]);
        //                _delay_ms(1000);
        //            }
        //        }

        //        if (got_A == 1) {
        //            LED_ON;
        //        }

        //        // send 'release A' payload
        //        for (i=0; i<8; i++) {
        //            c = ble_keystroke_header[i];
        //            uart_putchar(c);
        //        }
        //        for (i=0; i<8; i++) {
        //            c = hid_release_A[i];
        //            uart_putchar(c);
        //        }

        //        _delay_ms(5000);
        //    }
        //}
    }
}
