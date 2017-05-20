#include <avr/io.h>
#include <avr/pgmspace.h>
#include <util/delay.h>
#include <stdint.h>
#include "uart.h"

// BGlib includes
#include "cmd_def.h"
#include "apitypes.h"
//#include "usb_debug_only.h"
//#include "print.h"

// Teensy 2.0: LED is active high
#define LED_ON		(PORTD |= (1<<6))
#define LED_OFF		(PORTD &= ~(1<<6))
#define LED_CONFIG	(DDRD |= (1<<6))
#define CPU_PRESCALE(n)	(CLKPR = 0x80, CLKPR = (n))
#define BAUD_RATE 38400

// this is the callback function which tells the BLE API how to
// send messages via the atmega32u4's UART peripheral library
void send_bt_message(uint8_t len1, uint8_t* data1, uint16_t len2, uint8_t* data2)
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

//void recv_bt_message(void)
//{
//    const struct ble_msg *bt_message; // holds BLE message
//    struct ble_header bt_header; // holds header of message
//    unsigned char data[256] = "\0"; // holds payload of message
//
//    // clear the uart interrupt flags
//}

void blink_int(uint8_t k) {
    uint8_t i;
    for (i=0; i<k; i++) {
        LED_ON;
        _delay_ms(250);
        LED_OFF;
        _delay_ms(250);
    }
}

uint8_t ble_woke_up[4] = {0x80, 0x0C, 0x00, 0x00};
uint8_t ble_woke_score = 0;

uint8_t bytes_make_ble_discoverable[7] = {0x06, 0x00, 0x02, 0x06, 0x01, 0x02, 0x02};
uint8_t ble_discovered_response[6] =     {0x00, 0x02, 0x06, 0x01, 0x00, 0x00};
uint8_t ble_discovered_response_score = 0;

uint8_t ble_set_bondable_mode[6] =       {0x05, 0x00, 0x01, 0x05, 0x01, 0x01};
uint8_t ble_set_bondable_mode_resp[4] =  {0x00, 0x00, 0x05, 0x01};
uint8_t ble_set_bondable_score = 0;

uint8_t sm_set_params[8] =               {0x07, 0x00, 0x03, 0x05, 0x03, 0x00, 0x07, 0x05};
uint8_t sm_set_params_resp[4] =          {0x00, 0x00, 0x05, 0x03};
uint8_t sm_set_params_score = 0;

uint8_t ble_keystroke_header[8] =        {0x0F, 0x00, 0x04, 0x02, 0x00, 0x01, 0x00, 0x00};
uint8_t hid_press_A[8] =                 {0x02, 0x00, 0x04, 0x00, 0x00, 0x00, 0x00, 0x00};
uint8_t hid_release_A[8] =               {0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00};
uint8_t host_received_A_response[6] =    {0x00, 0x02, 0x02, 0x00, 0x00, 0x00};
uint8_t host_received_A_response_score = 0;

uint8_t has_paired = 0; // 0 == false, 1 == true
uint8_t can_bond = 0; // 0 == false, 1 == true
uint8_t has_sm_params_set = 0;
uint8_t got_A = 0; // 0 == false, 1 == true

int main(void)
{
    bglib_output = &send_bt_message;

    uint8_t c;
    uint8_t i;

    //uint8_t error_code[2] = {0x00, 0x00}; // STORE AS LITTLE ENDIAN

    CPU_PRESCALE(0);  // run at 16 MHz
    uart_init(BAUD_RATE);
    LED_OFF;

    _delay_ms(500);

    if (uart_available()) {

        for (i=0; i<4; i++) {

            c = uart_getchar();

            if (c == ble_woke_up[i]) {
                ble_woke_score++;
            }
        }

        // burn through remaining 12 info bytes
        for (i = 0; i < 12; i++) {
            c = uart_getchar();
        }

        // hooray! ble woke up!
        if (ble_woke_score == 4) {
            blink_int(3);
        }
    }

    _delay_ms(500);

    ble_cmd_gap_set_mode(0x02, 0x02);
    // send GAP set mode request
    for (i=0; i<7; i++) {
        c = bytes_make_ble_discoverable[i];
        uart_putchar(c);
    }

    // get response
    for (i=0; i<6; i++) {
        c = uart_getchar();

        if (c == ble_discovered_response[i]) {
            ble_discovered_response_score++;
        }
    }

    if (ble_discovered_response_score == 6) {
        has_paired = 1;
        LED_ON;
    }


    while (1) {

        _delay_ms(25);
        //if (has_paired == 1) {

        //    // SEND: set_bondable
        //    for (i=0; i<6; i++) {
        //        c = ble_set_bondable_mode[i];
        //        uart_putchar(c);
        //    }

        //    // RECV: set_bondable
        //    for (i=0; i<4; i++) {
        //        c = uart_getchar();

        //        if (c == ble_set_bondable_mode_resp[i]) {
        //            ble_set_bondable_score++;
        //        }
        //    }

        //    if (ble_set_bondable_score == 4) {
        //        can_bond = 1;
        //    }

        //    // SEND: sm_set_params
        //    for (i=0; i<8; i++) {
        //        c = sm_set_params[i];
        //        uart_putchar(c);
        //    }

        //    // RECV: sm_set_params
        //    for (i=0; i<4; i++) {
        //        c = uart_getchar();

        //        if (c == sm_set_params_resp[i]) {
        //            sm_set_params_score++;
        //        }
        //    }

        //    if (sm_set_params_score == 4) {
        //        has_sm_params_set = 1;
        //    }

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
        //                blink_int(error_code[i]);
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
