#include <avr/io.h>
#include <avr/interrupt.h>
#include <util/delay.h>
#include <string.h>
#include "uart.h"

uint8_t ble_woke_up[4] = {0x80, 0x0C, 0x00, 0x00};
uint8_t ble_woke_score = 0;

uint8_t bytes_make_ble_discoverable[7] = {0x06, 0x00, 0x02, 0x06, 0x01, 0x02, 0x02};
uint8_t ble_discovered_response[6] =     {0x00, 0x02, 0x06, 0x01, 0x00, 0x00};
uint8_t ble_discovered_response_score = 0;

uint8_t ble_set_bondable_mode[6] =       {0x05, 0x00, 0x01, 0x05, 0x01, 0x00};
uint8_t ble_set_bondable_mode_resp[4] =  {0x00, 0x00, 0x05, 0x01};
uint8_t ble_set_bondable_score = 0;

uint8_t sm_set_params[8] =               {0x07, 0x00, 0x03, 0x05, 0x03, 0x00, 0x07, 0x03};
uint8_t sm_set_params_resp[4] =          {0x00, 0x00, 0x05, 0x03};
uint8_t sm_set_params_score = 0;

uint8_t ble_keystroke_header[8] =        {0x0F, 0x00, 0x04, 0x02, 0x00, 0x01, 0x00, 0x00};
uint8_t hid_press_A[8] =                 {0x02, 0x00, 0x04, 0x00, 0x00, 0x00, 0x00, 0x00};
uint8_t hid_release_A[8] =               {0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00};
uint8_t host_received_A_response[6] =    {0x00, 0x02, 0x02, 0x00, 0x00, 0x00};
uint8_t host_received_A_response_score = 0;

uint8_t start_encryption_msg[7] =        {0x06, 0x00, 0x02, 0x05, 0x00, 0x00, 0x00};
uint8_t start_encryption_rsp[7] =        {0x00, 0x03, 0x05, 0x00, 0x00, 0x00, 0x00};
uint8_t start_encryption_score = 0;

uint8_t event_attribute_database_status[7] = {0x80, 0x03, 0x02, 0x02, 0x16, 0x00, 0x01};
uint8_t event_attribute_database_status_score = 0;

uint8_t connection_status_header[4] =    {0x80, 0x10, 0x03, 0x00};
uint8_t connection_status_score = 0;

//uint8_t set_pairing_dist_keys[7] =       {0x06, 0x00, 0x02, 0x05, 0x08, 

// 0 == false, 1 == true
uint8_t has_paired = 0;
uint8_t can_bond = 0;
uint8_t has_sm_params_set = 0;
uint8_t got_A = 0;

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

int wait_for_ble_wake(void) {

    uint8_t try_limit = 200;
    uint8_t try_counter = 0;
    uint8_t c;
    uint8_t i;

    while (!uart_available()) {
        _delay_ms(25);
        try_counter++;
        if (try_counter >= try_limit) {
            return -1;
        }
    }

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
            blink_slow(3);
        }
    }

    return 0;
}

int set_gap_mode(void) {

    uint8_t c;
    uint8_t i;

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
        return 0;
    } else {
        return -1;
    }
}

int set_bondable_mode(void) {
    uint8_t c;
    uint8_t i;

    // SEND: set_bondable
    for (i=0; i<6; i++) {
        c = ble_set_bondable_mode[i];
        uart_putchar(c);
    }

    // RECV: set_bondable
    for (i=0; i<4; i++) {
        c = uart_getchar();

        if (c == ble_set_bondable_mode_resp[i]) {
            ble_set_bondable_score++;
        }
    }

    if (ble_set_bondable_score == 4) {
        can_bond = 1;
        return 0;
    } else {
        return -1;
    }
}

int set_sm_params(void) {
    uint8_t c;
    uint8_t i;

    // SEND: sm_set_params
    for (i=0; i<8; i++) {
        c = sm_set_params[i];
        uart_putchar(c);
    }

    // RECV: sm_set_params
    for (i=0; i<4; i++) {
        c = uart_getchar();

        if (c == sm_set_params_resp[i]) {
            sm_set_params_score++;
        }
    }

    if (sm_set_params_score == 4) {
        has_sm_params_set = 1;
        return 0;
    } else {
        return -1;
    }
}

int get_attribute_database_status() {
    uint8_t c;
    uint8_t i;

    while (!uart_available()) { ; }

    for (i=0; i<7; i++) {
        c = uart_getchar();

        if (c == event_attribute_database_status[i]) {
            event_attribute_database_status_score++;
        }
    }

    if (event_attribute_database_status_score == 7) {
        return 0;
    } else {
        return -1;
    }
}

int get_connection_status(uint8_t *handle, uint8_t *payload) {

    uint8_t c;
    uint8_t i;

    while (!uart_available()) { ; }

    for (i=0; i<4; i++) {
        c = uart_getchar();

        if (c == connection_status_header[i]) {
            connection_status_score++;
        }
    }

    for (i=0; i<16; i++) {
        c = uart_getchar();
        if (i == 0) {
            memcpy(handle, &c, sizeof(uint8_t));
        } else {
            memcpy(payload+i-1, &c, sizeof(uint8_t));
        }
    }

    if (connection_status_score == 4) {
        return 0;
    } else {
        return -1;
    }
}

int start_encryption(uint8_t *handle, uint8_t *result) {
    uint8_t c;
    uint8_t i;

    // eat all serial
    while (uart_available()) {
        c = uart_getchar();
    }

    // SEND
    for (i=0; i<7; i++) {
        c = start_encryption_msg[i];
        uart_putchar(c);
    }

    // RECV
    for (i=0; i<7; i++) {
        c = uart_getchar();

        if (c == start_encryption_rsp[i]) {
            start_encryption_score++;
        }

        if (i == 4) {
            memcpy(handle, &c, sizeof(uint8_t));
        }

        if (i == 5) {
            memcpy(result, &c, sizeof(uint8_t));
        }
        if (i == 6) {
            memcpy(result+1, &c, sizeof(uint8_t));
        }
            
    }

    if (start_encryption_score >= 3) {
        if (start_encryption_score == 7) {
            return 0;
        } else {
            return 1;
        }
    } else {
        return -1;
    }
}
