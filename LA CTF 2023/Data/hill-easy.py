import socket
from time import sleep
import numpy as np

values = [
	"!                   ",
	" !                  ",
	"  !                 ",
	"   !                ",
	"    !               ",
	"     !              ",
	"      !             ",
	"       !            ",
	"        !           ",
	"         !          ",
    "          !         ",
    "           !        ",
    "            !       ",
    "             !      ",
    "              !     ",
    "               !    ",
    "                !   ",
    "                 !  ",
    "                  ! ",
    "                   !"
]

def stov(s):
    return np.array([ord(c)-32 for c in s])

def vtos(v):
    return ''.join([chr(v[i]+32) for i in range(20)])

def encrypt(A, s):
    return vtos(np.matmul(A, stov(s))%95)

def netcat(hostname, port, content):
	s = socket.socket(socket.AF_INET, socket.SOCK_STREAM)
	s.connect((hostname, port))
	sleep(0.5)

	lines = nc_read(s).split("\n")
	f1 = lines[1]
	f2 = lines[2]

	A = np.array([[0] * 20 for x in range(20)])
	for i in range(10):
		data = values[i] + values[10 + i]

		nc_send(s, data)
		sleep(0.5)
		lines = nc_read(s).split("\n")
		o1 = lines[1]
		o2 = lines[2]
		A[:, i] = stov(o1)
		A[:, 10 + i] = stov(o2)

	for i in range(10):
		print(i, 1, encrypt(A, values[i]))
		print(i, 2, encrypt(A, values[10 + i]))

	print(A)

	# fakeflag2 = nc_read(s).split("\n")[4]
	fakeflag2 = lines[7]
	print(fakeflag2)

	n = 20
	f3 = encrypt(A, fakeflag2[:n])
	f4 = encrypt(A, fakeflag2[n:])

	print(f3)
	print(f4)

	nc_send(s, f3)

	nc_read(s)

	nc_send(s, f4)

	nc_read(s)

	print("Connection closed.")
	s.close()

def nc_read(s):
	data = b""
	while True:
		edata = s.recv(1024)
		data += edata
		if len(edata) != 1024:
			break

	decoded = data.decode()
	[print("<< " + l) for l in decoded.split("\n")]

	return decoded

def nc_send(s, value):
	[print(">> " + l) for l in value.split("\n")]

	s.sendall(bytes(value + "\n", "UTF-8"))

if __name__ == "__main__":
	netcat("lac.tf", 31140, b"")
