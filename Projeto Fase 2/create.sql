SET @OLD_UNIQUE_CHECKS=@@UNIQUE_CHECKS, UNIQUE_CHECKS=0;
SET @OLD_FOREIGN_KEY_CHECKS=@@FOREIGN_KEY_CHECKS, FOREIGN_KEY_CHECKS=0;
SET @OLD_SQL_MODE=@@SQL_MODE, SQL_MODE='TRADITIONAL,ALLOW_INVALID_DATES';

CREATE SCHEMA IF NOT EXISTS `projeto` DEFAULT CHARACTER SET utf8 ;
USE `projeto` ;

-- -----------------------------------------------------
-- Table `projeto`.`eventos`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `projeto`.`eventos` (
  `Eve_nregisto` INT(11) NOT NULL AUTO_INCREMENT,
  `Eve_nome` VARCHAR(45) NOT NULL,
  `Eve_data` DATE NOT NULL,
  `Eve_local` VARCHAR(45) NOT NULL,
  PRIMARY KEY (`Eve_nregisto`),
  UNIQUE INDEX `Eve_nome_UNIQUE` (`Eve_nome` ASC))
ENGINE = InnoDB
DEFAULT CHARACTER SET = utf8;


-- -----------------------------------------------------
-- Table `projeto`.`atividades`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `projeto`.`atividades` (
  `Ati_nregisto` INT(11) NOT NULL AUTO_INCREMENT,
  `Ati_sala` VARCHAR(45) NOT NULL,
  `Ati_titulo` VARCHAR(45) NOT NULL,
  `Ati_começo` DATETIME NULL DEFAULT NULL,
  `Ati_final` DATETIME NULL DEFAULT NULL,
  `Ati_Eve_nregisto` INT(11) NOT NULL,
  `Ati_tipo` VARCHAR(45) NOT NULL,
  `Ati_tópicos` VARCHAR(100) NULL DEFAULT NULL,
  PRIMARY KEY (`Ati_nregisto`),
  UNIQUE INDEX `Ati_sala_UNIQUE` (`Ati_sala` ASC),
  INDEX `Ati_Eve_nregisto_idx` (`Ati_Eve_nregisto` ASC),
  CONSTRAINT `Ati_Eve_nregisto`
    FOREIGN KEY (`Ati_Eve_nregisto`)
    REFERENCES `projeto`.`eventos` (`Eve_nregisto`))
ENGINE = InnoDB
DEFAULT CHARACTER SET = utf8;


-- -----------------------------------------------------
-- Table `projeto`.`login`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `projeto`.`login` (
  `Log_nregisto` INT(11) NOT NULL AUTO_INCREMENT,
  `Log_nome` VARCHAR(45) NOT NULL,
  `Log_password` VARCHAR(45) NOT NULL,
  PRIMARY KEY (`Log_nregisto`),
  UNIQUE INDEX `Log_nome_UNIQUE` (`Log_nome` ASC))
ENGINE = InnoDB
DEFAULT CHARACTER SET = utf8;


-- -----------------------------------------------------
-- Table `projeto`.`participantes`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `projeto`.`participantes` (
  `Par_nregisto` INT(11) NOT NULL AUTO_INCREMENT,
  `Par_Log_nregisto` INT(11) NOT NULL,
  `Par_nome` VARCHAR(45) NOT NULL,
  `Par_idade` TINYINT(2) NULL DEFAULT NULL,
  `Par_pode_comentar` BIT(1) NULL DEFAULT NULL,
  `Par_contagem` INT(11) NULL DEFAULT NULL,
  PRIMARY KEY (`Par_nregisto`),
  UNIQUE INDEX `Par_Log_nregisto_UNIQUE` (`Par_Log_nregisto` ASC),
  CONSTRAINT `Par_Log_nregisto`
    FOREIGN KEY (`Par_Log_nregisto`)
    REFERENCES `projeto`.`login` (`Log_nregisto`))
ENGINE = InnoDB
DEFAULT CHARACTER SET = utf8;


-- -----------------------------------------------------
-- Table `projeto`.`avisos`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `projeto`.`avisos` (
  `aviso_id` INT(11) NOT NULL AUTO_INCREMENT,
  `aviso_Par_id` INT(11) NOT NULL,
  `aviso_mensagem` VARCHAR(200) NULL DEFAULT NULL,
  `aviso_data` DATETIME NULL DEFAULT NULL,
  PRIMARY KEY (`aviso_id`),
  INDEX `aviso_Par_id_idx` (`aviso_Par_id` ASC),
  CONSTRAINT `aviso_Par_id`
    FOREIGN KEY (`aviso_Par_id`)
    REFERENCES `projeto`.`participantes` (`Par_nregisto`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB
DEFAULT CHARACTER SET = utf8;


-- -----------------------------------------------------
-- Table `projeto`.`temas`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `projeto`.`temas` (
  `Tem_nregisto` INT(11) NOT NULL AUTO_INCREMENT,
  `Tem_nome` VARCHAR(45) NOT NULL,
  PRIMARY KEY (`Tem_nregisto`),
  UNIQUE INDEX `Tem_nome_UNIQUE` (`Tem_nome` ASC))
ENGINE = InnoDB
DEFAULT CHARACTER SET = utf8;


-- -----------------------------------------------------
-- Table `projeto`.`conteudos`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `projeto`.`conteudos` (
  `Con_Eve_nregisto` INT(11) NOT NULL,
  `Con_Tem_nregisto` INT(11) NOT NULL,
  PRIMARY KEY (`Con_Eve_nregisto`, `Con_Tem_nregisto`),
  INDEX `Con_Tem_nregisto_idx` (`Con_Tem_nregisto` ASC),
  CONSTRAINT `Con_Eve_nregisto`
    FOREIGN KEY (`Con_Eve_nregisto`)
    REFERENCES `projeto`.`eventos` (`Eve_nregisto`),
  CONSTRAINT `Con_Tem_nregisto`
    FOREIGN KEY (`Con_Tem_nregisto`)
    REFERENCES `projeto`.`temas` (`Tem_nregisto`))
ENGINE = InnoDB
DEFAULT CHARACTER SET = utf8;


-- -----------------------------------------------------
-- Table `projeto`.`inscritos`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `projeto`.`inscritos` (
  `Ins_Par_nregisto` INT(11) NOT NULL,
  `Ins_Ati_registo` INT(11) NOT NULL,
  `Ins_avaliação` INT(11) NULL DEFAULT NULL,
  `Ins_comentário` VARCHAR(50) NULL DEFAULT NULL,
  PRIMARY KEY (`Ins_Par_nregisto`, `Ins_Ati_registo`),
  INDEX `Ins_Ati_nregisto_idx` (`Ins_Ati_registo` ASC),
  CONSTRAINT `Ins_Ati_nregisto`
    FOREIGN KEY (`Ins_Ati_registo`)
    REFERENCES `projeto`.`atividades` (`Ati_nregisto`),
  CONSTRAINT `Ins_Par_nregisto`
    FOREIGN KEY (`Ins_Par_nregisto`)
    REFERENCES `projeto`.`participantes` (`Par_nregisto`))
ENGINE = InnoDB
DEFAULT CHARACTER SET = utf8;


-- -----------------------------------------------------
-- Table `projeto`.`oradores`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `projeto`.`oradores` (
  `Ora_nregisto` INT(11) NOT NULL AUTO_INCREMENT,
  `Ora_Log_nregisto` INT(11) NOT NULL,
  `Ora_nome` VARCHAR(45) NOT NULL,
  PRIMARY KEY (`Ora_nregisto`),
  UNIQUE INDEX `Ora_Log_nregisto_UNIQUE` (`Ora_Log_nregisto` ASC),
  CONSTRAINT `Ora_Log_nregisto`
    FOREIGN KEY (`Ora_Log_nregisto`)
    REFERENCES `projeto`.`login` (`Log_nregisto`))
ENGINE = InnoDB
DEFAULT CHARACTER SET = utf8;


-- -----------------------------------------------------
-- Table `projeto`.`organizadores`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `projeto`.`organizadores` (
  `Org_Ora_nregisto` INT(11) NOT NULL,
  `Org_Ati_nregisto` INT(11) NOT NULL,
  PRIMARY KEY (`Org_Ora_nregisto`, `Org_Ati_nregisto`),
  INDEX `Org_Ati_nregisto_idx` (`Org_Ati_nregisto` ASC),
  CONSTRAINT `Org_Ati_nregisto`
    FOREIGN KEY (`Org_Ati_nregisto`)
    REFERENCES `projeto`.`atividades` (`Ati_nregisto`),
  CONSTRAINT `Org_Ora_nregisto`
    FOREIGN KEY (`Org_Ora_nregisto`)
    REFERENCES `projeto`.`oradores` (`Ora_nregisto`))
ENGINE = InnoDB
DEFAULT CHARACTER SET = utf8;


-- -----------------------------------------------------
-- Table `projeto`.`patrocinadores`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `projeto`.`patrocinadores` (
  `Pat_nregisto` INT(11) NOT NULL AUTO_INCREMENT,
  `Pat_marca` VARCHAR(45) NOT NULL,
  PRIMARY KEY (`Pat_nregisto`),
  UNIQUE INDEX `Pat_marca_UNIQUE` (`Pat_marca` ASC))
ENGINE = InnoDB
DEFAULT CHARACTER SET = utf8;


-- -----------------------------------------------------
-- Table `projeto`.`patrocinios`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `projeto`.`patrocinios` (
  `Patr_Pat_nregisto` INT(11) NOT NULL,
  `Patr_Eve_nregisto` INT(11) NOT NULL,
  PRIMARY KEY (`Patr_Pat_nregisto`, `Patr_Eve_nregisto`),
  INDEX `Patr_Eve_nregisto_idx` (`Patr_Eve_nregisto` ASC),
  CONSTRAINT `Patr_Eve_nregisto`
    FOREIGN KEY (`Patr_Eve_nregisto`)
    REFERENCES `projeto`.`eventos` (`Eve_nregisto`),
  CONSTRAINT `Patr_Pat_nregisto`
    FOREIGN KEY (`Patr_Pat_nregisto`)
    REFERENCES `projeto`.`patrocinadores` (`Pat_nregisto`))
ENGINE = InnoDB
DEFAULT CHARACTER SET = utf8;


-- -----------------------------------------------------
-- Table `projeto`.`reserved_words`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `projeto`.`reserved_words` (
  `word` VARCHAR(50) NOT NULL,
  UNIQUE INDEX `word` (`word` ASC))
ENGINE = InnoDB
DEFAULT CHARACTER SET = utf8;


-- -----------------------------------------------------
-- Table `projeto`.`vencedores`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `projeto`.`vencedores` (
  `Ven_nregisto` INT(11) NOT NULL AUTO_INCREMENT,
  `Ven_Par_nregisto` INT(11) NULL DEFAULT NULL,
  `Ven_Ati_nregisto` INT(11) NULL DEFAULT NULL,
  PRIMARY KEY (`Ven_nregisto`),
  INDEX `Ven_Par_nregisto_idx` (`Ven_Par_nregisto` ASC),
  INDEX `Ven_Ati_nregisto_idx` (`Ven_Ati_nregisto` ASC),
  CONSTRAINT `Ven_Ati_nregisto`
    FOREIGN KEY (`Ven_Ati_nregisto`)
    REFERENCES `projeto`.`inscritos` (`Ins_Ati_registo`),
  CONSTRAINT `Ven_Par_nregisto`
    FOREIGN KEY (`Ven_Par_nregisto`)
    REFERENCES `projeto`.`inscritos` (`Ins_Par_nregisto`))
ENGINE = InnoDB
DEFAULT CHARACTER SET = utf8;


SET SQL_MODE=@OLD_SQL_MODE;
SET FOREIGN_KEY_CHECKS=@OLD_FOREIGN_KEY_CHECKS;
SET UNIQUE_CHECKS=@OLD_UNIQUE_CHECKS;
