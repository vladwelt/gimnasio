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
    capacidad TEXT NOT NULL,
    FOREIGN KEY(id_empleado) REFERENCES empleado (id_empleado)
    ON DELETE CASCADE ON UPDATE CASCADE);

CREATE TABLE limpieza(id_empleado INTEGER UNSIGNED NOT NULL,
    turno ENUM('maniana','tarde','noche')
    FOREIGN KEY(id_empleado) REFERENCES empleado (id_empleado)
    ON DELETE CASCADE ON UPDATE CASCADE);

CREATE TABLE atencion_cliente(id_empleado INTEGER UNSIGNED NOT NULL,
    formacion TEXT,
    FOREIGN KEY(id_empleado) REFERENCES empleado (id_empleado)
    ON RESTRICT CASCADE ON UPDATE CASCADE);

CREATE TABLE tiempo_salario_normal(id_empleado NOT NULL UNSIGNED,
    id_salario NOT NULL UNSIGNED,
    fecha_inicio DATE NOT NULL,
    fecha_fin DATE,
    fecha_emision DATE NOT NULL,
    fecha_cobro DATE,
    CONSTRAINT ``);

CREATE TABLE salario(id_salario INTEGER NOT NULL AUTO_INCREMENT PRIMARY KEY,
    sueldo_basico INTEGER NULL,
    hora_extra INTEGER NULL,
    falta INTEGER NULL,
    retraso INTEGER NULL,
    iva DECIMAL NULL,
    salario_hora INTEGER NULL);

CREATE TABLE servicio(id_servicio INTEGER NOT NULL AUTO_INCREMENT PRIMARY KEY,
    nombre VARCHAR(20) NOT NULL);

CREATE TABLE sala(id_sala INTEGER NOT NULL AUTO_INCREMENT PRIMARY KEY,
    nombre VARCHAR(20) NOT NULL);

CREATE TABLE horario(id_horario INTEGER NOT NULL AUTO_INCREMENT PRIMARY KEY,
    dia ENUM('lunes','martes','miercoles','jueves','viernes','sabado') NOT NULL,
    hora DATETIME NOT NULL);

CREATE TABLE sesion(id_sesion INTEGER NOT NULL AUTO_INCREMENT PRIMARY KEY,
    id_servicio INTEGER NOT NULL,
    id_empleado INTEGER NOT NULL,
    id_sala INTEGER NOT NULL,
    id_horario INTEGER NOT NULL,
    hora_inicio DATETIME,
    hora_fin DATE TIME
    CONSTRAINT fk_id_servicio FOREIGN KEY (id_servicio)
    REFERENCES servicio ON DELETE CASCADE ON UPDATE CASCADE,
    CONSTRAINT fk_id_empleado FOREIGN KEY (id_empleado)
    REFERENCES empleado ON DELETE CASCADE ON UPDATE CASCADE
    );

CREATE TABLE cliente(id_cliente INTEGER NOT NULL AUTO_INCREMENT PRIMARY KEY,
    nombre VARCHAR(20) NOT NULL,
    apellido_paterno VARCHAR(20) NOT NULL,
    apellido_materno VARCHAR(20),
    correo VARCHAR(40) NOT NULL,
    cuenta_facebook VARCHAR(30),
    cuenta_twitter VARCHAR(30),
    numero_registro INTEGER NOT NULL,
    telefono_celular INTEGER);

CREATE TABLE acceso_sala(id_cliente INTEGER UNSIGNED NOT NULL,
    id_sesion INTEGER UNSIGNED NOT NULL,
    hora_ingreso DATETIME NOT NULL
    CONSTRAINT fk_id_cliente FOREIGN KEY (id_cliente)
    REFERENCES cliente (id_cliente) ON DELETE RESTRICT ON UPDATE CASCADE,
    CONSTRAINT fk_id_sesion FOREIGN KEY (id_sesion)
    REFERENCES sesion (id_sesion) ON DELETE RESTRICT ON UPDATE CASCADE);

CREATE TABLE paquete(id_paquete INTEGER NOT NULL AUTO_INCREMENT PRIMARY KEY,
    nombre VARCHAR(20) NOT NULL,
    fecha_inicio DATETIME NOT NULL,
    fecha_vigencia DATETIME NOT NULL
    precio INTEGER NOT NULL);

CREATE TABLE paquete_extendido(id_paquete INTEGER UNSIGNED NOT NULL,
    nueva_fecha DATETIME NOT NULL,
    precio_extra INTEGER NOT NULL,
    CONSTRAINT fk_id_paquete FOREIGN KEY (id_paquete)
    REFERENCES paquete (id_paquete) ON DELETE RESTRICT ON UPDATE CASCADE);

CREATE TABLE compra(id_cliente INTEGER UNSIGNED NOT NULL,
    id_paquete INTEGER UNSIGNED NOT NULL,
    fecha_inicio DATE NOT NULL,
    fecha_fin DATE NOT NULL,
    numero_sesiones INTEGER NOT NULL,
    fecha_compra DATE,
    CONSTRAINT fk_id_cliente FOREIGN KEY (id_cliente)
    REFERENCES cliente (id_cliente) ON DELETE RESTRICT ON UPDATE CASCADE,
    CONSTRAINT fk_id_paquete FOREIGN KEY (id_paquete)
    REFERENCES paquete (id_paquete) ON DELETE RESTRICT ON UPDATE CASCADE);

CREATE TABLE equipo(id_equipo INTEGER UNSIGNED NOT NULL AUTO_INCREMENT PRIMARY KEY,
    id_sala INTEGER UNSIGNED NOT NULL,
    nombre VARCHAR(20) NOT NULL,
    marca VARCHAR(20),
    modelo VARCHAR(20),
    fecha_compra DATE NOT NULL,
    costo INTEGER NOT NULL,
    estado ENUM('alta','mantenimiento','baja') NOT NULL,
    fecha_garantia DATE,
    CONSTRAINT fk_id_sala FOREIGN KEY (id_sala)
    REFERENCES sala (id_sala) ON DELETE RESTRICT ON UPDATE CASCADE);

CREATE TABLE mantenimiento(id_equipo INTEGER UNSIGNED NOT NULL,
    id_empresa INTEGER UNSIGNED NOT NULL,
    fecha_propuesta DATE NOT NULL,
    fecha_entragada DATE,
    costo INTEGER NOT NULL,
    fecha_ingreso DATE NOT NULL
    CONSTRAINT fk_id_equipo FOREIGN KEY (id_equipo) 
    REFERENCES equipo (id_equipo) ON DELETE RESTRICT ON UPDATE CASCADE,
    CONSTRAINT fk_id_empresa FOREIGN KEY (id_empresa)
    REFERENCES empresa (id_equipo) ON DELETE RESTRICT ON UPDATE CASCADE);

CREATE TABLE empresa(id_empresa INTEGER NOT NULL AUTO_INCREMENT PRIMARY KEY,
    nombre VARCHAR(20) NOT NULL,
    telefono INTEGER NOT NULL,
    correo VARCHAR(20) NOT NULL,
    persona_contacto VARCHAR(30),
    nacionalidad VARCHAR(30));

