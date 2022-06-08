CREATE TABLE books
(
    id   INTEGER PRIMARY KEY AUTOINCREMENT NOT NULL,
    title           TEXT,
    production_year INTEGER,
    author          TEXT,
    price           real
);

/**
  INTEGER PRIMARY KEY AUTOINCREMENT NOT NULL - делаем уникальный ключ равным integer, указываем что он
  должен являться первичным ключем, с увеличением на +1 при заполнении элемента и не должен быть равен nullr
  */

CREATE TABLE publishers
(
    id     INTEGER PRIMARY KEY AUTOINCREMENT NOT NULL,
    title TEXT,
    web   TEXT
);

INSERT INTO `books`
    (`title`, `production_year`, `author`, `price`)
VALUES ('Книга 1', 1985, 'Пушкин', 10),
       ('Книга 2', 1995, 'Толстой', 552.4),
       ('Книга 3', 1997, 'Чехов', 550.4),
       ('Книга 4', 1955, 'Лермонтов', 1000.10),
       ('Книга 5', 1972, 'Маяковский', 200),
       ('Книга 6', 2010, 'Есенин', 100.55);

INSERT INTO `publishers`
    (`title`, `web`)
VALUES ('Издательский дом «Питер»', 'www.piter.com'),
       ('Манн, Иванов и Фербер', 'www.mann-ivanov-ferber.ru'),
       ('Группа компаний «ЛитРес»',
        'www.litres.ru');

/**  Все книги определенного автора*/
SELECT * FROM books WHERE author='Пушкин';

/** Все книги ценой не более 500 рублей*/
SELECT * FROM books WHERE price<=500;


/** Заглавия книг (и год издания) определенного автора, отсортированные по году их издания */
SELECT `title`, `production_year`
FROM `books`
WHERE `author` = 'Маяковский'
ORDER BY `author`;

/** Имена авторов книг, вышедших в 1990-е годы*/
SELECT `author`
FROM `books`
WHERE `production_year` BETWEEN 1990 AND 1999;