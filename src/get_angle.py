import math
precision = 28
for i in range(0, precision):
    angle = math.atan(2**(-i))
    shift = int(angle * 2**precision)
    # print(shift)
    s = bin(shift)[2:]
    # print(s)
    print('b' + '0' * (precision - len(s)) + s)