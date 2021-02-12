-- База данных «Страны и города мира»:
use geodata;
-- Сделать запрос, в котором мы выберем все данные о городе – регион, страна.
select c.title city_name, r.title region_name, co.title country_name from _cities c
left join _regions r on c.region_id = r.id
left join _countries co on c.country_id = co.id;

-- Выбрать все города из Московской области.
select c.title city_name, r.title region_name, co.title country_name from _cities c
left join _regions r on c.region_id = r.id
left join _countries co on c.country_id = co.id
where r.id = 1053480 -- 1053480 - это идентификатор Московской области
order by city_name;