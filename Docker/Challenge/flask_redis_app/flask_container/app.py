from flask import Flask, render_template
import redis
import os
import socket

app = Flask(__name__)


# Connect to Redis
redis_host = os.getenv("REDIS_HOST", "redis")
redis_port = int(os.getenv("REDIS_PORT", 6379))

r = redis.Redis(
    host=redis_host,
    port=redis_port,
    decode_responses=True
)


@app.route("/")
def welcome():
    return render_template("index.html")


@app.route("/count")
def display_count():

    # Identify the Flask container handling this request
    container_name = socket.gethostname()[:4]
    container_key = f"web-container-{container_name}"

    # Increase this container's visit count
    # If the key does not exist, Redis creates it with the value 1
    current_container_visits = r.incr(container_key)

    # Collect the visit count for every Flask container
    container_counts = {}

    for key in r.scan_iter(match="web-container-*"):
        container_counts[key] = int(r.get(key))

    # Add together visits from every container
    total_visits = sum(container_counts.values())

    return render_template(
        "count.html",
        current_container=container_key,
        current_container_visits=current_container_visits,
        container_counts=container_counts,
        total_visits=total_visits
    )


if __name__ == "__main__":
    app.run(host="0.0.0.0", port=5004)