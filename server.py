import socketserver
import redis
import json
import sys
import pickle

r = redis.StrictRedis(host='localhost', port=6379, db=0)
#d = {'schwar12': 12731}
#r.set('lab5map', pickle.dumps(d))
#print(pickle.loads(r.get('lab5map')))

class Handler(socketserver.BaseRequestHandler):
    def handle(self):
        self.data = self.request.recv(1024).strip()
        print(self.data)
        scores = r.get('lab5map')
        print(pickle.loads(scores))
        self.request.sendall(scores)


if __name__ == "__main__":
    HOST, PORT = "localhost", int(sys.argv[1])
    server = socketserver.TCPServer((HOST, PORT), Handler)
    server.serve_forever()
