from flask import Flask, render_template
import psycopg2
import os

app = Flask(__name__)


USERNAME = os.environ.get("DB_USERNAME")
PASSWORD = os.environ.get("DB_PASSWORD")
HOSTNAME = os.environ.get("DB_HOSTNAME")
DB_NAME = os.environ.get("DN_NAME")

connection_string = f"postgresql://{USERNAME}:{PASSWORD}@{HOSTNAME}:5432/{DB_NAME}"

@app.route('/')
def index():
    try:
        conn = psycopg2.connect(connection_string)
        message = "Connection to PostgreSQL successful!"
        conn.close()
    except psycopg2.Error as e:
        message = f"Error connecting to PostgreSQL: {e}"
    
    return render_template('index.html', message=message)

if __name__ == "__main__":
    app.run(debug=True)