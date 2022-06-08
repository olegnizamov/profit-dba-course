USE profit;

CREATE TABLE `goods` (
  id    SERIAL,
  title TEXT, -- Наименование
  productid   TEXT NOT NULL, -- Артикул (внутренний код)
  image TEXT, -- Изображение
  price NUMERIC(8, 2) UNSIGNED, -- Цена
  saledate DATE, -- Дата появления в продаже
  amount BIGINT UNSIGNED -- Количество на складе
);

INSERT INTO `goods`
  (`title`, `productid`, `image`, `price`, `saledate`, `amount`)
VALUES
  ('Товар1','11', '11.jpg', 110.5, '2022-05-20', 1),
  ('Товар2','22', '22.jpg', 220.5, '2022-01-12', 2),
  ('Товар3','33', '33.jpg', 300.0, '2022-07-07', 2),
  ('Товар4','44', '44.jpg', 400.0, '2022-05-14', 3),
  ('Товар5','77', '77.jpg', 88.5, '2022-02-27', 55);


INSERT INTO `goods`
  (`title`, `productid`, `image`, `price`, `saledate`, `amount`)
VALUES
  ('Товар Отрицательная цена','55', '55.jpg', -100, '2022-05-14', 10);

/**

  [2022-06-08 14:07:23] 5 rows affected in 8 ms
profit> INSERT INTO `goods`
          (`title`, `productid`, `image`, `price`, `saledate`, `amount`)
        VALUES
          ('Товар Отрицательная цена','55', '55.jpg', -100, '2022-05-14', 10)
[2022-06-08 14:07:34] [22001][1264] Data truncation: Out of range value for column 'price' at row 1
[2022-06-08 14:07:34] [22003][1264] Out of range value for column 'price' at row 1

  */



INSERT INTO `goods`
  (`title`, `productid`, `image`, `price`, `saledate`, `amount`)
VALUES
  ('Товар Отрицательная количество товара','55', '55.jpg', 100, '2022-05-14', -10);
/**

  profit> INSERT INTO `goods`
          (`title`, `productid`, `image`, `price`, `saledate`, `amount`)
        VALUES
          ('Товар Отрицательная количество товара','55', '55.jpg', 100, '2022-05-14', -10)
[2022-06-08 14:08:34] [22001][1264] Data truncation: Out of range value for column 'amount' at row 1
[2022-06-08 14:08:34] [22003][1264] Out of range value for column 'amount' at row 1

  */

INSERT INTO `goods`
  (`title`, `productid`, `image`, `price`, `saledate`, `amount`)
VALUES
  ('Товар Пустой артикул','', '66_1.jpg', 500, '2022-05-14', 5);

/**
ок? - он вставил пустую строчку, которая не равна Null, поэтому в целом корректно.
profit> INSERT INTO `goods`
          (`title`, `productid`, `image`, `price`, `saledate`, `amount`)
        VALUES
          ('Товар Пустой артикул','', '66_1.jpg', 500, '2022-05-14', 5)
[2022-06-08 14:08:51] 1 row affected in 8 ms

  */