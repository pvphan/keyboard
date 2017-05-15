import time
import serial

try:
    ser = serial.Serial(port='/dev/ttyAMA0', baudrate = 38400)
except serial.SerialException:
    print 'SERIAL DEVICE NOT DETECTED!'
    exit(0)


print 'throwing out: {}'.format(ser.read(1))
while ser:
    ser.write(raw_input('send: '))
    print 'recv: {}'.format(ser.read(1))

print 'all done'
