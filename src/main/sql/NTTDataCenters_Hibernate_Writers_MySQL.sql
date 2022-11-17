------------------------------------------------------
-- AUTOR       : NTTDATA CENTERS - SEVILLA
-- DESCRIPCIÓN : JAVA - JDBC - MYSQL - PRUEBA ESCRITORES
-- RESPONSABLE : RAFAEL JOSÉ OSSORIO LÓPEZ
------------------------------------------------------

-- Eliminación de esquema.
-- DROP SCHEMA nttdata_jdbc_writers;

-- Creación de esquema.
CREATE SCHEMA nttdata_jdbc_writers DEFAULT CHARACTER SET utf8;

-- Uso de esquema.
USE nttdata_jdbc_writers;

-- Creación de tabla para escritores.
CREATE TABLE nttdata_mysql_writer (
	
	id_writer INT NOT NULL AUTO_INCREMENT,
	name VARCHAR(35),
    last_name VARCHAR(35),
	website VARCHAR(100),
    spanish_publisher VARCHAR(35),
	
	PRIMARY KEY(id_writer)
);

-- Creación de tabla para series.
CREATE TABLE nttdata_mysql_serie (
	id_serie INT NOT NULL AUTO_INCREMENT,
	name VARCHAR(35),
	genre VARCHAR(20),
    number_of_books INT,
	id_writer INT,
	
	PRIMARY KEY(id_serie),
	FOREIGN KEY(id_writer) REFERENCES nttdata_mysql_writer(id_writer)
);

-- Creación de tabla para libros.
CREATE TABLE nttdata_mysql_book (
	
	id_book INT NOT NULL AUTO_INCREMENT,
	name VARCHAR(35),
	release_date DATE,
    price FLOAT,
	id_serie INT,
	
	PRIMARY KEY(id_book),
	FOREIGN KEY(id_serie) REFERENCES nttdata_mysql_serie(id_serie)
);

-- Añadido de escritores.
INSERT INTO nttdata_mysql_writer (name, last_name, website, spanish_publisher) 
VALUES ("Brandon", "Sanderson", "https://www.brandonsanderson.com", "NOVA");

INSERT INTO nttdata_mysql_writer (name, last_name, website, spanish_publisher) 
VALUES ("Robert", "Jordan", "https://dragonmount.com", "Minotauro");

INSERT INTO nttdata_mysql_writer (name, last_name, website, spanish_publisher) 
VALUES ("Robert", "Anthony", "http://rasalvatore.com", "Timun Mas");

INSERT INTO nttdata_mysql_writer (name, last_name, website, spanish_publisher) 
VALUES ("Ken", "Follet", "https://ken-follett.com", "PLAZA & JANES EDITORES");

-- Añadido de series.
INSERT INTO nttdata_mysql_serie (name, genre, number_of_books, id_writer) 
VALUES ("Mistborn", 'Action', "7", (SELECT id_writer FROM nttdata_mysql_writer WHERE name = "Brandon"));
INSERT INTO nttdata_mysql_serie (name, genre, number_of_books, id_writer) 
VALUES ("Stormlight Archive", 'Epic Fantasy', "5", (SELECT id_writer FROM nttdata_mysql_writer WHERE name = "Brandon"));

INSERT INTO nttdata_mysql_serie (name, genre, number_of_books, id_writer) 
VALUES ("The Wheel of Time", 'Epic Fantasy', "5", (SELECT id_writer FROM nttdata_mysql_writer WHERE name = "Robert" AND last_name = "Jordan"));

INSERT INTO nttdata_mysql_serie (name, genre, number_of_books, id_writer) 
VALUES ("The Dark Elf", 'Epic Fantasy', "3", (SELECT id_writer FROM nttdata_mysql_writer WHERE name = "Robert" AND last_name = "Anthony"));
INSERT INTO nttdata_mysql_serie (name, genre, number_of_books, id_writer) 
VALUES ("Icewind Dale", 'Epic Fantasy', "3", (SELECT id_writer FROM nttdata_mysql_writer WHERE name = "Robert" AND last_name = "Anthony"));
INSERT INTO nttdata_mysql_serie (name, genre, number_of_books, id_writer) 
VALUES ("Legacy of the Drow", 'Epic Fantasy', "4", (SELECT id_writer FROM nttdata_mysql_writer WHERE name = "Robert" AND last_name = "Anthony"));

INSERT INTO nttdata_mysql_serie (name, genre, number_of_books, id_writer) 
VALUES ("Pillars of the Earth", 'Historical Fiction', "4", (SELECT id_writer FROM nttdata_mysql_writer WHERE name = "Ken"));

-- Añadido de libros.
INSERT INTO nttdata_mysql_book (name, release_date, price, id_serie) 
VALUES ("The Final Empire", '2006-07-17', "12.30", (SELECT id_serie FROM nttdata_mysql_serie WHERE name = "Mistborn"));
INSERT INTO nttdata_mysql_book (name, release_date, price, id_serie) 
VALUES ("The Well of Ascension", '2007-08-21', "12.50", (SELECT id_serie FROM nttdata_mysql_serie WHERE name = "Mistborn"));
INSERT INTO nttdata_mysql_book (name, release_date, price, id_serie) 
VALUES ("The Hero of Ages", '2008-10-14', "13.50", (SELECT id_serie FROM nttdata_mysql_serie WHERE name = "Mistborn"));
INSERT INTO nttdata_mysql_book (name, release_date, price, id_serie) 
VALUES ("Alloy of Law", '2011-11-08', "12.80", (SELECT id_serie FROM nttdata_mysql_serie WHERE name = "Mistborn"));
INSERT INTO nttdata_mysql_book (name, release_date, price, id_serie) 
VALUES ("Shadows of Self", '2015-10-06', "13.90", (SELECT id_serie FROM nttdata_mysql_serie WHERE name = "Mistborn"));
INSERT INTO nttdata_mysql_book (name, release_date, price, id_serie) 
VALUES ("Bands of Mourning", '2016-01-26', "15.00", (SELECT id_serie FROM nttdata_mysql_serie WHERE name = "Mistborn"));
INSERT INTO nttdata_mysql_book (name, release_date, price, id_serie) 
VALUES ("The Lost Metal", '2022-11-15', "15.50", (SELECT id_serie FROM nttdata_mysql_serie WHERE name = "Mistborn"));

INSERT INTO nttdata_mysql_book (name, release_date, price, id_serie) 
VALUES ("The Way of Kings", '2010-08-31', "16.30", (SELECT id_serie FROM nttdata_mysql_serie WHERE name = "Stormlight Archive"));
INSERT INTO nttdata_mysql_book (name, release_date, price, id_serie) 
VALUES ("Words of Radiance", '2014-03-04', "16.50", (SELECT id_serie FROM nttdata_mysql_serie WHERE name = "Stormlight Archive"));
INSERT INTO nttdata_mysql_book (name, release_date, price, id_serie) 
VALUES ("Oathbringer", '2017-11-14', "16.80", (SELECT id_serie FROM nttdata_mysql_serie WHERE name = "Stormlight Archive"));
INSERT INTO nttdata_mysql_book (name, release_date, price, id_serie) 
VALUES ("Rhythm of War", '2020-11-17', "17.00", (SELECT id_serie FROM nttdata_mysql_serie WHERE name = "Stormlight Archive"));
INSERT INTO nttdata_mysql_book (name, release_date, price, id_serie) 
VALUES ("TBA", '2023-01-01', "19.99", (SELECT id_serie FROM nttdata_mysql_serie WHERE name = "Stormlight Archive"));

INSERT INTO nttdata_mysql_book (name, release_date, price, id_serie) 
VALUES ("New Spring", '2004-01-06', "14.99", (SELECT id_serie FROM nttdata_mysql_serie WHERE name = "The Wheel of Time"));
INSERT INTO nttdata_mysql_book (name, release_date, price, id_serie) 
VALUES ("The Eye of the World", '1990-01-15', "12.95", (SELECT id_serie FROM nttdata_mysql_serie WHERE name = "The Wheel of Time"));
INSERT INTO nttdata_mysql_book (name, release_date, price, id_serie) 
VALUES ("The Great Hunt", '1990-11-15', "13.95", (SELECT id_serie FROM nttdata_mysql_serie WHERE name = "The Wheel of Time"));
INSERT INTO nttdata_mysql_book (name, release_date, price, id_serie) 
VALUES ("The Dragon Reborn", '1991-10-15', "14.99", (SELECT id_serie FROM nttdata_mysql_serie WHERE name = "The Wheel of Time"));
INSERT INTO nttdata_mysql_book (name, release_date, price, id_serie) 
VALUES ("The Shadow Rising", '1992-09-15', "14.90", (SELECT id_serie FROM nttdata_mysql_serie WHERE name = "The Wheel of Time"));

INSERT INTO nttdata_mysql_book (name, release_date, price, id_serie) 
VALUES ("Homeland", '1990-12-01', "10.99", (SELECT id_serie FROM nttdata_mysql_serie WHERE name = "The Dark Elf"));
INSERT INTO nttdata_mysql_book (name, release_date, price, id_serie) 
VALUES ("Exile", '1991-02-03', "12.99", (SELECT id_serie FROM nttdata_mysql_serie WHERE name = "The Dark Elf"));
INSERT INTO nttdata_mysql_book (name, release_date, price, id_serie) 
VALUES ("Sojourn", '1991-03-14', "13.00", (SELECT id_serie FROM nttdata_mysql_serie WHERE name = "The Dark Elf"));

INSERT INTO nttdata_mysql_book (name, release_date, price, id_serie) 
VALUES ("The Crystal Shard", '1988-11-03', "11.99", (SELECT id_serie FROM nttdata_mysql_serie WHERE name = "Icewind Dale"));
INSERT INTO nttdata_mysql_book (name, release_date, price, id_serie) 
VALUES ("Streams of Silver", '1989-05-01', "11.99", (SELECT id_serie FROM nttdata_mysql_serie WHERE name = "Icewind Dale"));
INSERT INTO nttdata_mysql_book (name, release_date, price, id_serie) 
VALUES ("The Halfling's Gem", '1990-02-02', "12.95", (SELECT id_serie FROM nttdata_mysql_serie WHERE name = "Icewind Dale"));

INSERT INTO nttdata_mysql_book (name, release_date, price, id_serie) 
VALUES ("The Legacy", '1992-12-14', "11.99", (SELECT id_serie FROM nttdata_mysql_serie WHERE name = "Legacy of the Drow"));
INSERT INTO nttdata_mysql_book (name, release_date, price, id_serie) 
VALUES ("Starless Night", '1993-11-01', "11.99", (SELECT id_serie FROM nttdata_mysql_serie WHERE name = "Legacy of the Drow"));
INSERT INTO nttdata_mysql_book (name, release_date, price, id_serie) 
VALUES ("Siege of Darkness", '1994-05-10', "12.95", (SELECT id_serie FROM nttdata_mysql_serie WHERE name = "Legacy of the Drow"));
INSERT INTO nttdata_mysql_book (name, release_date, price, id_serie) 
VALUES ("Passage to Dawn", '1996-06-09', "12.95", (SELECT id_serie FROM nttdata_mysql_serie WHERE name = "Legacy of the Drow"));

INSERT INTO nttdata_mysql_book (name, release_date, price, id_serie) 
VALUES ("The Pillars of the Earth", '1989-10-05', "15.99", (SELECT id_serie FROM nttdata_mysql_serie WHERE name = "Pillars of the Earth"));
INSERT INTO nttdata_mysql_book (name, release_date, price, id_serie) 
VALUES ("World Without End", '2007-05-10', "18.95", (SELECT id_serie FROM nttdata_mysql_serie WHERE name = "Pillars of the Earth"));
INSERT INTO nttdata_mysql_book (name, release_date, price, id_serie) 
VALUES ("A Column of Fire", '2017-06-11', "16.95", (SELECT id_serie FROM nttdata_mysql_serie WHERE name = "Pillars of the Earth"));
INSERT INTO nttdata_mysql_book (name, release_date, price, id_serie) 
VALUES ("The Evening and the Morning", '2020-09-15', "19.99", (SELECT id_serie FROM nttdata_mysql_serie WHERE name = "Pillars of the Earth"));