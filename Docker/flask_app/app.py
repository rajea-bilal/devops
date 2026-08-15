from flask import Flask
import MySQLdb 

app = Flask(__name__)

@app.route('/')
def hello_world():
    # connect to MYSQL server
    conn = MySQLdb.connect(
    host="mysql-server", # hostname of the MYSQL container
    user="root", # credentials to access the MYSQL server
    passwd="mysecret-pw", # password to access the MYSQL server
    db="mysql" # database inside the MYSQL server
    )
    cursor = conn.cursor()
    cursor.execute("SELECT VERSION()") # execute a query to get the version of the MYSQL server
    version=cursor.fetchone() # fetch the result of the query
    
    return f'Hey Rajea, live from the Flask app! MYSQL server version: {version[0]}'

if  __name__ == '__main__':
    app.run(host='0.0.0.0', port=5001)

