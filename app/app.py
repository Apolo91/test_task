
import psycopg2
import time 
import string
import random

connection = psycopg2.connect(database="database", user="username", password="secret", host="db", port=5432)
cursor = connection.cursor()

print('Application started')
while True:
       res = str(''.join(random.choices(string.ascii_uppercase + string.digits, k=7)))
       cursor.execute(f"INSERT INTO test_table (data, date) VALUES('{res}',NOW());")
       cursor.execute("SELECT id,data from test_table order by id;")
       data = cursor.fetchall()
       print(data)
       time.sleep(1)


   