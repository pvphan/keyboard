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
    LED_OFF;
    CPU_PRESCALE(0);  // run at 16 MHz
    uart_init(BAUD_RATE);

    // wait for BLE `system_boot` event
    if (wait_for_ble_wake() != 0) {
        blink_fast(10);
        return 0;
    }

    // set the GAP mode to discoverable
    if (set_gap_mode() != 0) {
        blink_fast(10);
        return 0;
    }

    // set bondable mode
    if (set_bondable_mode() != 0) {
        blink_fast(10);
        return 0;
    }

    // set security manager params
    if (set_sm_params() != 0) {
        blink_fast(10);
        return 0;
    }

    // set encryption

    while (1) {

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
