Notes:
---
BLE113:
    - use one of the BLE113 firmware from bglib_jrow for UART with bgapi: BGLib_U1A1P_38400_noflow

atmega32u4:
    - get UART working from the mGH60, steal Makefile from blinky_pjrc (or something)
    - UART to BLE113, reference the `uart` folder
    - Switch up pins so RX TX are free for UART, roll in UART stuff to tmk_firmware (gh60), try to get them to work together