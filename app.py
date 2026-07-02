from flask import Flask
import logging

logging.basicConfig(level=logging.INFO)

app = Flask(__name__)

@app.route("/")
def home():
    logging.info("Home endpoint called, great")
    return "Hello from Flask app"

if __name__ == "__main__":
    app.run(host="0.0.0.0", port=5000)
