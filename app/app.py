
import psycopg2
import time 
import string
import random
import logging

logging.basicConfig(filename='app.log', level=logging.INFO,filemode="w",format="%(asctime)s %(levelname)s %(message)s")

connection = psycopg2.connect(database="database", user="username", password="secret", host="db", port=5432)
cursor = connection.cursor()
cursor.execute("SET TIME ZONE 'Europe/Moscow';")
logging.info('Application Started')
while True:
       # cursor = connection.cursor()
       res = str(''.join(random.choices(string.ascii_uppercase + string.digits, k=10)))
       cursor.execute(f"INSERT INTO test_table (data, date) VALUES('{res}',NOW());")
       connection.commit()
       cursor.execute("SELECT id,data,date from test_table order by date desc limit 1;")
       data = cursor.fetchall()
       if data == [] :
              logging.info(f"table data cleared")
       else:
             logging.info(f"data is recorded: {data}")        
       connection.commit()
       time.sleep(5)


   