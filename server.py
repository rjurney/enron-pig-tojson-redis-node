from flask import Flask
import redis
import json

r = redis.StrictRedis(host='localhost', port=6379, db=0)

app = Flask(__name__)

@app.route("/message/<message_id>")
def topics(message_id):
  return r.get(message_id)

if __name__ == "__main__":
  app.run(debug=True)