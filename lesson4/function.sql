-- Создать функцию, которая найдет табельный номер менеджера
-- (у нас есть таблица менеджеров - dept_manager) по имени( или части) и фамилии(или части) или выдаст "0"- если его нет такого. (limit 1)
use employees;

DROP function IF EXISTS get_manager_num;

delimiter //

create function get_manager_num (first_name VARCHAR(16), last_name VARCHAR(16)) 
RETURNS INT
BEGIN
	DECLARE result INT;
    
	SET result = 0;

	-- можно через CONCAT добавлять к параметрам функции %, но предполагаем что параметры будут переданы в нужном формате для like
	select dm.emp_no into result from dept_manager dm
    inner join employees em on dm.emp_no = em.emp_no
    where em.first_name like first_name and em.last_name like last_name
    limit 1;
    
    RETURN result;
END//

delimiter ;