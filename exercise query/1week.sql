use project_simple;

-- --------------
-- агрегация данных
-- посчитаем среднюю длительность проекта
-- а так же макисмум и минимум

select * from project;

select 
avg(datediff(project_finish, project_start)),
max(datediff(project_finish, project_start)),
min(datediff(project_finish, project_start))
from project where project_start < project_finish;

-- группировка данных
select 
avg(datediff(project_finish, project_start)),
max(datediff(project_finish, project_start)),
min(datediff(project_finish, project_start))
from project where project_start < project_finish
group by client_name;

-- чтобы выводился группирант, его необходимо добавить в запрос вывода
select 
avg(datediff(project_finish, project_start)),
max(datediff(project_finish, project_start)),
min(datediff(project_finish, project_start)),
client_name
from project where project_start < project_finish
group by client_name;

-- видно, что с агрегированными данными без имён сложно работать, поэтому задаём им имя
-- при помощи оператора as
-- тут же сортируем данные

select 
avg(datediff(project_finish, project_start)) as avg_days,
max(datediff(project_finish, project_start)) as max_days,
min(datediff(project_finish, project_start)) as min_days,
client_name
from project where project_start < project_finish
group by client_name
order by max_days;

-- чтобы сортировать в обратном порядке
select 
avg(datediff(project_finish, project_start)) as avg_days,
max(datediff(project_finish, project_start)) as max_days,
min(datediff(project_finish, project_start)) as min_days,
client_name
from project where project_start < project_finish
group by client_name
order by max_days desc;

-- выведем первые несколько
select 
avg(datediff(project_finish, project_start)) as avg_days,
max(datediff(project_finish, project_start)) as max_days,
min(datediff(project_finish, project_start)) as min_days,
client_name
from project where project_start < project_finish
group by client_name
order by max_days desc
limit 5;

-- Если выводить агрегированные данные без группировки, то это будет неправильно
-- вместо корректного значения, подставится первое из поля (колонки), однако в некоторых языках 
-- или рабочих областях уже стоит защита от этого (как например у меня). Следующий запрос выдаст ошибку

-- select 
-- count(1),
-- avg(budget),
-- client_name
-- from project;

-- a вот так будет правильно

select 
count(1),
avg(budget),
client_name
from project
group by client_name;