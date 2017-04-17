#!/usr/bin/env python3

import socketserver
import redis
import json
import sys
import pickle

r = redis.StrictRedis(host='localhost', port=6379, db=0)
#d = {}
#r.set('lab6map', json.dumps(d))
#g = r.hm('lab6map')
#print(g)
#unpacked = json.loads(g.decode('utf-8'))

class Handler(socketserver.StreamRequestHandler):
    def handle(self):
        self.data = self.rfile.readline().strip()
        print("{} sent:".format(self.client_address[0]))
        string = self.data.decode('utf-8')
        js = json.loads(string)
        #js is a dict
        token = next(iter(js.keys()))
        scores = js[token]
        if r.hexists('lab6map', token):
            cur = json.loads(r.hget('lab6map', token).decode('utf-8'))
            print("token", js[token], cur)
            for x in ["1", "2", "3", "4"]:
                if x not in cur and x not in js[token]:
                    js[token][x] = "-1"
            for x in ["1", "2", "3", "4"]:
                if x not in js[token]:
                    js[token][x] = cur[x]
            print("token", js[token])
        else:
            for x in ["1", "2", "3", "4"]:
                if x not in js[token]:
                    js[token][x] = "-1"
        st = json.dumps(js[token])
        print(st)
        r.hmset('lab6map', {token: st})

        cur = r.hgetall('lab6map')
        print("Scores now: " + str(cur))
        #self.request.sendall(bytes(scores))

if __name__ == "__main__":
    if len(sys.argv) == 1:
        port = 5858
    else:
        port = int(sys.argv[1])
    HOST, PORT = "0.0.0.0", port
    server = socketserver.TCPServer((HOST, PORT), Handler)
    server.serve_forever()
