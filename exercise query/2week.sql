use store_medium;

select * from category;
select * from product;

-- это простое объединение
select * from product, category;

-- аналогичную выборку получим в результате выполнения
select * from product cross join category;

-- наиболее часто используется inner join;
-- для нашей базы это будет вывод списка продуктов с наименованием категории для каждого продукта
select * from product inner join category on product.category_id = category.category_id;

-- особый вариант, когда мы не хотим чтобы столбцы дублировалисьalter
select product.product_name, category.category_name, product.price 
from product inner join category on product.category_id = category.category_id;

-- можно сократить вывод, если назвать вызываемые таблица попроще.alter
select p.product_name, c.category_name, p.price 
from product as p inner join category as c on p.category_id = c.category_id;


-- Выведите все позиций списка товаров принадлежащие какой-либо категории с названиями товаров и названиями категорий. Список должен быть отсортирован по названию товара, названию категории. Для соединения таблиц необходимо использовать оператор 

select g.name as good_name, c.name as category_name  from good as g 
	inner join category_has_good as chg 
		on g.id = chg.good_id
	inner join category as c
		on c.id= chg.category_id
order by good_name;

-- Выведите список клиентов (имя, фамилия) и количество заказов данных клиентов, имеющих статус "new".

use store;
select * from sale;
select * from status;
select * from client;

select client.first_name, client.last_name, count(1) as new_sale_num 
	from client
inner join sale on sale.client_id = client.id
inner join status on sale.status_id = status.id
where status.name='new'
group by client.first_name, client.last_name;

-- левое и правое соединение.

use store_medium;
select * from product;
select * from category;

-- таблица категории имеет candy в иннер джоин она не попадает
select p.product_name, c.category_name, p.price
	from product as p
inner join category as c on p.category_id = c.category_id;

-- теперь добавим отсутствующую запись при помощи левого иннер джоина

select * from category as c
left outer join product as p on p.category_id = c.category_id;

-- теперь поговорим об объединениях

select * from product where price > 900
union
select * from product where price < 900;

-- Выведите список товаров с названиями товаров и названиями категорий, в том числе товаров, не принадлежащих ни одной из категорий.
select g.name as good_name, c.name as category_name  from good as g 
	LEFT OUTER JOIN category_has_good as chg 
		on g.id = chg.good_id
	LEFT OUTER JOIN category as c
		on c.id= chg.category_id
order by good_name;

-- Выведите список товаров с названиями категорий, в том числе товаров, не принадлежащих ни к одной из категорий, в том числе категорий не содержащих ни одного товара.

select g.name as good_name, c.name as category_name  from good as g 
	LEFT OUTER JOIN category_has_good as chg 
		on g.id = chg.good_id
	LEFT OUTER JOIN category as c
		on c.id= chg.category_id
 union       
 select g.name as good_name, c.name as category_name  from good as g 
	RIGHT OUTER JOIN category_has_good as chg 
		on g.id = chg.good_id
	RIGHT OUTER JOIN category as c
		on c.id= chg.category_id;

-- Выведите список всех источников клиентов и суммарный объем заказов по каждому источнику. Результат должен включать также записи для источников, по которым не было заказов. s.name as source_name, sum(sale.sale_sum) as sale_sum

select s.name as source_name, sum(sale.sale_sum) as sale_sum from source as s 
	LEFT OUTER JOIN client as c
		on s.id = c.source_id
	LEFT OUTER JOIN sale 
		on c.id = sale.client_id
group by source_name;

-- Выведите названия товаров, которые относятся к категории 'Cakes' или фигурируют в заказах текущий статус которых 'delivering'. Результат не должен содержать одинаковых записей. В запросе необходимо использовать оператор UNION для объединения выборок по разным условиям.

select  * from category_has_good;
select	* from category;
select	* from good;


select good.name from good 
	inner join category_has_good 
		on good.id = category_has_good.good_id 
	inner join category 
		on category_has_good.category_id = category.id
	where category.name = 'Cakes'
union
select good.name from good 
	inner join sale_has_good 
		on good.id = sale_has_good.good_id
inner join sale 
		on sale_has_good.sale_id = sale.id 
inner join status 
		on sale.status_id = status.id
	where status.name = 'delivering';
    
    
-- Выведите список всех категорий продуктов и количество продаж товаров, относящихся к данной категории. Под количеством продаж товаров подразумевается суммарное количество единиц товара данной категории, фигурирующих в заказах с любым статусом.
    
select  * from category_has_good;
select	* from category;
select	* from good;

select category.name, count(sale.sale_sum) as sale_num from category 
	left outer join category_has_good
		on category.id = category_has_good.category_id
	left outer join good
		on category_has_good.good_id = good.id
	left outer join sale_has_good
		on good.id = sale_has_good.good_id
	left outer join sale
		on sale.id = sale_has_good.sale_id
group by category.name;


-- Выведите список источников, из которых не было клиентов, либо клиенты пришедшие из которых не совершали заказов или отказывались от заказов. Под клиентами, которые отказывались от заказов, необходимо понимать клиентов, у которых есть заказы, которые на момент выполнения запроса находятся в состоянии 'rejected'. В запросе необходимо использовать оператор UNION для объединения выборок по разным условиям.

select source.name from source 
	right outer join client
		on source.id = client.source_id
	right outer join sale
		on client.id = sale.client_id
	right outer join status
		on sale.status_id = status.id
where status.name = 'rejected'
union
select source.name from source
  where not exists (select * from client 
	where client.source_id = source.id);