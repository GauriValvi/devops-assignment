from flask import Flask
<<<<<<< HEAD
import logging

logging.basicConfig(level=logging.INFO)

app = Flask(__name__)

@app.route("/")
def home():
    logging.info("Home endpoint called!!!great")
    return "Hello from Flask app"

if __name__ == "__main__":
    app.run(host="0.0.0.0", port=5000)
=======

app = Flask(__name__)

@app.route('/')
def home():
    return {"message": "App running successfully"}

if __name__ == '__main__':
    app.run(host='0.0.0.0', port=5000)
>>>>>>> df7fa23 (changes)
