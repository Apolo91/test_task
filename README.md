# test_task


Вывести серверы, суммарная емкость накопителей которых больше 110 ТБ и менее 130 ТБ. Без использования подзапросов.

select s.srv_name,sum(sh.hdd_capacity) from servers s 
join server_hdd sh on s.srv_id = sh.srv_id
group by s.srv_name
having sum(sh.hdd_capacity) > 110 and sum(sh.hdd_capacity) < 130 ;

Вследствие ошибки в таблице server_hdd появились дубли строк.
Предложите вариант удаления дубликатов, оставив только уникальные строки.

delete from server_hdd hdd_a where rowid > (select min(rowid) from server_hdd hdd_b where hdd_b.name=hdd_a.name);

Какими средствами СУБД Oracle Вы в дальнейшем предотвратили бы появления дубликатов строк?

Использовать для таблицы с server_hdd Primary_key для поля hdd_id при вставке дублирующей строки произойдет ошибка 
duplicate key value violates unique constraint "server_hdd_pkey"

Вывести изменение занятой емкости на самых больших дисках каждого сервера в формате:
Имя сервера, Имя диска, Общая емкость диска, Предыдущая занятая емкость, Текущая занятая емкость диска, Дата мониторинга.
Не более 10 строк на каждый диск.


select s.srv_name,sh.hdd_name,sh.hdd_id, sh.hdd_capacity,
lag(hm.used_space) over (order by hm.hdd_id) as previos_used_space,
last_value(hm.used_space) over (order by hm.hdd_id) as last_used_space,
last_value (hm.monitoring_date) over (order by hm.hdd_id) as monitoring_date
from server_hdd sh join servers s on sh.srv_id = s.srv_id 
right join hdd_monitoring hm on hm.hdd_id = sh.hdd_id 
where sh.hdd_capacity in (select max(sh.hdd_capacity) as max_capacity  from server_hdd sh group by sh.srv_id)  
order by s.srv_name ,hm.monitoring_date 










