-- MySQL Workbench Forward Engineering

SET @OLD_UNIQUE_CHECKS=@@UNIQUE_CHECKS, UNIQUE_CHECKS=0;
SET @OLD_FOREIGN_KEY_CHECKS=@@FOREIGN_KEY_CHECKS, FOREIGN_KEY_CHECKS=0;
SET @OLD_SQL_MODE=@@SQL_MODE, SQL_MODE='ONLY_FULL_GROUP_BY,STRICT_TRANS_TABLES,NO_ZERO_IN_DATE,NO_ZERO_DATE,ERROR_FOR_DIVISION_BY_ZERO,NO_ENGINE_SUBSTITUTION';

-- -----------------------------------------------------
-- Schema sge
-- -----------------------------------------------------
DROP SCHEMA IF EXISTS `sge` ;

-- -----------------------------------------------------
-- Schema sge
-- -----------------------------------------------------
CREATE SCHEMA IF NOT EXISTS `sge` ;
USE `sge` ;

-- -----------------------------------------------------
-- Table `sge`.`Turma`
-- -----------------------------------------------------
DROP TABLE IF EXISTS `sge`.`Turma` ;

CREATE TABLE IF NOT EXISTS `sge`.`Turma` (
  `idTurma` INT NULL,
  `Nome` VARCHAR(50) NOT NULL,
  `Ano` INT NULL,
  PRIMARY KEY (`idTurma`))
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `sge`.`Aluno`
-- -----------------------------------------------------
DROP TABLE IF EXISTS `sge`.`Aluno` ;

CREATE TABLE IF NOT EXISTS `sge`.`Aluno` (
  `idAluno` INT NOT NULL,
  `Dt_Nascimento` DATE NULL,
  `Endereço` VARCHAR(50) NULL,
  `E-mail` VARCHAR(50) NULL,
  `Nome` VARCHAR(50) NOT NULL,
  `idTurma` INT NULL,
  `Turma_idTurma` INT NOT NULL,
  PRIMARY KEY (`idAluno`, `Turma_idTurma`),
  INDEX `fk_Aluno_Turma1_idx` (`Turma_idTurma` ASC) VISIBLE,
  CONSTRAINT `fk_Aluno_Turma1`
    FOREIGN KEY (`Turma_idTurma`)
    REFERENCES `sge`.`Turma` (`idTurma`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `sge`.`Professor`
-- -----------------------------------------------------
DROP TABLE IF EXISTS `sge`.`Professor` ;

CREATE TABLE IF NOT EXISTS `sge`.`Professor` (
  `IdProfessor` INT NULL,
  `Especialização` VARCHAR(50) NULL,
  `Nome` VARCHAR(50) NOT NULL,
  `E-mail` VARCHAR(50) NULL,
  PRIMARY KEY (`IdProfessor`))
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `sge`.`Disciplina`
-- -----------------------------------------------------
DROP TABLE IF EXISTS `sge`.`Disciplina` ;

CREATE TABLE IF NOT EXISTS `sge`.`Disciplina` (
  `idDisciplina` INT NULL,
  `CodDisciplina` INT NULL,
  `CargaHoraria` INT NULL,
  `Nome` VARCHAR(50) NOT NULL,
  PRIMARY KEY (`idDisciplina`))
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `sge`.`Leciona`
-- -----------------------------------------------------
DROP TABLE IF EXISTS `sge`.`Leciona` ;

CREATE TABLE IF NOT EXISTS `sge`.`Leciona` (
  `Turma_idTurma` INT NOT NULL,
  `Professor_IdProfessor` INT NOT NULL,
  PRIMARY KEY (`Turma_idTurma`, `Professor_IdProfessor`),
  INDEX `fk_Turma_has_Professor_Professor1_idx` (`Professor_IdProfessor` ASC) VISIBLE,
  INDEX `fk_Turma_has_Professor_Turma1_idx` (`Turma_idTurma` ASC) VISIBLE,
  CONSTRAINT `fk_Turma_has_Professor_Turma1`
    FOREIGN KEY (`Turma_idTurma`)
    REFERENCES `sge`.`Turma` (`idTurma`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION,
  CONSTRAINT `fk_Turma_has_Professor_Professor1`
    FOREIGN KEY (`Professor_IdProfessor`)
    REFERENCES `sge`.`Professor` (`IdProfessor`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `sge`.`Ministra`
-- -----------------------------------------------------
DROP TABLE IF EXISTS `sge`.`Ministra` ;

CREATE TABLE IF NOT EXISTS `sge`.`Ministra` (
  `Professor_IdProfessor` INT NOT NULL,
  `Disciplina_idDisciplina` INT NOT NULL,
  PRIMARY KEY (`Professor_IdProfessor`, `Disciplina_idDisciplina`),
  INDEX `fk_Professor_has_Disciplina_Disciplina1_idx` (`Disciplina_idDisciplina` ASC) VISIBLE,
  INDEX `fk_Professor_has_Disciplina_Professor1_idx` (`Professor_IdProfessor` ASC) VISIBLE,
  CONSTRAINT `fk_Professor_has_Disciplina_Professor1`
    FOREIGN KEY (`Professor_IdProfessor`)
    REFERENCES `sge`.`Professor` (`IdProfessor`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION,
  CONSTRAINT `fk_Professor_has_Disciplina_Disciplina1`
    FOREIGN KEY (`Disciplina_idDisciplina`)
    REFERENCES `sge`.`Disciplina` (`idDisciplina`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `sge`.`Associada`
-- -----------------------------------------------------
DROP TABLE IF EXISTS `sge`.`Associada` ;

CREATE TABLE IF NOT EXISTS `sge`.`Associada` (
  `Turma_idTurma` INT NOT NULL,
  `Disciplina_idDisciplina` INT NOT NULL,
  PRIMARY KEY (`Turma_idTurma`, `Disciplina_idDisciplina`),
  INDEX `fk_Turma_has_Disciplina_Disciplina1_idx` (`Disciplina_idDisciplina` ASC) VISIBLE,
  INDEX `fk_Turma_has_Disciplina_Turma1_idx` (`Turma_idTurma` ASC) VISIBLE,
  CONSTRAINT `fk_Turma_has_Disciplina_Turma1`
    FOREIGN KEY (`Turma_idTurma`)
    REFERENCES `sge`.`Turma` (`idTurma`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION,
  CONSTRAINT `fk_Turma_has_Disciplina_Disciplina1`
    FOREIGN KEY (`Disciplina_idDisciplina`)
    REFERENCES `sge`.`Disciplina` (`idDisciplina`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB;


SET SQL_MODE=@OLD_SQL_MODE;
SET FOREIGN_KEY_CHECKS=@OLD_FOREIGN_KEY_CHECKS;
SET UNIQUE_CHECKS=@OLD_UNIQUE_CHECKS;
