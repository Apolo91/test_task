## Тестовое задание

    1. Python, Docker
    Создать git проект, в котором должно быть 2 docker контейнера:
    • скрипт python;
    • БД (postgreSQL).
    Алгоритм взаимодействия.
    Скрипт каждую минуту отправляет данные в БД cо сгенерированными данными.
    Пример данных:
    • "id": id записи (инкремент);
    • "data": сгенерированная строка данных;
    • "date": текущая дата и время.
    Скрипт логирует свои действия.
    При достижении в таблице БД 30 строк, таблица должна очищаться и вновь пришедшие данные должны быть записаны 1й строчкой. (Можно реализовать на уровне БДk или на уровне скрипта)
    Проект разворачивается с помощью docker compose.

    2. PL/SQL
    Структура данных.
    • Таблица серверов: servers, состоит из полей (srv_id, srv_name).
    • Таблица накопителей серверов: server_hdd, состоит из полей (hdd_id (integer), srv_id (integer), hdd_name, hdd_capacity (Общая емкость диска - number)).
    • Таблица использования накопителей серверов hdd_monitoring (hdd_id,  used_space (занятая емкость - number), formatted_space (Форматированная емкость - number), monitoring_date (date)).
    Накопителей может быть больше одного.
    • Таблицы (servers и server_hdd) связаны посредством foreign_key по полю srv_id.
    • Таблицы (server_hdd и hdd_monitoring) связаны посредством foreign_key по полю hdd_id.
    Задания.
    a. Вывести серверы, суммарная емкость накопителей которых больше 110 ТБ и менее 130 ТБ. Без использования подзапросов.
    b. Вследствие ошибки в таблице server_hdd появились дубли строк.
    Предложите вариант удаления дубликатов, оставив только уникальные строки.
    c. Какими средствами СУБД Oracle Вы в дальнейшем предотвратили бы появления дубликатов строк?
    d. Вывести изменение занятой емкости на самых больших дисках каждого сервера в формате:
    Имя сервера, Имя диска, Общая емкость диска, Предыдущая занятая емкость, Текущая занятая емкость диска, Дата мониторинга.
    Не более 10 строк на каждый диск.

1. Python, Docker

В ходе реализации было создано два docker контенера app и db.  
Конфигурация контейнеров описана в Dockerfile.   
В скрипте app.py реализована логика подключения к БД, а также отправка данных в БД каждую минуту,  
плюс логирование действий (создается файл app.log внутри контейнера app).  
В скрипте create_db.sql находятся запросы на создание таблиц для первого и второго задания, а также функция и триггер по очистке таблицы test_table в случае достижения объема 30 строк.   

Для запуска приложения необходимо склонировать репозиторий командой 

```bash
git clone https://github.com/Apolo91/test_task.git
```
Затем перейти в корневую дирректорию проекта и запустить команду  для сборки и запуска проекта

```bash 
docker-compose up .build
```

2. PL/SQL 

В файле create_db.sql описаны команды для создания структуры таблиц servers, server_hdd, hdd_monitoring
Запуск скрипта создания схемы запускаеся в процессе сборки проекта и описан в Dockerfile контейнера db в строчке
```dockerfile
COPY create_db.sql /docker-entrypoint-initdb.d/create_db.sql
```


Задания:

Вывести серверы, суммарная емкость накопителей которых больше 110 ТБ и менее 130 ТБ. Без использования подзапросов.

```sql
select s.srv_name,sum(sh.hdd_capacity) from servers s 
join server_hdd sh on s.srv_id = sh.srv_id
group by s.srv_name
having sum(sh.hdd_capacity) > 110 and sum(sh.hdd_capacity) < 130 ;
```
Вследствие ошибки в таблице server_hdd появились дубли строк.
Предложите вариант удаления дубликатов, оставив только уникальные строки.

```sql
delete from server_hdd hdd_a where rowid > (select min(rowid) from server_hdd hdd_b where hdd_b.name=hdd_a.name);
```
Какими средствами СУБД Oracle Вы в дальнейшем предотвратили бы появления дубликатов строк?

Использовать для таблицы с server_hdd Primary_key для поля hdd_id при вставке дублирующей строки произойдет ошибка 

```sql
duplicate key value violates unique constraint "server_hdd_pkey"
```

Вывести изменение занятой емкости на самых больших дисках каждого сервера в формате:
Имя сервера, Имя диска, Общая емкость диска, Предыдущая занятая емкость, Текущая занятая емкость диска, Дата мониторинга.
Не более 10 строк на каждый диск.

```sql
select s.srv_name,sh.hdd_name,sh.hdd_capacity,
lag(hm.used_space) over (partition by hm.hdd_id rows between 10 PRECEDING and CURRENT ROW) as previos_used_space,
hm.used_space,
hm.monitoring_date
from server_hdd sh join servers s on sh.srv_id = s.srv_id 
right join hdd_monitoring hm on hm.hdd_id = sh.hdd_id 
where sh.hdd_capacity in (select max(sh.hdd_capacity) as max_capacity  from server_hdd sh group by sh.srv_id)
order by s.srv_name ,hm.monitoring_date 
```