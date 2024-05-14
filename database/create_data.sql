INSERT INTO servers (srv_id, srv_name) VALUES
(1,'vlg-zmon-prx01'),
(2,'vlg-zmon-prx02'),
(3,'kvk-zmon-prx01'),
(4,'kvk-zmon-prx02'),
(5,'dv-zmon-prx01'),
(6,'dv-zmon-prx02'),
(7,'msk-zmon-prx01'),
(8,'msk-zmon-prx02'),
(9,'sib-zmon-prx01')
(10,'sib-zmon-prx02');

INSERT INTO public.server_hdd (hdd_id,srv_id,hdd_name,hdd_capacity) VALUES
	 (2,1,'sdb',100),
	 (3,2,'sda',110),
	 (4,2,'sdb',10),
	 (5,3,'sda',110),
	 (6,3,'sdb',10),
	 (7,4,'sda',110),
	 (8,4,'sdb',10),
	 (9,4,'sdc',5),
	 (10,5,'sda',110),
	 (11,5,'sdb',10),
	 (12,5,'sdc',5),
	 (13,6,'sda',110),
	 (14,7,'sda',150),
	 (15,8,'sda',150),
	 (16,9,'sda',140),
	 (17,10,'sda',150),
	 (18,10,'sdb',150),
	 (1,1,'sda',30);


INSERT INTO public.hdd_monitoring (hdd_id,used_space,formatted_space,monitoring_date) VALUES
	 (1,10,10,'2024-05-14 08:23:14.000'),
	 (1,15,5,'2024-05-14 08:30:14.000'),
	 (2,50,50,'2024-05-14 08:23:14.000'),
	 (2,60,40,'2024-05-15 08:25:14.000'),
	 (2,70,30,'2024-05-16 09:23:14.000'),
	 (3,100,10,'2024-05-10 08:23:14.000'),
	 (3,110,0,'2024-05-11 08:00:00.000'),
	 (4,9,1,'2024-05-04 08:10:00.000'),
	 (4,1,9,'2024-05-14 08:23:14.000'),
	 (5,10,100,'2024-05-09 18:23:14.000');
INSERT INTO public.hdd_monitoring (hdd_id,used_space,formatted_space,monitoring_date) VALUES
	 (5,20,90,'2024-05-10 18:23:14.000'),
	 (5,5,105,'2024-05-11 18:23:14.000'),
	 (5,10,100,'2024-05-12 18:23:14.000'),
	 (5,10,100,'2024-05-13 18:23:14.000');






















