bytes = [0x0e, 0xC9, 0x9D, 0xB8, 0x26, 0x83, 0x26, 0x41, 0x74, 0xE9, 0x26, 0xA5, 0x83, 0x94, 0xE, 0x63, 0x37, 0x37, 0x37]

def findbyte(b):
    for o in range(0, 256):
        if ((17 * o) % 0xFD) == b:
            return o
    raise ValueError

for i in range(len(bytes)):
    v = findbyte(bytes[i])
    print(chr(v))