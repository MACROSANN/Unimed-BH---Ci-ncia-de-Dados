-- MySQL Script generated by MySQL Workbench
-- Mon Nov 21 22:15:19 2022
-- Model: New Model    Version: 1.0
-- MySQL Workbench Forward Engineering

SET @OLD_UNIQUE_CHECKS=@@UNIQUE_CHECKS, UNIQUE_CHECKS=0;
SET @OLD_FOREIGN_KEY_CHECKS=@@FOREIGN_KEY_CHECKS, FOREIGN_KEY_CHECKS=0;
SET @OLD_SQL_MODE=@@SQL_MODE, SQL_MODE='ONLY_FULL_GROUP_BY,STRICT_TRANS_TABLES,NO_ZERO_IN_DATE,NO_ZERO_DATE,ERROR_FOR_DIVISION_BY_ZERO,NO_ENGINE_SUBSTITUTION';

-- -----------------------------------------------------
-- Schema Oficina
-- -----------------------------------------------------
DROP SCHEMA IF EXISTS `Oficina` ;

-- -----------------------------------------------------
-- Schema Oficina
-- -----------------------------------------------------
CREATE SCHEMA IF NOT EXISTS `Oficina` DEFAULT CHARACTER SET utf8mb4 ;
USE `Oficina` ;

-- -----------------------------------------------------
-- Table `Oficina`.`Clientes`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `Oficina`.`Clientes` (
  `idClientes` INT NOT NULL AUTO_INCREMENT,
  `Nome` VARCHAR(45) NULL,
  `Endereço` VARCHAR(45) NULL,
  `Identificacao` VARCHAR(45) NULL,
  `Pessoa Fisica` TINYINT NOT NULL,
  PRIMARY KEY (`idClientes`))
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `Oficina`.`Veiculos`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `Oficina`.`Veiculos` (
  `idVeiculos` INT NOT NULL AUTO_INCREMENT,
  `Placa` VARCHAR(6) NULL,
  `Modelo` VARCHAR(45) NULL,
  `Ano` YEAR NULL,
  `Clientes_idClientes` INT NOT NULL,
  PRIMARY KEY (`idVeiculos`, `Clientes_idClientes`),
  INDEX `fk_Veículos_Clientes_idx` (`Clientes_idClientes` ASC) VISIBLE,
  CONSTRAINT `fk_Veículos_Clientes`
    FOREIGN KEY (`Clientes_idClientes`)
    REFERENCES `Oficina`.`Clientes` (`idClientes`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `Oficina`.`Equipes`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `Oficina`.`Equipes` (
  `idEquipe` INT NOT NULL AUTO_INCREMENT,
  `Descricao` VARCHAR(45) NULL,
  PRIMARY KEY (`idEquipe`))
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `Oficina`.`Ordem de Servico`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `Oficina`.`Ordem de Servico` (
  `idOrdem de Servico` INT NOT NULL AUTO_INCREMENT,
  `Data de Emissao` DATETIME(6) NULL,
  `Tipo de OS` VARCHAR(45) NULL,
  `Valor Total` FLOAT NULL,
  `Equipe_idEquipes` INT NOT NULL,
  `Prazo de entrega` INT NULL,
  `Conclusao` DATE NULL,
  `Status` VARCHAR(45) NULL,
  `Autorizado` TINYINT NULL,
  PRIMARY KEY (`idOrdem de Servico`, `Equipe_idEquipes`),
  INDEX `fk_Ordem de Serviço_Equipes1_idx` (`Equipe_idEquipes` ASC) VISIBLE,
  CONSTRAINT `fk_Ordem de Serviço_Equipes1`
    FOREIGN KEY (`Equipe_idEquipes`)
    REFERENCES `Oficina`.`Equipes` (`idEquipe`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `Oficina`.`Veiculos designado a Equipes`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `Oficina`.`Veiculos designado a Equipes` (
  `Veiculos_idVeículos` INT NOT NULL,
  `Equipes_idEquipes` INT NOT NULL,
  PRIMARY KEY (`Veiculos_idVeículos`, `Equipes_idEquipes`),
  INDEX `fk_Veículos_has_Equipes_Equipes1_idx` (`Equipes_idEquipes` ASC) VISIBLE,
  INDEX `fk_Veículos_has_Equipes_Veículos1_idx` (`Veiculos_idVeículos` ASC) VISIBLE,
  CONSTRAINT `fk_Veículos_has_Equipes_Veículos1`
    FOREIGN KEY (`Veiculos_idVeículos`)
    REFERENCES `Oficina`.`Veiculos` (`idVeiculos`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION,
  CONSTRAINT `fk_Veículos_has_Equipes_Equipes1`
    FOREIGN KEY (`Equipes_idEquipes`)
    REFERENCES `Oficina`.`Equipes` (`idEquipe`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `Oficina`.`Servicos`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `Oficina`.`Servicos` (
  `idServicos` INT NOT NULL AUTO_INCREMENT,
  `Descricao` VARCHAR(45) NULL,
  `Valor` FLOAT NULL,
  PRIMARY KEY (`idServicos`))
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `Oficina`.`Pecas`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `Oficina`.`Pecas` (
  `idPecas` INT NOT NULL AUTO_INCREMENT,
  `Descricao` VARCHAR(45) NULL,
  `Valor` FLOAT NULL,
  PRIMARY KEY (`idPecas`))
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `Oficina`.`Servicos da Ordem de Serviço`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `Oficina`.`Servicos da Ordem de Serviço` (
  `Servicos_idServicos` INT NOT NULL,
  `Ordem de Servico_idOrdem de Servico` INT NOT NULL,
  PRIMARY KEY (`Servicos_idServicos`, `Ordem de Servico_idOrdem de Servico`),
  INDEX `fk_Mão de Obra_has_Ordem de Serviço_Ordem de Serviço1_idx` (`Ordem de Servico_idOrdem de Servico` ASC) VISIBLE,
  INDEX `fk_Mão de Obra_has_Ordem de Serviço_Mão de Obra1_idx` (`Servicos_idServicos` ASC) VISIBLE,
  CONSTRAINT `fk_Mão de Obra_has_Ordem de Serviço_Mão de Obra1`
    FOREIGN KEY (`Servicos_idServicos`)
    REFERENCES `Oficina`.`Servicos` (`idServicos`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION,
  CONSTRAINT `fk_Mão de Obra_has_Ordem de Serviço_Ordem de Serviço1`
    FOREIGN KEY (`Ordem de Servico_idOrdem de Servico`)
    REFERENCES `Oficina`.`Ordem de Servico` (`idOrdem de Servico`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `Oficina`.`Pecas da Ordem de Servico`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `Oficina`.`Pecas da Ordem de Servico` (
  `Pecas_idPecas` INT NOT NULL,
  `Ordem de Servico_idOrdem de Servico` INT NOT NULL,
  PRIMARY KEY (`Pecas_idPecas`, `Ordem de Servico_idOrdem de Servico`),
  INDEX `fk_Peças_has_Ordem de Serviço_Ordem de Serviço1_idx` (`Ordem de Servico_idOrdem de Servico` ASC) VISIBLE,
  INDEX `fk_Peças_has_Ordem de Serviço_Peças1_idx` (`Pecas_idPecas` ASC) VISIBLE,
  CONSTRAINT `fk_Peças_has_Ordem de Serviço_Peças1`
    FOREIGN KEY (`Pecas_idPecas`)
    REFERENCES `Oficina`.`Pecas` (`idPecas`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION,
  CONSTRAINT `fk_Peças_has_Ordem de Serviço_Ordem de Serviço1`
    FOREIGN KEY (`Ordem de Servico_idOrdem de Servico`)
    REFERENCES `Oficina`.`Ordem de Servico` (`idOrdem de Servico`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `Oficina`.`Mecanico`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `Oficina`.`Mecanico` (
  `idMecanico` INT NOT NULL AUTO_INCREMENT,
  `Codigo` INT NULL,
  `Nome` VARCHAR(45) NULL,
  `Endereco` VARCHAR(45) NULL,
  `Especialidade` VARCHAR(45) NULL,
  `Equipes_idEquipes` INT NOT NULL,
  PRIMARY KEY (`idMecanico`, `Equipes_idEquipes`),
  INDEX `fk_Mecânico_Equipes1_idx` (`Equipes_idEquipes` ASC) VISIBLE,
  CONSTRAINT `fk_Mecânico_Equipes1`
    FOREIGN KEY (`Equipes_idEquipes`)
    REFERENCES `Oficina`.`Equipes` (`idEquipe`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB;


SET SQL_MODE=@OLD_SQL_MODE;
SET FOREIGN_KEY_CHECKS=@OLD_FOREIGN_KEY_CHECKS;
SET UNIQUE_CHECKS=@OLD_UNIQUE_CHECKS;