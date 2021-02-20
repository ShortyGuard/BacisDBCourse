-- Проанализировать несколько запросов с помощью EXPLAIN(есть графический вариант, есть вариант консольный). 
-- Можно проверить раннее используемые запросы. Добавить в запросы where по ограничению неуволенных работников или отделов, оценить как измениться ЦЕНА запроса. 
-- Запрос можно улучшить с помощью индекса. Но это надо делать с "умеренным" аппетитом.
use employees;


-- Найти количество сотрудников в отделах и посмотреть, сколько всего денег получает отдел. 
-- Запрос выполняется около 8 сек
explain select de.dept_name, count(*) employees_count, sum(s.salary) department_salary from employees em
left join dept_emp deem using(emp_no)
left join departments de using (dept_no)
left join salaries s using(emp_no)
where deem.from_date < sysdate() and deem.to_date >= sysdate()
and s.from_date < sysdate() and s.to_date >= sysdate()
group by de.dept_name;

-- результат видми, что есть full_scan по dept_emp
/*
1	SIMPLE	deem		ALL	PRIMARY,emp_no				331143	11.11	Using where; Using temporary
1	SIMPLE	em		eq_ref	PRIMARY	PRIMARY	4	employees.deem.emp_no	1	100.00	Using index
1	SIMPLE	de		eq_ref	PRIMARY,dept_name	PRIMARY	16	employees.deem.dept_no	1	100.00	
1	SIMPLE	s		ref	PRIMARY,emp_no	PRIMARY	4	employees.deem.emp_no	9	11.11	Using where
*/

-- немного изменим условие (стало выполняться 4 сек)
explain select de.dept_name, count(*) employees_count, sum(s.salary) department_salary from employees em
left join dept_emp deem using(emp_no)
left join departments de using (dept_no)
left join salaries s using(emp_no)
where deem.to_date = '9999-01-01'
and s.to_date = '9999-01-01'
group by de.dept_name;

-- результат почти такой же (но выиграли на фильтарции немного)
/*
1	SIMPLE	deem		ALL	PRIMARY,emp_no				331143	10.00	Using where; Using temporary
1	SIMPLE	s		ref	PRIMARY,emp_no	PRIMARY	4	employees.deem.emp_no	9	10.00	Using where
1	SIMPLE	em		eq_ref	PRIMARY	PRIMARY	4	employees.deem.emp_no	1	100.00	Using index
1	SIMPLE	de		eq_ref	PRIMARY,dept_name	PRIMARY	16	employees.deem.dept_no	1	100.00	
*/

-- попрубуем добавить индекс на dept_emp.to_date
ALTER TABLE `employees`.`dept_emp` 
ADD INDEX `dept_emp_idx_to_date` (`to_date` ASC) VISIBLE;
;

-- запрос стал выполняться 3 сек
explain select de.dept_name, count(*) employees_count, sum(s.salary) department_salary from employees em
left join dept_emp deem using(emp_no)
left join departments de using (dept_no)
left join salaries s using(emp_no)
where deem.to_date = '9999-01-01'
and s.to_date = '9999-01-01'
group by de.dept_name;

-- результат видим что от full_scan по dept_emp издавились и используется наш индекс
/*
1	SIMPLE	deem		ref	PRIMARY,emp_no,dept_emp_idx_to_date	dept_emp_idx_to_date	3	const	165571	100.00	Using where; Using index; Using temporary
1	SIMPLE	s		ref	PRIMARY,emp_no	PRIMARY	4	employees.deem.emp_no	9	10.00	Using where
1	SIMPLE	de		eq_ref	PRIMARY,dept_name	PRIMARY	16	employees.deem.dept_no	1	100.00	
1	SIMPLE	em		eq_ref	PRIMARY	PRIMARY	4	employees.deem.emp_no	1	100.00	Using index
*/
