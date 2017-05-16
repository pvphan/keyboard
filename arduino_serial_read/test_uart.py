#!/usr/bin/python

import serial
from time import sleep
print 

from which_path_arduino import findArduinoPath

ser = serial.Serial(findArduinoPath(), 9600)

while True:
    # main communication loop
    #ser.write(raw_input("Press enter to actuate gripper.") + '\n')
    resp = ser.read()
    print resp

print 'done'
