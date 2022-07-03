-- Запрос, который выберет категории и среднюю цену товаров в каждой категории, при условии,
-- что эта средняя цена менее 1000 рублей (выбираем "бюджетные" категории товаров)
-- Да, такая магия как с mysql не сработала. ((
-- И having нельзя подставить avarage
SELECT categories.*, AVG(products.price) AS avarage
FROM categories
         LEFT JOIN products ON categories.id = products.category_id
GROUP BY categories.id
HAVING AVG(products.price) < 1000;


-- Улучшите предыдущий запрос таким образом, чтобы в расчет средней цены включались только товары, имеющиеся на складе.
-- Да, такая магия как с mysql не сработала. ((
SELECT categories.*, AVG(products.price) AS avarage
FROM categories
         LEFT JOIN products ON categories.id = products.category_id
WHERE products.amount > 0
GROUP BY categories.id
HAVING AVG(products.price) < 1000;


-- Добавьте к таблице брендов класс бренда (A, B, C). Например, A - Apple, B - Samsung, C - Xiaomi.
ALTER TABLE brands
    ADD brand_type char(1);

-- Напишите запрос, который для каждой категории и класса брендов, представленных в категории выберет среднюю цену товаров.
SELECT categories.*, brands.brand_type, AVG(products.price) AS avarage
FROM categories
         LEFT JOIN products ON products.category_id = categories.id
         LEFT JOIN brands ON products.brand_id = brands.id
GROUP BY categories.id, brands.brand_type;

-- Добавьте к своей базе данных таблицу заказов. Простейший вариант - номер заказа, дата и время, ID товара.
-- Можете и сложнее, если у вас есть время.
CREATE TABLE orders
(
    id         SERIAL,
    order_id   BIGINT,
    product_id BIGINT,
    order_date TIMESTAMP NOT NULL DEFAULT CURRENT_TIMESTAMP

);


-- Напишите запрос, который выведет таблицу с полями "дата", "число заказов за дату", "сумма заказов за дату".
-- Для этого вам придется самостоятельно найти информацию о функциях работы с датой и временем.
SELECT DATE(order_date) AS date, COUNT(order_id) count, SUM(products.price) AS sum
FROM orders
    LEFT JOIN products ON orders.product_id = products.id
GROUP BY date;


-- * Улучшите этот запрос, введя группировку по признаку "дешевый товар", "средняя цена", "дорогой товар".
-- Критерии отнесения товара к той или иной группе определите самостоятельно.
-- В итоге должно получиться "дата", "группа по цене", "число заказов", "сумма заказов"
ALTER TABLE products
    ADD product_type text;

SELECT DATE(order_date) AS date,products.product_type, COUNT(order_id) count, SUM(products.price) AS sum
FROM orders
    LEFT JOIN products ON orders.product_id = products.id
GROUP BY date,products.product_type;