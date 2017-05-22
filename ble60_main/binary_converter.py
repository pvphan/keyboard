def binary_to_dec(bin_string):
    sum = 0
    for i in range(0, len(bin_string)):
        if bin_string[i] == "1":
            sum += 2**i

    print hex(sum)

event0 = ["00000001",
          "11000000",
          "10100000",
          "10000000",
          "00000000",
          "10100000",
          "11000000",]

print "EVENT 0:"
for line in event0:
    binary_to_dec(line)
print ""

event1 = ["00000001",
          "00001000",
          "11000000",
          "00000000",
          "00000000",
          "10010000",
          "00101010",
          "11000010",
          "01001011",
          "00001011",
          "01101101",
          "00111001",
          "00000000",
          "00110000",
          "00000000",
          "00000011",
          "11000000",
          "00000000",
          "00000000",
          "00000000",]

print "EVENT 1:"
for line in event1:
    binary_to_dec(line)
print ""

event2 = ["00000001",
          "11000000",
          "01000000",
          "01000000",
          "01101000",
          "00000000",
          "00000000",]

print "EVENT 2:"
for line in event2:
    binary_to_dec(line)
print ""

event3 = ["00000001",
          "11000000",
          "11000000",
          "00100000",
          "00000000",
          "11001000",
          "01000000",
          "00000000",]

print "EVENT 3:"
for line in event3:
    binary_to_dec(line)
print ""



payload = ["01111111",
           "11111111",
           "10000000",
           "01000000",
           "11000000",
           "00100000",
           "10100000",
           "01100000",
           "11100000",
           "00010000",
           "10010000",
           "01010000",
           "11010000",
           "00110000",
           "10110000",]

print "payload"
for line in payload:
    binary_to_dec(line)
print ""

