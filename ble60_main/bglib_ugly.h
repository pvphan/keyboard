#ifndef bglib_ugly_h
#define bglib_ugly_h

#include <stdint.h>
#include <string.h>

int wait_for_ble_wake(void);
int set_gap_mode(void);
int set_bondable_mode(void);
int set_sm_params(void);
int start_encryption(uint8_t*, uint8_t*);
int get_attribute_database_status(void);
//int get_connection_status(void);

#endif
