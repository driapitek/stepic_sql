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