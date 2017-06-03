import time
import serial

try:
    ser = serial.Serial(port='/dev/ttyUSB0', baudrate = 38400)
except serial.SerialException:
    print 'SERIAL DEVICE NOT DETECTED!'
    exit(0)

while ser:
    print 'recv: 0x{}'.format(ser.read(1).encode('hex'))

print 'all done'
