-- Работаем под root

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



CREATE TABLE products_history
(
    id              SERIAL,                                          -- ID записи
    product_id      int,                                             -- ID товара
    event           enum ('create','price','delete'),                -- Поле типа ENUM, которое перечисляет случившееся с товаром событие: создание нового (create), изменение цены (price), удаление товара (delete)
    old_price       NUMERIC(8, 2) UNSIGNED DEFAULT NULL,             -- Старая цена (заполняется при событии price)
    new_price       NUMERIC(8, 2) UNSIGNED,                          -- Новая цена (заполняется при событии price)
    dt_modification DATETIME NOT NULL      DEFAULT CURRENT_TIMESTAMP -- Метка даты и времени, когда произошло изменение
);


set global log_bin_trust_function_creators=1;

-- триггеры на события
DELIMITER $$
CREATE TRIGGER
    `on_create_product`
    AFTER INSERT
    ON `products`
    FOR EACH ROW
BEGIN
    INSERT INTO `products_history` (`product_id`, `event`, `old_price`, `new_price`)
    VALUES (NEW.id, 'create', NULL, NEW.price); -- Думаю, вставка в old_price NULL будет корректно
END
    $$
DELIMITER ;

DELIMITER $$
CREATE TRIGGER
    `on_change_price`
    AFTER UPDATE
    ON `products`
    FOR EACH ROW
BEGIN
    IF OLD.price <> NEW.price THEN -- Добавил проверку на изменение цены товара
        INSERT INTO `products_history` (`product_id`, `event`, `old_price`, `new_price`)
        VALUES (NEW.id, 'price', OLD.price, NEW.price);
END IF;
END
$$
DELIMITER ;

DELIMITER $$
CREATE TRIGGER
    `on_delete`
    AFTER DELETE
    ON `products`
    FOR EACH ROW
BEGIN
    INSERT INTO `products_history` (`product_id`, `event`, `old_price`, `new_price`)
    VALUES (old.id, 'delete', old.price, old.price);
END
    $$
DELIMITER ;

-- Проверка вставки
INSERT INTO `products` (`id`, `article`, `title`, `price`, `old_price`, `image`, `sale_date`, `amount`)
VALUES (1, "TESTDCA210BE-2296-B9C5-8797-4C5DEC38DA70", "Product1", "786.32", NULL, "https://reddit.com/settings",
        "2021-10-19", 1),
       (2, "TEST547233B4-6992-2218-B82E-A568F847B84B", "Product2", "73.98", NULL, "http://whatsapp.com/en-ca",
        "2022-02-21", 1),
       (3, "TESTF129CDC4-C004-87CD-140B-A46231D88460", "Product3", "821.74", NULL, "http://wikipedia.org/group/9",
        "2022-09-4", 1),
       (4, "TESTBFD9FBAB-752D-A81D-358C-B5ABF536CC95", "Product4", "175.83", NULL, "http://guardian.co.uk/sub",
        "2021-09-25", 1),
       (5, "TEST59346ECD-6DD2-A92A-FB1C-8C1FA5DB7736", "Product5", "130.90", NULL, "http://netflix.com/one",
        "2021-07-28", 1),
       (6, "D653E74D-302B-C847-DEE1-9B3E8A3170D2", "Product6", "984.80", NULL, "http://facebook.com/sub", "2022-04-10",
        1),
       (7, "2728C1DC-1A5C-4A76-E597-DD52958E9EE2", "Product7", "767.72", NULL, "https://ebay.com/en-ca", "2023-03-20",
        1),
       (8, "E9D7AB44-EB82-1351-158A-6015D9401604", "Product8", "813.36", NULL, "http://nytimes.com/site", "2022-03-5",
        1),
       (9, "A49A3709-2993-1BBF-5A5E-0EB2E4E18BCC", "Product9", "796.18", NULL, "https://yahoo.com/fr", "2022-04-13", 1),
       (10, "05C925B1-E59B-025A-6D9E-F06E15AAC316", "Product10", "771.40", NULL, "https://twitter.com/settings",
        "2023-04-29", 1);

INSERT INTO `products` (`id`, `article`, `title`, `price`, `old_price`, `image`, `sale_date`, `amount`)
VALUES (11, "Product11", "Product11", "100", NULL, "https://reddit.com/settings",
        "2021-10-19", 1),
       (12, "Product12", "Product12", "200", NULL, "http://whatsapp.com/en-ca",
        "2022-02-21", 1),
       (13, "Product13", "Product13", "300", NULL, "http://wikipedia.org/group/9",
        "2022-09-4", 1);

-- Проверка обновления
UPDATE products
SET price = 220
WHERE id = 12;

UPDATE products
SET price = 110
WHERE id = 11;


UPDATE products
SET price = 330
WHERE id = 13;

-- Создайте функцию "размер скидки", которая по ID товара будет вычислять - сколько составило последнее изменение цены на него в процентах, используя запрос к таблице из пункта 2. Примените эту функцию в запросе на выборку товаров.

DELIMITER $$
CREATE FUNCTION discount(gid BIGINT)
    RETURNS NUMERIC(8,2)
BEGIN
RETURN (
    SELECT (new_price - old_price) / old_price * 100
    FROM products_history WHERE product_id = gid and event = 'price'
    ORDER BY dt_modification DESC LIMIT 1);
END;
DELIMITER ;

-- Пример использования
SELECT id, title, discount(id) as discount FROM products where id=13;

