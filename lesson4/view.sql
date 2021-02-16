-- Создать VIEW на основе запросов, которые вы сделали в ДЗ к уроку 3(create or replace view ...).
-- как пример достаточно создать одно view на основе запроса из ДЗ урока 3
use employees;

CREATE OR REPLACE VIEW avg_salary AS
    SELECT 
        de.dept_name, ROUND(AVG(s.salary), 2) avarage_salary
    FROM
        employees em
            LEFT JOIN
        dept_emp deem USING (emp_no)
            LEFT JOIN
        departments de USING (dept_no)
            LEFT JOIN
        salaries s USING (emp_no)
    WHERE
        deem.from_date < SYSDATE()
            AND deem.to_date >= SYSDATE()
            AND s.from_date < SYSDATE()
            AND s.to_date >= SYSDATE()
    GROUP BY de.dept_name;