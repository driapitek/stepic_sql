use store_simple;

select * from store;

select category, count(1) from store
group by category
order by category;

use project_simple;
select * from project;

-- Выведите общее количество заказов компании.
select count(1) from project;


-- Выведите количество товаров в каждой категории. Результат должен содержать два столбца
-- название категории, 
-- количество товаров в данной категории.

select * from store;

select category, count(1) from store
group by category
order by category;

-- Выведите 5 категорий товаров, продажи которых принесли наибольшую выручку. 
-- Под выручкой понимается сумма произведений стоимости товара на количество проданных единиц. Результат должен содержать два столбца: 
-- название категории,
-- выручка от продажи товаров в данной категории.

select category,
sum(price * sold_num) as sale
from store
group by category
order by sale desc
limit 5;

-- Выведите в качестве результата одного запроса общее количество заказов, сумму стоимостей (бюджетов) всех проектов, 
-- средний срок исполнения заказа в днях.

select 
 count(1) as 'count of order',
 sum(budget) as 'total budget',
 avg(datediff(project_finish, project_start))
 from project;
