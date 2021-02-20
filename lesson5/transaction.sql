-- Подумать, какие операции являются транзакционными, и написать несколько примеров с транзакционными запросами. 
-- Предлагаю уволить человека из базы по табельному номеру. (у каждого есть должность в таблице titles - указать дату до какой он её занимает, 
-- каждый работает в каком то отделе - таблица dept_emp, и выплаты по каждому работнику лежат в таблице salaries - там тоже есть дата по какой мы понимаем до какой даты человек работал. 
-- Основная таблица employees - так и хранит данные о сотруднике)
use employees;

DROP procedure IF EXISTS dismiss_employee;

delimiter //

create procedure dismiss_employee (emp_no_to_dismiss int) 
BEGIN
	DECLARE EXIT HANDLER FOR SQLEXCEPTION
	BEGIN
		ROLLBACK; -- Вот здесь откатываем транзакцию в случае ошибки
	END;
  
	START TRANSACTION;

		update titles t set t.to_date = curdate()
 			where t.emp_no=emp_no_to_dismiss
				and t.from_date <= curdate() and t.to_date >= curdate();

		update dept_emp de set de.to_date = curdate()
			where de.emp_no=emp_no_to_dismiss
				and de.from_date <= curdate() and de.to_date >= curdate();

		update salaries s set  s.to_date = curdate()
			where s.emp_no=emp_no_to_dismiss
				and s.from_date <= curdate() and s.to_date >= curdate();
     COMMIT; -- тут фиксируем все изменения
END//

delimiter ;