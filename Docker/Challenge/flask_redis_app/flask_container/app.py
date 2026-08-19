from flask import Flask
import redis
import os # os is a built-in Python module, using it so Python can read the env var.

app = Flask(__name__)

# connect to redis server

redis_host = os.getenv("REDIS_HOST", "redis") # look for env var called "REDIS_HOST"
redis_port = int(os.getenv("REDIS_PORT", 6379)) # look for env var called "REDIS_PORT"

r = redis.Redis(host=redis_host, port=redis_port) # connect with Redis using this hostname and port.

@app.route('/')
def welcome():
 return f"Hey User, welcome to a Flask app conntected to a Redis database!"

@app.route("/count")
def display_count():
    count = r.get("count")

    if not count:
        r.set("count", 1)
        return f'The current count is 1'
    else :
        count = int(count)
        r.set("count", count + 1)
        return f'The current count is {int(r.get("count"))}'
    
    
    
    
if  __name__ == '__main__':
    app.run(host='0.0.0.0', port=5004)

# allow connections coming into the container, rather than only accepting connections from inside itself.
