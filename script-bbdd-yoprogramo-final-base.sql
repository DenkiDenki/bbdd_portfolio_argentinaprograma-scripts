-- MySQL Workbench Forward Engineering

SET @OLD_UNIQUE_CHECKS=@@UNIQUE_CHECKS, UNIQUE_CHECKS=0;
SET @OLD_FOREIGN_KEY_CHECKS=@@FOREIGN_KEY_CHECKS, FOREIGN_KEY_CHECKS=0;
SET @OLD_SQL_MODE=@@SQL_MODE, SQL_MODE='ONLY_FULL_GROUP_BY,STRICT_TRANS_TABLES,NO_ZERO_IN_DATE,NO_ZERO_DATE,ERROR_FOR_DIVISION_BY_ZERO,NO_ENGINE_SUBSTITUTION';

-- -----------------------------------------------------
-- Schema portfolio
-- -----------------------------------------------------

-- -----------------------------------------------------
-- Schema portfolio
-- -----------------------------------------------------
CREATE SCHEMA IF NOT EXISTS `portfolio` DEFAULT CHARACTER SET utf8 ;
USE `portfolio` ;

-- -----------------------------------------------------
-- Table `portfolio`.`persona`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `portfolio`.`persona` (
  `persona_id` INT NOT NULL,
  `nombre` VARCHAR(45) NULL,
  `apellido` VARCHAR(45) NULL,
  `telefono` VARCHAR(20) NULL,
  `correo` VARCHAR(50) NULL,
  `sobre_mi` VARCHAR(300) NULL,
  `url_bio_img` VARCHAR(100) NULL,
  PRIMARY KEY (`persona_id`))
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `portfolio`.`tipo_empleo`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `portfolio`.`tipo_empleo` (
  `tipo_empleo_id` INT NOT NULL,
  `nombre_tipo` VARCHAR(45) NOT NULL,
  PRIMARY KEY (`tipo_empleo_id`),
  UNIQUE INDEX `tipo_empleo_id_UNIQUE` (`tipo_empleo_id` ASC) )
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `portfolio`.`experiencia_laboral`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `portfolio`.`experiencia_laboral` (
  `exp_id` INT NOT NULL,
  `nombre_empresa` VARCHAR(45) NULL,
  `esTrabajoActual` TINYINT(1) NULL,
  `fecha_inicio` DATE NULL,
  `fecha_fin` DATE NULL,
  `logros_descripcion` VARCHAR(300) NULL,
  `persona_id` INT NOT NULL,
  `tipo_empleo_id` INT NOT NULL,
  `titulo_exp` VARCHAR(50) NOT NULL,
  PRIMARY KEY (`exp_id`),
  INDEX `fk_experiencia_laboral_persona_idx` (`persona_id` ASC),
  INDEX `fk_experiencia_laboral_tipo_empleo1_idx` (`tipo_empleo_id` ASC),
  UNIQUE INDEX `exp_id_UNIQUE` (`exp_id` ASC),
  CONSTRAINT `fk_experiencia_laboral_persona`
    FOREIGN KEY (`persona_id`)
    REFERENCES `portfolio`.`persona` (`persona_id`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION,
  CONSTRAINT `fk_experiencia_laboral_tipo_empleo1`
    FOREIGN KEY (`tipo_empleo_id`)
    REFERENCES `portfolio`.`tipo_empleo` (`tipo_empleo_id`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `portfolio`.`educacion`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `portfolio`.`educacion` (
  `educacion_titulio` VARCHAR(45) NULL,
  `educacion_descripcion` VARCHAR(45) NULL,
  `edu_fecha_inicio` DATETIME NULL,
  `edu_fecha_final` DATETIME NULL,
  `en_curso` TINYINT(1) NULL,
  `persona_id` INT NOT NULL,
  INDEX `fk_educacion_persona1_idx` (`persona_id` ASC),
  UNIQUE INDEX `persona_id_UNIQUE` (`persona_id` ASC),
  CONSTRAINT `fk_educacion_persona1`
    FOREIGN KEY (`persona_id`)
    REFERENCES `portfolio`.`persona` (`persona_id`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `portfolio`.`proyecto`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `portfolio`.`proyecto` (
  `idproyecto` INT NOT NULL,
  `proyecto_titulo` VARCHAR(45) NULL,
  `proyecto_descripcion` VARCHAR(300) NOT NULL,
  `link_demo` VARCHAR(300) NULL,
  `link_repo` VARCHAR(300) NULL,
  `persona_id` INT NOT NULL,
  PRIMARY KEY (`idproyecto`),
  INDEX `fk_proyecto_persona1_idx` (`persona_id` ASC),
  CONSTRAINT `fk_proyecto_persona1`
    FOREIGN KEY (`persona_id`)
    REFERENCES `portfolio`.`persona` (`persona_id`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `portfolio`.`colaboradores`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `portfolio`.`colaboradores` (
  `colaborador_nombre` VARCHAR(50) NULL,
  `colaborador_comentario` VARCHAR(300) NULL,
  `proyecto_idproyecto` INT NOT NULL,
  INDEX `fk_colaboradores_proyecto1_idx` (`proyecto_idproyecto` ASC),
  UNIQUE INDEX `proyecto_idproyecto_UNIQUE` (`proyecto_idproyecto` ASC),
  PRIMARY KEY (`proyecto_idproyecto`),
  CONSTRAINT `fk_colaboradores_proyecto1`
    FOREIGN KEY (`proyecto_idproyecto`)
    REFERENCES `portfolio`.`proyecto` (`idproyecto`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `portfolio`.`tecnologia`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `portfolio`.`tecnologia` (
  `nombre_tec` VARCHAR(50) NULL,
  `tec_descripcion` VARCHAR(300) NULL,
  `proyecto_idproyecto` INT NOT NULL,
  PRIMARY KEY (`proyecto_idproyecto`))
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `portfolio`.`proyecto_has_tecnologia`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `portfolio`.`proyecto_has_tecnologia` (
  `proyecto_idproyecto` INT NOT NULL,
  `tecnologia_proyecto_idproyecto` INT NOT NULL,
  PRIMARY KEY (`proyecto_idproyecto`, `tecnologia_proyecto_idproyecto`),
  INDEX `fk_proyecto_has_tecnologia_tecnologia1_idx` (`tecnologia_proyecto_idproyecto` ASC),
  INDEX `fk_proyecto_has_tecnologia_proyecto1_idx` (`proyecto_idproyecto` ASC),
  CONSTRAINT `fk_proyecto_has_tecnologia_proyecto1`
    FOREIGN KEY (`proyecto_idproyecto`)
    REFERENCES `portfolio`.`proyecto` (`idproyecto`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION,
  CONSTRAINT `fk_proyecto_has_tecnologia_tecnologia1`
    FOREIGN KEY (`tecnologia_proyecto_idproyecto`)
    REFERENCES `portfolio`.`tecnologia` (`proyecto_idproyecto`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB;


SET SQL_MODE=@OLD_SQL_MODE;
SET FOREIGN_KEY_CHECKS=@OLD_FOREIGN_KEY_CHECKS;
SET UNIQUE_CHECKS=@OLD_UNIQUE_CHECKS;
