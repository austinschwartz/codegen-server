import socketserver
import redis
import json
import sys
import pickle

r = redis.StrictRedis(host='localhost', port=6379, db=0)
d = {'schwar12': 12731, 'hays1': 11039, 'fieldn': 11000}
r.set('lab5map', json.dumps(d))
g = r.get('lab5map')
print(g)
unpacked = json.loads(g.decode('utf-8'))

class Handler(socketserver.StreamRequestHandler):
    def handle(self):
        self.data = self.rfile.readline().strip()
        print("{} sent:".format(self.client_address[0]))
        print(self.data)
        scores = r.get('lab5map')
        print("Scores now: " + str(json.loads(scores)))
        self.request.sendall(bytes(scores))

if __name__ == "__main__":
    HOST, PORT = "localhost", int(sys.argv[1])
    server = socketserver.TCPServer((HOST, PORT), Handler)
    server.serve_forever()
