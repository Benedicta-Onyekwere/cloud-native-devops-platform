from flask import Flask, jsonify
import psycopg2
import os

app = Flask(__name__)

def get_database_connection():
    return psycopg2.connect(
        host=os.getenv("DB_HOST", "database"),
        database=os.getenv("DB_NAME", "auctiondb"),
        user=os.getenv("DB_USER", "auctionuser"),
        password=os.getenv("DB_PASSWORD", "auctionpassword")
    )

@app.route("/")
def home():
    return jsonify({
        "message": "Welcome to the Cloud Native Auction Platform"
    })

@app.route("/health")
def health():
    try:
        conn = get_database_connection()
        conn.close()

        return jsonify({
            "status": "healthy",
            "database": "connected"
        })

    except Exception as e:
        return jsonify({
            "status": "unhealthy",
            "error": str(e)
        }), 500


if __name__ == "__main__":
    app.run(host="0.0.0.0", port=5000)