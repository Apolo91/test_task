
import psycopg2
import time 
import string
import random
import logging
from datetime import datetime
from pytz import timezone


# Настройка конфига лог файла для UTC+3
time_format = "%Y-%m-%d %H:%M:%S"

def timetz(*args):
    return datetime.now(tz).timetuple()
tz = timezone('Europe/Moscow') # UTC, Asia/Shanghai, Europe/Berlin
logging.Formatter.converter = timetz
logging.basicConfig(filename='app.log',
                     level=logging.INFO,
                     filemode="w",
                     format="%(asctime)s %(levelname)s %(message)s",
                     datefmt=time_format)

# Подключение к базе данных
connection = psycopg2.connect(database="database",
                               user="username",
                                 password="secret",
                                   host="db",
                                     port=5432)
cursor = connection.cursor()
cursor.execute("SET TIME ZONE 'Europe/Moscow';")

logging.info('Application Started')

while True:
       data_string = str(''.join(random.choices(string.ascii_uppercase + string.digits, k=10)))
       cursor.execute(f"INSERT INTO test_table (data, date) VALUES('{data_string}',NOW());")
       connection.commit()
       cursor.execute("SELECT id,data,date from test_table order by date desc limit 1;")
       data = cursor.fetchall()
       if data == [] :
              logging.info(f"table data cleared")
       else:
             logging.info(f"data is recorded  (ID: {data[0][0]}, DATA: {data[0][1]}, DATE: {data[0][2]})")        
       connection.commit()
       time.sleep(1)