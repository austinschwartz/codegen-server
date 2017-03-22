import socket
import sys
import json
import pickle

HOST, PORT = "localhost", int(sys.argv[1])
data = " ".join(sys.argv[1:])

with socket.socket(socket.AF_INET, socket.SOCK_STREAM) as sock:
    sock.connect((HOST, PORT))
    sock.sendall(bytes(data + "\n", "utf-8"))

    received = pickle.loads(sock.recv(1024))
    print(received)


print("Sent:     {}".format(data))
print("Received: {}".format(received))
