import socket
import math
import numpy as np

def netcat(hostname, port, content):
    s = socket.socket(socket.AF_INET, socket.SOCK_STREAM)
    s.connect((hostname, port))
    while 1:
        data = b""
        while 1:
            edata = s.recv(1024)
            data += edata
            if len(edata) != 1024:
                break
        
        n = 0
        a = 0
        c = 0
        data = data.decode()
        print(data)
        print()
        for line in data.split("\n"):
            lineS = line.split(" =  ")
            if lineS[0] == 'n':
                n = int(lineS[1])
            if lineS[0] == 'a':
                a = int(lineS[1])
            if lineS[0] == 'c':
                c = int(lineS[1])
        
        ch = str(check(c))
        print(ch)
        print("Press enter")
        s.sendall(bytes(ch + "\n", "UTF-8"))
        
        input()
    print("Connection closed.")
    s.close()

def check(n):
    if n % 6 != 0:
        return 0
    
    n = n // 6
    
    # perfect square
    if (math.isqrt(n) ** 2) == n:
        return 1
    return 0

if __name__ == "__main__":
    netcat("lac.tf", 31190, b"")
