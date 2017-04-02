import time
import serial

ser = serial.Serial(port='/dev/ttyAMA0', baudrate = 38400)

while ser:
    ser.write('B')
    print ser.readline()
    time.sleep(1)

print 'all done'
