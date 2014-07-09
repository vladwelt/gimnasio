SET @OLD_UNIQUE_CHECKS=@@UNIQUE_CHECKS, UNIQUE_CHECKS=0;
SET @OLD_FOREIGN_KEY_CHECKS=@@FOREIGN_KEY_CHECKS, FOREIGN_KEY_CHECKS=0;
SET @OLD_SQL_MODE=@@SQL_MODE, SQL_MODE='TRADITIONAL';

DROP SCHEMA IF EXISTS `gimnasio` ;
CREATE SCHEMA IF NOT EXISTS `gimnasio` DEFAULT CHARACTER SET utf8 COLLATE utf8_spanish2_ci ;
USE `gimnasio` ;

-- -----------------------------------------------------
-- Table `gimnasio`.`EMPLEADO`
-- -----------------------------------------------------
DROP TABLE IF EXISTS `gimnasio`.`EMPLEADO` ;

CREATE  TABLE IF NOT EXISTS `gimnasio`.`EMPLEADO` (
  `id_empleado` INT UNSIGNED NOT NULL AUTO_INCREMENT ,
  `nombre` VARCHAR(30) NOT NULL COMMENT '		' ,
  `apellido_paterno` VARCHAR(30) NOT NULL ,
  `apellido_materno` VARCHAR(30) NULL ,
  `fecha_nacimiento` DATE NOT NULL ,
  `fecha_entrada` DATE NOT NULL ,
  `fecha_salida` DATE NULL ,
  `telefono_fijo` INT NULL ,
  `telefono_celular` INT NOT NULL ,
  `cargo` VARCHAR(30) NULL ,
  PRIMARY KEY (`id_empleado`) )
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `gimnasio`.`LIMPIEZA`
-- -----------------------------------------------------
DROP TABLE IF EXISTS `gimnasio`.`LIMPIEZA` ;

CREATE  TABLE IF NOT EXISTS `gimnasio`.`LIMPIEZA` (
  `id_empleado` INT UNSIGNED NOT NULL ,
  `turno` ENUM('manana','tarde') NOT NULL ,
  PRIMARY KEY (`id_empleado`) ,
  CONSTRAINT `fk_table1_EMPLEADO`
    FOREIGN KEY (`id_empleado` )
    REFERENCES `gimnasio`.`EMPLEADO` (`id_empleado` )
    ON DELETE RESTRICT
    ON UPDATE CASCADE)
ENGINE = InnoDB
DEFAULT CHARACTER SET = utf8
COLLATE = utf8_spanish2_ci;


-- -----------------------------------------------------
-- Table `gimnasio`.`ATENCION_CLIENTE`
-- -----------------------------------------------------
DROP TABLE IF EXISTS `gimnasio`.`ATENCION_CLIENTE` ;

CREATE  TABLE IF NOT EXISTS `gimnasio`.`ATENCION_CLIENTE` (
  `id_empleado` INT UNSIGNED NOT NULL ,
  `formacion` VARCHAR(30) NULL ,
  PRIMARY KEY (`id_empleado`) ,
  CONSTRAINT `fk_table2_EMPLEADO1`
    FOREIGN KEY (`id_empleado` )
    REFERENCES `gimnasio`.`EMPLEADO` (`id_empleado` )
    ON DELETE RESTRICT
    ON UPDATE CASCADE)
ENGINE = InnoDB
DEFAULT CHARACTER SET = utf8
COLLATE = utf8_spanish2_ci;


-- -----------------------------------------------------
-- Table `gimnasio`.`INSTRUCTOR`
-- -----------------------------------------------------
DROP TABLE IF EXISTS `gimnasio`.`INSTRUCTOR` ;

CREATE  TABLE IF NOT EXISTS `gimnasio`.`INSTRUCTOR` (
  `id_empleado` INT UNSIGNED NOT NULL ,
  `capacidad` VARCHAR(45) NULL ,
  PRIMARY KEY (`id_empleado`) ,
  CONSTRAINT `fk_table3_EMPLEADO1`
    FOREIGN KEY (`id_empleado` )
    REFERENCES `gimnasio`.`EMPLEADO` (`id_empleado` )
    ON DELETE RESTRICT
    ON UPDATE CASCADE)
ENGINE = InnoDB
DEFAULT CHARACTER SET = utf8
COLLATE = utf8_spanish2_ci;


-- -----------------------------------------------------
-- Table `gimnasio`.`SALA`
-- -----------------------------------------------------
DROP TABLE IF EXISTS `gimnasio`.`SALA` ;

CREATE  TABLE IF NOT EXISTS `gimnasio`.`SALA` (
  `id_sala` INT UNSIGNED NOT NULL AUTO_INCREMENT ,
  `nombre` VARCHAR(30) NOT NULL ,
  PRIMARY KEY (`id_sala`) )
ENGINE = InnoDB
DEFAULT CHARACTER SET = utf8
COLLATE = utf8_spanish2_ci;


-- -----------------------------------------------------
-- Table `gimnasio`.`EQUIPO`
-- -----------------------------------------------------
DROP TABLE IF EXISTS `gimnasio`.`EQUIPO` ;

CREATE  TABLE IF NOT EXISTS `gimnasio`.`EQUIPO` (
  `id_equipo` INT UNSIGNED NOT NULL AUTO_INCREMENT ,
  `id_sala` INT UNSIGNED NOT NULL ,
  `nombre` VARCHAR(45) NOT NULL ,
  `marca` VARCHAR(45) NOT NULL ,
  `modelo` VARCHAR(30) NULL ,
  `fecha_compra` DATE NOT NULL ,
  `costo` INT NOT NULL ,
  `estado` ENUM('alta','baja','mantenimiento') NOT NULL ,
  `fecha_fin_garantia` DATE NOT NULL ,
  PRIMARY KEY (`id_equipo`) ,
  INDEX `fk_EQUIPO_SALA1` (`id_sala` ASC) ,
  CONSTRAINT `fk_EQUIPO_SALA1`
    FOREIGN KEY (`id_sala` )
    REFERENCES `gimnasio`.`SALA` (`id_sala` )
    ON DELETE RESTRICT
    ON UPDATE CASCADE)
ENGINE = InnoDB
DEFAULT CHARACTER SET = utf8
COLLATE = utf8_spanish2_ci;


-- -----------------------------------------------------
-- Table `gimnasio`.`EMPRESA`
-- -----------------------------------------------------
DROP TABLE IF EXISTS `gimnasio`.`EMPRESA` ;

CREATE  TABLE IF NOT EXISTS `gimnasio`.`EMPRESA` (
  `id_empresa` INT UNSIGNED NOT NULL AUTO_INCREMENT ,
  `nombre` VARCHAR(30) NULL ,
  `telefono` INT NULL ,
  `correo` VARCHAR(45) NULL ,
  `persona_de_contacto` VARCHAR(40) NULL ,
  `nacionalidad` VARCHAR(30) NULL ,
  PRIMARY KEY (`id_empresa`) )
ENGINE = InnoDB
DEFAULT CHARACTER SET = utf8
COLLATE = utf8_spanish2_ci;


-- -----------------------------------------------------
-- Table `gimnasio`.`MANTENIMIENTO`
-- -----------------------------------------------------
DROP TABLE IF EXISTS `gimnasio`.`MANTENIMIENTO` ;

CREATE  TABLE IF NOT EXISTS `gimnasio`.`MANTENIMIENTO` (
  `id_equipo` INT UNSIGNED NOT NULL ,
  `id_empresa` INT UNSIGNED NOT NULL ,
  `fecha_ingreso` DATE NULL ,
  `fecha_entrega_propuesta` DATE NULL ,
  `fecha_entrega_real` DATE NULL ,
  `costo` INT NULL ,
  PRIMARY KEY (`id_equipo`, `id_empresa`) ,
  INDEX `fk_EQUIPO_has_EMPRESA_EMPRESA1` (`id_empresa` ASC) ,
  INDEX `fk_EQUIPO_has_EMPRESA_EQUIPO1` (`id_equipo` ASC) ,
  CONSTRAINT `fk_EQUIPO_has_EMPRESA_EQUIPO1`
    FOREIGN KEY (`id_equipo` )
    REFERENCES `gimnasio`.`EQUIPO` (`id_equipo` )
    ON DELETE RESTRICT
    ON UPDATE CASCADE,
  CONSTRAINT `fk_EQUIPO_has_EMPRESA_EMPRESA1`
    FOREIGN KEY (`id_empresa` )
    REFERENCES `gimnasio`.`EMPRESA` (`id_empresa` )
    ON DELETE RESTRICT
    ON UPDATE CASCADE)
ENGINE = InnoDB
DEFAULT CHARACTER SET = utf8
COLLATE = utf8_spanish2_ci;


-- -----------------------------------------------------
-- Table `gimnasio`.`CLIENTE`
-- -----------------------------------------------------
DROP TABLE IF EXISTS `gimnasio`.`CLIENTE` ;

CREATE  TABLE IF NOT EXISTS `gimnasio`.`CLIENTE` (
  `id_cliente` INT UNSIGNED NOT NULL AUTO_INCREMENT ,
  `nombre` VARCHAR(25) NOT NULL ,
  `apellido_paterno` VARCHAR(25) NOT NULL ,
  `apellido_materno` VARCHAR(25) NULL ,
  `correo` VARCHAR(40) NOT NULL ,
  `cuenta_twiter` VARCHAR(25) NULL ,
  `cuenta_facebook` VARCHAR(40) NULL ,
  `telefono_celular` INT NOT NULL ,
  PRIMARY KEY (`id_cliente`) )
ENGINE = InnoDB
DEFAULT CHARACTER SET = utf8
COLLATE = utf8_spanish2_ci;


-- -----------------------------------------------------
-- Table `gimnasio`.`PAQUETE`
-- -----------------------------------------------------
DROP TABLE IF EXISTS `gimnasio`.`PAQUETE` ;

CREATE  TABLE IF NOT EXISTS `gimnasio`.`PAQUETE` (
  `id_paquete` INT UNSIGNED NOT NULL AUTO_INCREMENT ,
  `nombre` VARCHAR(30) NOT NULL ,
  `fecha_inicio` DATE NOT NULL ,
  `fecha_vigencia` DATE NOT NULL ,
  `precio` INT NOT NULL ,
  PRIMARY KEY (`id_paquete`) )
ENGINE = InnoDB
DEFAULT CHARACTER SET = utf8
COLLATE = utf8_spanish2_ci;


-- -----------------------------------------------------
-- Table `gimnasio`.`COMPRA`
-- -----------------------------------------------------
DROP TABLE IF EXISTS `gimnasio`.`COMPRA` ;

CREATE  TABLE IF NOT EXISTS `gimnasio`.`COMPRA` (
  `id_compra` INT NOT NULL AUTO_INCREMENT ,
  `id_paquete` INT UNSIGNED NOT NULL ,
  `id_cliente` INT UNSIGNED NOT NULL ,
  `numero_sesiones` INT NOT NULL ,
  `fecha_compra` DATE NOT NULL ,
  `sesiones_restantes` INT NULL ,
  INDEX `fk_PAQUETE_has_CLIENTE_CLIENTE1` (`id_cliente` ASC) ,
  INDEX `fk_PAQUETE_has_CLIENTE_PAQUETE1` (`id_paquete` ASC) ,
  PRIMARY KEY (`id_compra`) ,
  CONSTRAINT `fk_PAQUETE_has_CLIENTE_PAQUETE1`
    FOREIGN KEY (`id_paquete` )
    REFERENCES `gimnasio`.`PAQUETE` (`id_paquete` )
    ON DELETE RESTRICT
    ON UPDATE CASCADE,
  CONSTRAINT `fk_PAQUETE_has_CLIENTE_CLIENTE1`
    FOREIGN KEY (`id_cliente` )
    REFERENCES `gimnasio`.`CLIENTE` (`id_cliente` )
    ON DELETE RESTRICT
    ON UPDATE CASCADE)
ENGINE = InnoDB
DEFAULT CHARACTER SET = utf8
COLLATE = utf8_spanish2_ci;


-- -----------------------------------------------------
-- Table `gimnasio`.`PAQUETE_EXTENDIDO`
-- -----------------------------------------------------
DROP TABLE IF EXISTS `gimnasio`.`PAQUETE_EXTENDIDO` ;

CREATE  TABLE IF NOT EXISTS `gimnasio`.`PAQUETE_EXTENDIDO` (
  `id_compra` INT NOT NULL ,
  `nueva_fecha` DATE NOT NULL ,
  `precio` INT NOT NULL ,
  INDEX `fk_PAQUETE_EXTENDIDO_COMPRA1` (`id_compra` ASC) ,
  CONSTRAINT `fk_PAQUETE_EXTENDIDO_COMPRA1`
    FOREIGN KEY (`id_compra` )
    REFERENCES `gimnasio`.`COMPRA` (`id_compra` )
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB
DEFAULT CHARACTER SET = utf8
COLLATE = utf8_spanish2_ci;


-- -----------------------------------------------------
-- Table `gimnasio`.`SERVICIO`
-- -----------------------------------------------------
DROP TABLE IF EXISTS `gimnasio`.`SERVICIO` ;

CREATE  TABLE IF NOT EXISTS `gimnasio`.`SERVICIO` (
  `id_servicio` INT UNSIGNED NOT NULL AUTO_INCREMENT ,
  `nombre` VARCHAR(30) NOT NULL ,
  PRIMARY KEY (`id_servicio`) )
ENGINE = InnoDB
DEFAULT CHARACTER SET = utf8
COLLATE = utf8_spanish2_ci;


-- -----------------------------------------------------
-- Table `gimnasio`.`HORARIO`
-- -----------------------------------------------------
DROP TABLE IF EXISTS `gimnasio`.`HORARIO` ;

CREATE  TABLE IF NOT EXISTS `gimnasio`.`HORARIO` (
  `id_horario` INT UNSIGNED NOT NULL AUTO_INCREMENT ,
  `dia` ENUM('lunes','martes','miercoles','jueves','viernes','sabado') NOT NULL ,
  `hora` TIME NOT NULL ,
  PRIMARY KEY (`id_horario`) )
ENGINE = InnoDB
DEFAULT CHARACTER SET = utf8
COLLATE = utf8_spanish2_ci;


-- -----------------------------------------------------
-- Table `gimnasio`.`SESION`
-- -----------------------------------------------------
DROP TABLE IF EXISTS `gimnasio`.`SESION` ;

CREATE  TABLE IF NOT EXISTS `gimnasio`.`SESION` (
  `id_sesion` INT UNSIGNED NOT NULL AUTO_INCREMENT ,
  `id_servicio` INT UNSIGNED NOT NULL ,
  `id_horario` INT UNSIGNED NOT NULL ,
  `id_empleado` INT UNSIGNED NULL ,
  `id_sala` INT UNSIGNED NOT NULL ,
  `fecha` DATE NULL ,
  PRIMARY KEY (`id_sesion`) ,
  INDEX `fk_SESION_SERVICIO1` (`id_servicio` ASC) ,
  INDEX `fk_SESION_HORARIO1` (`id_horario` ASC) ,
  INDEX `fk_SESION_INSTRUCTOR1` (`id_empleado` ASC) ,
  INDEX `fk_SESION_SALA1` (`id_sala` ASC) ,
  CONSTRAINT `fk_SESION_SERVICIO1`
    FOREIGN KEY (`id_servicio` )
    REFERENCES `gimnasio`.`SERVICIO` (`id_servicio` )
    ON DELETE RESTRICT
    ON UPDATE CASCADE,
  CONSTRAINT `fk_SESION_HORARIO1`
    FOREIGN KEY (`id_horario` )
    REFERENCES `gimnasio`.`HORARIO` (`id_horario` )
    ON DELETE RESTRICT
    ON UPDATE CASCADE,
  CONSTRAINT `fk_SESION_INSTRUCTOR1`
    FOREIGN KEY (`id_empleado` )
    REFERENCES `gimnasio`.`INSTRUCTOR` (`id_empleado` )
    ON DELETE RESTRICT
    ON UPDATE SET NULL,
  CONSTRAINT `fk_SESION_SALA1`
    FOREIGN KEY (`id_sala` )
    REFERENCES `gimnasio`.`SALA` (`id_sala` )
    ON DELETE RESTRICT
    ON UPDATE CASCADE)
ENGINE = InnoDB
DEFAULT CHARACTER SET = utf8
COLLATE = utf8_spanish2_ci;


-- -----------------------------------------------------
-- Table `gimnasio`.`ACCESO_SESION`
-- -----------------------------------------------------
DROP TABLE IF EXISTS `gimnasio`.`ACCESO_SESION` ;

CREATE  TABLE IF NOT EXISTS `gimnasio`.`ACCESO_SESION` (
  `id_sesion` INT UNSIGNED NOT NULL ,
  `id_cliente` INT UNSIGNED NOT NULL ,
  `id_compra` INT NOT NULL ,
  `hora_ingreso` TIME NOT NULL ,
  PRIMARY KEY (`id_sesion`, `id_cliente`) ,
  INDEX `fk_CLIENTE_has_SALA_CLIENTE1` (`id_cliente` ASC) ,
  INDEX `fk_ACCESO_SESION_SESION1` (`id_sesion` ASC) ,
  INDEX `fk_ACCESO_SESION_COMPRA1` (`id_compra` ASC) ,
  CONSTRAINT `fk_CLIENTE_has_SALA_CLIENTE1`
    FOREIGN KEY (`id_cliente` )
    REFERENCES `gimnasio`.`CLIENTE` (`id_cliente` )
    ON DELETE RESTRICT
    ON UPDATE CASCADE,
  CONSTRAINT `fk_ACCESO_SESION_SESION1`
    FOREIGN KEY (`id_sesion` )
    REFERENCES `gimnasio`.`SESION` (`id_sesion` )
    ON DELETE RESTRICT
    ON UPDATE CASCADE,
  CONSTRAINT `fk_ACCESO_SESION_COMPRA1`
    FOREIGN KEY (`id_compra` )
    REFERENCES `gimnasio`.`COMPRA` (`id_compra` )
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB
DEFAULT CHARACTER SET = utf8
COLLATE = utf8_spanish2_ci;


-- -----------------------------------------------------
-- Table `gimnasio`.`PERIODO`
-- -----------------------------------------------------
DROP TABLE IF EXISTS `gimnasio`.`PERIODO` ;

CREATE  TABLE IF NOT EXISTS `gimnasio`.`PERIODO` (
  `id_periodo` INT UNSIGNED NOT NULL AUTO_INCREMENT ,
  `fecha_inicio` DATE NOT NULL ,
  `fecha_fin` DATE NOT NULL ,
  PRIMARY KEY (`id_periodo`) )
ENGINE = InnoDB
DEFAULT CHARACTER SET = utf8
COLLATE = utf8_spanish2_ci;


-- -----------------------------------------------------
-- Table `gimnasio`.`EXTRA`
-- -----------------------------------------------------
DROP TABLE IF EXISTS `gimnasio`.`EXTRA` ;

CREATE  TABLE IF NOT EXISTS `gimnasio`.`EXTRA` (
  `id_descuento` INT UNSIGNED NOT NULL AUTO_INCREMENT ,
  `nombre` VARCHAR(20) NOT NULL ,
  PRIMARY KEY (`id_descuento`) )
ENGINE = InnoDB
DEFAULT CHARACTER SET = utf8
COLLATE = utf8_spanish2_ci;


-- -----------------------------------------------------
-- Table `gimnasio`.`SALARIO`
-- -----------------------------------------------------
DROP TABLE IF EXISTS `gimnasio`.`SALARIO` ;

CREATE  TABLE IF NOT EXISTS `gimnasio`.`SALARIO` (
  `id_empleado` INT UNSIGNED NOT NULL ,
  `id_periodo` INT UNSIGNED NOT NULL ,
  `basico` INT NOT NULL ,
  INDEX `fk_SALARIO_EMPLEADO1` (`id_empleado` ASC) ,
  CONSTRAINT `fk_SALARIO_PERIODO1`
    FOREIGN KEY (`id_periodo` )
    REFERENCES `gimnasio`.`PERIODO` (`id_periodo` )
    ON DELETE RESTRICT
    ON UPDATE CASCADE,
  CONSTRAINT `fk_SALARIO_EMPLEADO1`
    FOREIGN KEY (`id_empleado` )
    REFERENCES `gimnasio`.`EMPLEADO` (`id_empleado` )
    ON DELETE RESTRICT
    ON UPDATE CASCADE)
ENGINE = InnoDB
DEFAULT CHARACTER SET = utf8
COLLATE = utf8_spanish2_ci;


-- -----------------------------------------------------
-- Table `gimnasio`.`EXTRA_EMPLEADO`
-- -----------------------------------------------------
DROP TABLE IF EXISTS `gimnasio`.`EXTRA_EMPLEADO` ;

CREATE  TABLE IF NOT EXISTS `gimnasio`.`EXTRA_EMPLEADO` (
  `id_empleado` INT UNSIGNED NOT NULL ,
  `id_descuento` INT UNSIGNED NOT NULL ,
  `id_periodo` INT UNSIGNED NOT NULL ,
  `monto` INT NOT NULL ,
  `fecha` DATE NULL ,
  INDEX `fk_DESCUENTO_EMPLEADO_EMPLEADO1` (`id_empleado` ASC) ,
  INDEX `fk_DESCUENTO_EMPLEADO_DESCUENTO1` (`id_descuento` ASC) ,
  INDEX `fk_DESCUENTO_EMPLEADO_PERIODO1` (`id_periodo` ASC) ,
  CONSTRAINT `fk_DESCUENTO_EMPLEADO_EMPLEADO1`
    FOREIGN KEY (`id_empleado` )
    REFERENCES `gimnasio`.`EMPLEADO` (`id_empleado` )
    ON DELETE RESTRICT
    ON UPDATE CASCADE,
  CONSTRAINT `fk_DESCUENTO_EMPLEADO_DESCUENTO1`
    FOREIGN KEY (`id_descuento` )
    REFERENCES `gimnasio`.`EXTRA` (`id_descuento` )
    ON DELETE RESTRICT
    ON UPDATE CASCADE,
  CONSTRAINT `fk_DESCUENTO_EMPLEADO_PERIODO1`
    FOREIGN KEY (`id_periodo` )
    REFERENCES `gimnasio`.`PERIODO` (`id_periodo` )
    ON DELETE RESTRICT
    ON UPDATE CASCADE)
ENGINE = InnoDB
DEFAULT CHARACTER SET = utf8
COLLATE = utf8_spanish2_ci;


-- -----------------------------------------------------
-- Table `gimnasio`.`PAGO`
-- -----------------------------------------------------
DROP TABLE IF EXISTS `gimnasio`.`PAGO` ;

CREATE  TABLE IF NOT EXISTS `gimnasio`.`PAGO` (
  `id_empleado` INT UNSIGNED NOT NULL ,
  `id_periodo` INT UNSIGNED NOT NULL ,
  `total_ganado` INT NULL ,
  `liquido_pagable` INT NULL ,
  `fecha_emision` DATE NULL ,
  `fecha_cobro` DATE NULL ,
  INDEX `fk_PAGO_EMPLEADO1` (`id_empleado` ASC) ,
  INDEX `fk_PAGO_PERIODO1` (`id_periodo` ASC) ,
  CONSTRAINT `fk_PAGO_EMPLEADO1`
    FOREIGN KEY (`id_empleado` )
    REFERENCES `gimnasio`.`EMPLEADO` (`id_empleado` )
    ON DELETE RESTRICT
    ON UPDATE CASCADE,
  CONSTRAINT `fk_PAGO_PERIODO1`
    FOREIGN KEY (`id_periodo` )
    REFERENCES `gimnasio`.`PERIODO` (`id_periodo` )
    ON DELETE RESTRICT
    ON UPDATE CASCADE)
ENGINE = InnoDB
DEFAULT CHARACTER SET = utf8
COLLATE = utf8_spanish2_ci;



SET SQL_MODE=@OLD_SQL_MODE;
SET FOREIGN_KEY_CHECKS=@OLD_FOREIGN_KEY_CHECKS;
SET UNIQUE_CHECKS=@OLD_UNIQUE_CHECKS;
