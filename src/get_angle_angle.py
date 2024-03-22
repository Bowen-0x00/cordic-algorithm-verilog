import math

for i in range(0, 22):
    angle = math.atan(2**(-i)) * 180 / math.pi
    shift = int(angle * 2**16)
    # print(shift)
    s = bin(shift)[2:]
    # print(s)
    print('b' + '0' * ((16 + 6) - len(s)) + s)