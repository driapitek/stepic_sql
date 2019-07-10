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
