DROP DATABASE IF EXISTS coro_db;

CREATE DATABASE IF NOT EXISTS coro_db;

USE coro_db;
/*
CREATE TABLE IF NOT EXISTS integrante(
	in_nombre VARCHAR (50) NOT NULL,
    in_genero ENUM ('M','F') NOT NULL
	);

CREATE TABLE IF NOT EXISTS canto_entrada(
	ca_entrada VARCHAR (30) NOT NULL
	);
    
CREATE TABLE IF NOT EXISTS canto_piedad(
	ca_piedad VARCHAR (10) NOT NULL
	);
    
CREATE TABLE IF NOT EXISTS canto_gloria(
	ca_gloria VARCHAR (20) NOT NULL
	);
    
CREATE TABLE IF NOT EXISTS canto_salmo(
	ca_salmo VARCHAR (10) NOT NULL
	);
    
CREATE TABLE IF NOT EXISTS canto_aleluya(
	ca_aleluya VARCHAR (30) NOT NULL
	);
    
CREATE TABLE IF NOT EXISTS canto_ofertorio(
	ca_ofertorio VARCHAR (30) NOT NULL
	);
    
CREATE TABLE IF NOT EXISTS canto_santo(
	ca_santo VARCHAR (20) NOT NULL
	);
    
CREATE TABLE IF NOT EXISTS canto_cordero(
	ca_cordero VARCHAR (10) NOT NULL
	);
    
CREATE TABLE IF NOT EXISTS canto_comunion(
	ca_comunion VARCHAR (30) NOT NULL
	);
    
CREATE TABLE IF NOT EXISTS canto_salida(
	ca_salida VARCHAR (10) NOT NULL
	);
*/

CREATE TABLE IF NOT EXISTS misa(
	mi_id INT NOT NULL AUTO_INCREMENT,
    mi_fecha DATE NOT NULL,
    mi_tipo VARCHAR (30),
	mi_entrada ENUM		('Venimos hoy a tu altar', 'Vienen con alegría', 'Den al señor sus alabanzas', 'Aquí estoy señor', 
						'Al fin', 'Quince años', 'Que alegría cuando me dijeron', 'Tú eres fiel', 'Que viva mi cristo', 
						'En torno a tu altar', '*No hay*', '*No aplica*') NOT NULL,
	mi_piedad ENUM		('Popular', 'Triste', 'Brandon', 'Rocker', '*No hay*', '*No aplica*') NOT NULL,
	mi_gloria ENUM		('90', 'Mejía', 'Rítmico', 'Panamericano', 'Popular', '*No hay*', '*No aplica*'),
	mi_salmo ENUM		('Lento', 'Rapido', 'Otro ritmo', '*No hay*', '*No aplica*') NOT NULL,
	mi_aleluya ENUM		('Solemne', 'Al salvador', 'Popular', 'Karla', 'Javi', 'Ángel', 'Honor y gloria', 
						'Honor y gloria alternativo', '*No hay*', '*No aplica*') NOT NULL,
	mi_ofertorio ENUM	('Vino y pan', 'Este pan y vino', 'Esto que te doy', 'Te ofrezco, señor, mi juventud',
						'Tómalo, acéptalo', 'Nuestro corazón', 'Te presentamos', 'En tus manos', '*No hay*', '*No aplica*') NOT NULL,
	mi_santo ENUM		('La-Mi-Do', 'Edith', 'Gabi', 'Rondalla', '3 Hosanas', 'Hosana', 'Choco', '*No hay*', '*No aplica*') NOT NULL,
	mi_cordero ENUM		('Popular', 'Juvenil', 'Choco', '94', 'Roy', 'Marcha', 'Doble', '*No hay*', '*No aplica*') NOT NULL,
	mi_comunion ENUM	('El vino', 'Llévame', 'La promesa', 'Abba padre', 'Una espiga', 'Andando de tu mano, Dios está aqui',
						'Las heridas de tu frente', 'Un instrumento de tu amor', 'Ven señor Jesus', 'Un día caminaba', 'Heroe',
						'Dialogo con Cristo', '*No hay*', '*No aplica*') NOT NULL,
	mi_salida ENUM		('Alma misionera', 'Te doy gracias Jesus', 'Dios es amor', 'Cristo no defrauda', 'Fragmento a Dios',
						 'Viva cristo rey', '*No hay*', '*No aplica*') NOT NULL,
	mi_comentario VARCHAR (300),
    PRIMARY KEY (mi_id)
    );

CREATE TABLE IF NOT EXISTS asistencia (
	as_fecha DATE NOT NULL,
    as_evento VARCHAR (30) NOT NULL
	);

INSERT INTO misa (mi_fecha, mi_tipo, mi_entrada, mi_piedad, mi_gloria, mi_salmo, mi_aleluya ,
					mi_ofertorio, mi_santo, mi_cordero, mi_comunion , mi_salida, mi_comentario)
	VALUES ('2023-07-02', 'Ordinario', '*No aplica*', 'Rocker', 'Mejía', 'Lento', 'Al salvador',
			'Nuestro corazón', 'Edith', 'Juvenil', 'Un día caminaba', 'Dios es amor', 
            'Copia del canto de gloria y de santo, mala ejecución del canto de comunión, desde el intento de armonización hasta subir la nota al final')
