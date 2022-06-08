CREATE TABLE goods (
  id    INTEGER PRIMARY KEY AUTOINCREMENT NOT NULL,
  title TEXT, -- Наименование
  productid   TEXT NOT NULL, -- Артикул (внутренний код)
  image TEXT, -- TEXT, -- НаименованиеИзображение
  price NUMERIC(8, 2), -- Цена
  saledate DATE, -- Дата появления в продаже
  amount BIGINT UNSIGNED-- Количество на складе
);


/**
main> CREATE TABLE goods (
        id    INTEGER PRIMARY KEY AUTOINCREMENT NOT NULL,
        title TEXT, -- Наименование
        productid   TEXT NOT NULL, -- Артикул (внутренний код)
        image TEXT, -- TEXT, -- НаименованиеИзображение
        price NUMERIC(8, 2) UNSIGNED, -- Цена
        saledate DATE, -- Дата появления в продаже
        amount BIGINT UNSIGNED-- Количество на складе
      )
[2022-06-08 14:22:21] [1] [SQLITE_ERROR] SQL error or missing database (near "UNSIGNED": syntax error)
  */

INSERT INTO goods
  (title, productid, image, price, saledate, amount)
VALUES
  ('Товар1','11', '11.jpg', 110.5, '2022-05-20', 1),
  ('Товар2','22', '22.jpg', 220.5, '2022-01-12', 2),
  ('Товар3','33', '33.jpg', 300.0, '2022-07-07', 2),
  ('Товар4','44', '44.jpg', 400.0, '2022-05-14', 3),
  ('Товар5','77', '77.jpg', 88.5, '2022-02-27', 55);


INSERT INTO goods
  (title, productid, image, price, saledate, amount)
VALUES
  ('Товар Отрицательная цена','55', '55.jpg', -100, '2022-05-14', 10);

/**
[2022-06-08 14:22:35] 5 rows affected in 12 ms
main> INSERT INTO goods
        (title, productid, image, price, saledate, amount)
      VALUES
        ('Товар Отрицательная цена','55', '55.jpg', -100, '2022-05-14', 10)
[2022-06-08 14:22:40] 1 row affected in 9 ms

  */



INSERT INTO goods
  (title, productid, image, price, saledate, amount)
VALUES
  ('Товар Отрицательная количество товара','55', '55.jpg', 100, '2022-05-14', -10);
/**
main> INSERT INTO goods
        (title, productid, image, price, saledate, amount)
      VALUES
        ('Товар Отрицательная количество товара','55', '55.jpg', 100, '2022-05-14', -10)
[2022-06-08 14:23:06] 1 row affected in 15 ms
  */

INSERT INTO goods
  (title, productid, image, price, saledate, amount)
VALUES
  ('Товар Пустой артикул','', '66_1.jpg', 500, '2022-05-14', 5);

/**
main> INSERT INTO goods
        (title, productid, image, price, saledate, amount)
      VALUES
        ('Товар Пустой артикул','', '66_1.jpg', 500, '2022-05-14', 5)
[2022-06-08 14:23:13] 1 row affected in 8 ms
  */