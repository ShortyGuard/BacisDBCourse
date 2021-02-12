-- База данных «Сотрудники»(бд employees сотрудники не уволенные это те, которые в таблице dept_emp.to_date='9999-01-01'):
-- ПРИМЕЧАНИЕ: актуальные запипси я определял как "from_date < sysdate() and to_date >= sysdate()"  (просто для разнообразия)
use employees;
-- Выбрать среднюю зарплату по отделам. (Применить группировку для связи отдела, подсчитываем среднюю зарплату по неуволенным сотрудникам, 
-- не забываем применять функции для округления format(), round()).
select de.dept_name, round(avg(s.salary), 2) avarage_salary from employees em
left join dept_emp deem using(emp_no)
left join departments de using (dept_no)
left join salaries s using(emp_no)
where deem.from_date < sysdate() and deem.to_date >= sysdate()
and s.from_date < sysdate() and s.to_date >= sysdate()
group by de.dept_name;

-- Выбрать максимальную зарплату у сотрудника. (сотрудник не должне быть уволен, так же применяется агрегатная функция group by).
select em.emp_no, concat(em.first_name, ' ', em.last_name) full_name, max(s.salary) max_salary from employees em
left join dept_emp deem using(emp_no)
left join salaries s using(emp_no)
where deem.from_date < sysdate() and deem.to_date >= sysdate() 
group by em.emp_no;

-- Удалить одного сотрудника, у которого максимальная зарплата.
-- (Применение подзапросов обязательно, сотрудник должен быть не уволенным, и удалить мы должны одного сотрудника).
delete from employees
where emp_no = (select emp_no from (
	select em.emp_no, s.salary salary from employees em
	left join dept_emp deem using(emp_no)
	left join salaries s using(emp_no)
	where deem.from_date < sysdate() and deem.to_date >= sysdate()
	and s.from_date < sysdate() and s.to_date >= sysdate()
	group by em.emp_no, salary 
	order by salary desc
	limit 1) max_salary_employees);

-- Посчитать количество сотрудников во всех отделах. (Мы подсчитываем количество не уволенных сотрудников)
select de.dept_name, count(*) employees_count from employees em
left join dept_emp deem using(emp_no)
left join departments de using (dept_no)
where deem.from_date < sysdate() and deem.to_date >= sysdate()
group by de.dept_name;


-- Найти количество сотрудников в отделах и посмотреть, сколько всего денег получает отдел. 
-- (По не уволенным сотрудникам мы проводим статистику, и применяем функции для группировки данных. 
-- И берём за основу суммы выплат последнего периода salaries.to_date='9999-01-01'. 
-- Так как в salaries - лежат данные выплат по годам для сотрудника)
select de.dept_name, count(*) employees_count, sum(s.salary) department_salary from employees em
left join dept_emp deem using(emp_no)
left join departments de using (dept_no)
left join salaries s using(emp_no)
where deem.from_date < sysdate() and deem.to_date >= sysdate()
and s.from_date < sysdate() and s.to_date >= sysdate()
group by de.dept_name;