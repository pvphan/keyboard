#!/usr/bin/python
# this is a duplicate from harvest/scripts/serialfinder.py, here for convenience (with ROS stuff removed)
import subprocess

def findSerialDevPathWithId(serialId):
    possiblePaths = ['/dev/ttyUSB0', '/dev/ttyUSB1', '/dev/ttyUSB2', '/dev/ttyUSB3', '/dev/ttyUSB4',]
    for path in possiblePaths:
        try:
            output = subprocess.check_output(["udevadm", "info", "--query=all", "-n", path])
            if serialId in output:
                return path
        except subprocess.CalledProcessError:
            pass

    return None

def findArduinoPath():
    return findSerialDevPathWithId("usb-1a86_USB2.0-Serial-if00-port0")

if __name__ == '__main__':
    print findArduinoPath()
