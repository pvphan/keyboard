#ifndef bglib_ugly_h
#define bglib_ugly_h

#include <stdint.h>

int wait_for_ble_wake(void);
int set_gap_mode(void);
int set_bondable_mode(void);
int set_sm_params(void);

#endif
