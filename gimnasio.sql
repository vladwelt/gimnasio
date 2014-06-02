
SET @OLD_FOREIGN_KEY_CHECKS=@@FOREIGN_KEY_CHECKS, FOREIGN_KEY_CHECKS=0;

DROP DATABASE IF EXISTS gimnasio;

CREATE DATABASE gimnasio;

USE gimnasio;

CREATE TABLE empleado(id_empleado INTEGER UNSIGNED NOT NULL AUTO_INCREMENT,
    nombre VARCHAR(20) NOT NULL,
    apellido_paterno VARCHAR(20) NOT NULL,
    apellido_materno VARCHAR(20) NULL,
    fecha_nacimiento DATE NOT NULL,
    fecha_entrada DATE NOT NULL,
    fecha_salida DATE NULL,
    telefono_fijo MEDIUMINT NULL, 
    telefono_celular MEDIUMINT NULL,
    PRIMARY KEY (id_empleado));

CREATE TABLE intructor(id_empleado INTEGER UNSIGNED NOT NULL,
    capacidad VARCHAR(50) NOT NULL,
    FOREIGN KEY(id_empleado) REFERENCES empleado (id_empleado)
    ON DELETE CASCADE ON UPDATE CASCADE);

CREATE TABLE limpieza(id_empleado INTEGER UNSIGNED NOT NULL,
    turno ENUM('mañana','tarde'),
    FOREIGN KEY(id_empleado) REFERENCES empleado (id_empleado)
    ON DELETE CASCADE ON UPDATE CASCADE) DEFAULT CHARACTER SET UTF8;

CREATE TABLE atencion_cliente(id_empleado INTEGER UNSIGNED NOT NULL,
    formacion VARCHAR(40) NOT NULL,
    FOREIGN KEY(id_empleado) REFERENCES empleado (id_empleado) 
    ON DELETE CASCADE ON UPDATE CASCADE);

CREATE TABLE periodo(id_periodo INTEGER UNSIGNED NOT NULL AUTO_INCREMENT,
    fecha_inicio DATE NOT NULL,
    fecha_fin DATE,
    PRIMARY KEY(id_periodo));

CREATE TABLE salario(id_salario INTEGER UNSIGNED NOT NULL AUTO_INCREMENT,
    id_empleado INTEGER UNSIGNED NOT NULL,
    id_periodo INTEGER UNSIGNED NOT NULL,
    liquido_pagable INTEGER UNSIGNED NOT NULL,
    total_ganado INTEGER UNSIGNED NOT NULL,
    fecha_emision DATE NOT NULL,
    fecha_cobro DATE,
    PRIMARY KEY (id_salario),
    FOREIGN KEY (id_empleado) REFERENCES instructor (id_empleado)
    ON DELETE CASCADE ON UPDATE CASCADE,
    FOREIGN KEY (id_periodo) REFERENCES periodo (id_periodo)
    ON DELETE CASCADE ON UPDATE CASCADE);

CREATE TABLE salario_normal(id_salario INTEGER UNSIGNED NOT NULL,
    sueldo_basico INTEGER UNSIGNED NOT NULL,
    hora_extra INTEGER UNSIGNED NOT NULL,
    falta INTEGER UNSIGNED NULL,
    retraso INTEGER UNSIGNED NULL,
    iva DECIMAL UNSIGNED NOT NULL,
    FOREIGN KEY(id_salario) REFERENCES salario (id_salario)
    ON DELETE RESTRICT ON UPDATE CASCADE);

CREATE TABLE salario_hora(id_salario INTEGER UNSIGNED NOT NULL,
    sueldo_hora INTEGER UNSIGNED NOT NULL,
    FOREIGN KEY(id_salario) REFERENCES salario (id_salario)
    ON DELETE RESTRICT ON UPDATE CASCADE);

CREATE TABLE servicio(id_servicio INTEGER UNSIGNED NOT NULL AUTO_INCREMENT PRIMARY KEY,
    nombre VARCHAR(20) NOT NULL);

CREATE TABLE sala(id_sala INTEGER UNSIGNED NOT NULL AUTO_INCREMENT PRIMARY KEY,
    nombre VARCHAR(20) NOT NULL);

CREATE TABLE horario(id_horario INTEGER UNSIGNED NOT NULL AUTO_INCREMENT PRIMARY KEY,
    dia ENUM('lunes','martes','miercoles','jueves','viernes','sabado') NOT NULL,
    hora DATETIME NOT NULL);

CREATE TABLE sesion(id_sesion INTEGER UNSIGNED NOT NULL AUTO_INCREMENT PRIMARY KEY,
    id_servicio INTEGER UNSIGNED NOT NULL,
    id_empleado INTEGER UNSIGNED NOT NULL,
    id_sala INTEGER UNSIGNED NOT NULL,
    id_horario INTEGER UNSIGNED NOT NULL,
    FOREIGN KEY (id_servicio) REFERENCES servicio (id_servicio) 
    ON DELETE CASCADE ON UPDATE CASCADE,
    FOREIGN KEY (id_empleado) REFERENCES instructor (id_empleado) 
    ON DELETE CASCADE ON UPDATE CASCADE,
    FOREIGN KEY (id_sala) REFERENCES sala (id_sala)
    ON DELETE CASCADE ON UPDATE CASCADE,
    FOREIGN KEY (id_horario) REFERENCES horario (id_horario)
    ON DELETE CASCADE ON UPDATE CASCADE);

CREATE TABLE cliente(id_cliente INTEGER UNSIGNED NOT NULL AUTO_INCREMENT PRIMARY KEY,
    nombre VARCHAR(20) NOT NULL,
    apellido_paterno VARCHAR(20) NOT NULL,
    apellido_materno VARCHAR(20),
    correo VARCHAR(40) NOT NULL,
    cuenta_facebook VARCHAR(30),
    cuenta_twitter VARCHAR(30),
    telefono_celular INTEGER);

CREATE TABLE acceso_sala(id_cliente INTEGER UNSIGNED NOT NULL,
    id_sesion INTEGER UNSIGNED NOT NULL,
    hora_ingreso DATETIME NOT NULL,
    FOREIGN KEY (id_cliente) REFERENCES cliente (id_cliente) 
    ON DELETE RESTRICT ON UPDATE CASCADE,
    FOREIGN KEY (id_sesion) REFERENCES sesion (id_sesion) 
    ON DELETE RESTRICT ON UPDATE CASCADE);

CREATE TABLE paquete(id_paquete INTEGER UNSIGNED NOT NULL AUTO_INCREMENT PRIMARY KEY,
    nombre VARCHAR(20) NOT NULL,
    fecha_inicio DATETIME NOT NULL,
    fecha_vigencia DATETIME NOT NULL,
    precio INTEGER UNSIGNED NOT NULL,
    numero_sesiones INTEGER UNSIGNED NOT NULL);

CREATE TABLE paquete_extendido(id_paquete INTEGER UNSIGNED NOT NULL,
    nueva_fecha DATETIME NOT NULL,
    precio_extra INTEGER NOT NULL,
    FOREIGN KEY (id_paquete)
    REFERENCES paquete (id_paquete) ON DELETE RESTRICT ON UPDATE CASCADE);

CREATE TABLE compra(id_cliente INTEGER UNSIGNED NOT NULL,
    id_paquete INTEGER UNSIGNED NOT NULL,
    numero_sesiones INTEGER NOT NULL,
    fecha_compra DATE,
    FOREIGN KEY (id_cliente) REFERENCES cliente (id_cliente) 
    ON DELETE RESTRICT ON UPDATE CASCADE,
    FOREIGN KEY (id_paquete) REFERENCES paquete (id_paquete) 
    ON DELETE RESTRICT ON UPDATE CASCADE);

CREATE TABLE equipo(id_equipo INTEGER UNSIGNED NOT NULL AUTO_INCREMENT PRIMARY KEY,
    id_sala INTEGER UNSIGNED NOT NULL,
    nombre VARCHAR(20) NOT NULL,
    marca VARCHAR(20),
    modelo VARCHAR(20),
    fecha_compra DATE NOT NULL,
    costo INTEGER NOT NULL,
    estado ENUM('alta','mantenimiento','baja') NOT NULL,
    fecha_garantia DATE,
    FOREIGN KEY (id_sala) REFERENCES sala (id_sala) 
    ON DELETE RESTRICT ON UPDATE CASCADE);

CREATE TABLE mantenimiento(id_equipo INTEGER UNSIGNED NOT NULL,
    id_empresa INTEGER UNSIGNED NOT NULL,
    fecha_ingreso DATE NOT NULL,
    fecha_propuesta DATE NOT NULL,
    fecha_entragada DATE,
    costo INTEGER NOT NULL,
    FOREIGN KEY (id_equipo) REFERENCES equipo (id_equipo) 
    ON DELETE RESTRICT ON UPDATE CASCADE,
    FOREIGN KEY (id_empresa) REFERENCES empresa (id_empresa) 
    ON DELETE RESTRICT ON UPDATE CASCADE);

CREATE TABLE empresa(id_empresa INTEGER UNSIGNED NOT NULL AUTO_INCREMENT PRIMARY KEY,
    nombre VARCHAR(20) NOT NULL,
    telefono INTEGER NOT NULL,
    correo VARCHAR(20) NOT NULL,
    persona_contacto VARCHAR(30),
    nacionalidad VARCHAR(30));

