-- работаем под root

USE profit;

CREATE TABLE products
(
    id        SERIAL,                              -- Автоинкрементный номер (назовите это поле ID), который является первичным ключом записи
    article   VARCHAR(50),                         -- Уникальный (это важно!) артикул товара
    title     TEXT,                                -- Наименование товара
    price     NUMERIC(8, 2) UNSIGNED,              -- Его цена
    old_price NUMERIC(8, 2) UNSIGNED DEFAULT NULL, -- Старая цена (NULL, если цена ранее не снижалась)
    image     TEXT,                                -- Ссылка на изображение
    sale_date DATE,                                -- Дата появления в продаже
    amount    BIGINT UNSIGNED,                     -- Количество на складе
    UNIQUE (article)
);

-- Создайте таблицу Категорий товаров (например "Еда", "Посуда", "Обувь") и таблицу производителей (брендов)
CREATE TABLE categories
(
    id    SERIAL,
    title TEXT
);

CREATE TABLE brands
(
    id    SERIAL,
    title TEXT
);

-- Добавьте в таблицу Товаров поля для связи с Категориями и Брендами
ALTER TABLE products
    ADD category_id BIGINT UNSIGNED NOT NULL;
ALTER TABLE products
    ADD brand_id BIGINT UNSIGNED NOT NULL;


-- Создайте внешние ключи для этих связей. Определите самостоятельно ограничения внешних ключей. Протестируйте работу внешних ключей.
ALTER TABLE products
    ADD FOREIGN KEY (category_id) REFERENCES categories (id) ON DELETE RESTRICT;
ALTER TABLE products
    ADD FOREIGN KEY (brand_id) REFERENCES brands (id) ON DELETE RESTRICT;

INSERT INTO categories (title)
VALUES ("Телефоны"),
       ("Стиральная машина"),
       ("Компьютеры"),
       ("Playstation");
INSERT INTO brands (title)
VALUES ("IPhone"),
       ("Honor"),
       ("HP"),
       ("Acer"),
       ("Playstation4");


INSERT INTO `products` (`id`, `article`, `title`, `price`, `old_price`, `image`, `sale_date`, `amount`, `category_id`,
                        `brand_id`)
VALUES (1, "TESTDCA210BE-2296-B9C5-8797-4C5DEC38DA70", "nunc. In", "786.32", "157.54", "https://reddit.com/settings",
        "2021-10-19", 31053, 1, 1),
       (2, "TEST547233B4-6992-2218-B82E-A568F847B84B", "id, ante.", "73.98", "92.25", "http://whatsapp.com/en-ca",
        "2022-02-21", 67639, 2, 3),
       (3, "TESTF129CDC4-C004-87CD-140B-A46231D88460", "velit eu sem. Pellentesque ut", "821.74", "885.25",
        "http://wikipedia.org/group/9", "2022-09-4", 45751, 3, 5),
       (4, "TESTBFD9FBAB-752D-A81D-358C-B5ABF536CC95", "eu, placerat eget, venenatis a,", "175.83", "849.30",
        "http://guardian.co.uk/sub", "2021-09-25", 33060, 4, 5),
       (5, "TEST59346ECD-6DD2-A92A-FB1C-8C1FA5DB7736", "pede. Suspendisse dui. Fusce", "130.90", "798.68",
        "http://netflix.com/one", "2021-07-28", 73020, 1, 2),
       (6, "D653E74D-302B-C847-DEE1-9B3E8A3170D2", "semper", "984.80", "705.84", "http://facebook.com/sub",
        "2022-04-10", 31357, 1, 4),
       (7, "2728C1DC-1A5C-4A76-E597-DD52958E9EE2", "Duis a mi fringilla mi lacinia mattis.", "767.72", "97.54",
        "https://ebay.com/en-ca", "2023-03-20", 25167, 2, 5);


-- Выберут все товары с указанием их категории и бренда
SELECT products.*, b.title AS brand, c.title AS category
FROM products
         INNER JOIN categories AS c ON products.category_id = c.id
         INNER JOIN brands AS b ON products.brand_id = b.id;



-- Выберут все товары, бренд которых начинается на букву "А"
SELECT *
FROM products
WHERE products.brand_id IN (SELECT id
                            FROM brands
                            WHERE title LIKE 'A%')
;


-- Выведут список категорий и число товаров в каждой (используйте подзапросы и функцию COUNT(), использовать группировку нельзя)
SELECT title, (SELECT COUNT(*) FROM products WHERE products.category_id = categories.id) AS count
FROM categories;


-- * Выберут для каждой категории список брендов товаров, входящих в нее
SELECT categories.*, GROUP_CONCAT(DISTINCT brands.title SEPARATOR ',') AS brand_list
FROM categories
         LEFT JOIN products ON products.category_id = categories.id
         LEFT JOIN brands ON products.brand_id = brands.id
GROUP BY categories.id
