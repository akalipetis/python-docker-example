import sec
from flask import Flask
from redis.utils import from_url

app = Flask(__name__)
redis_client = from_url(sec.load("REDIS_URL"))


@app.route("/")
def hello_world():
    times = redis_client.incr("visits")
    return f"Hello, World! You have visited {times} times."
