-- MySQL Workbench Forward Engineering

SET @OLD_UNIQUE_CHECKS=@@UNIQUE_CHECKS, UNIQUE_CHECKS=0;
SET @OLD_FOREIGN_KEY_CHECKS=@@FOREIGN_KEY_CHECKS, FOREIGN_KEY_CHECKS=0;
SET @OLD_SQL_MODE=@@SQL_MODE, SQL_MODE='TRADITIONAL,ALLOW_INVALID_DATES';

-- -----------------------------------------------------
-- Schema michadbpitz
-- -----------------------------------------------------
-- DB
DROP SCHEMA IF EXISTS `michadbpitz` ;

-- -----------------------------------------------------
-- Schema michadbpitz
--
-- DB
-- -----------------------------------------------------
CREATE SCHEMA IF NOT EXISTS `michadbpitz` DEFAULT CHARACTER SET utf8 COLLATE utf8_bin ;
USE `michadbpitz` ;

-- -----------------------------------------------------
-- Table `michadbpitz`.`droit`
-- -----------------------------------------------------
DROP TABLE IF EXISTS `michadbpitz`.`droit` ;

CREATE TABLE IF NOT EXISTS `michadbpitz`.`droit` (
  `iddroit` SMALLINT UNSIGNED NOT NULL AUTO_INCREMENT,
  `droitname` VARCHAR(60) NOT NULL COMMENT 'nom unique du droit',
  `droitdesc` VARCHAR(300) NULL COMMENT 'description non obligatoire du droit',
  PRIMARY KEY (`iddroit`))
ENGINE = InnoDB;

CREATE UNIQUE INDEX `droitname_UNIQUE` ON `michadbpitz`.`droit` (`droitname` ASC);


-- -----------------------------------------------------
-- Table `michadbpitz`.`utilisateur`
-- -----------------------------------------------------
DROP TABLE IF EXISTS `michadbpitz`.`utilisateur` ;

CREATE TABLE IF NOT EXISTS `michadbpitz`.`utilisateur` (
  `idutilisateur` INT UNSIGNED NOT NULL AUTO_INCREMENT,
  `thelogin` VARCHAR(60) NOT NULL COMMENT 'Login unique, mais CI (case insensitive)',
  `thepwd` VARCHAR(255) CHARACTER SET 'utf8' COLLATE 'utf8_bin' NOT NULL COMMENT 'case sensitive (fait la différence entre minuscules et mjuscules) utf8_bin\nContiendra le mot de passe crypté',
  `thename` VARCHAR(80) NOT NULL,
  `thesurname` VARCHAR(80) NOT NULL,
  `themail` VARCHAR(255) NOT NULL COMMENT 'adresse courriel de l\'utilisateur - Champs unique',
  `thedateinscription` DATETIME NULL DEFAULT CURRENT_TIMESTAMP,
  `theprivatekey` CHAR(128) NOT NULL COMMENT 'Clef privée qui ne servira que dans les échanges avec cet utilisateur (=128 caractères exactement) en minuscule\nOn la génèrera lors de l\'inscription.',
  `actif` TINYINT UNSIGNED NULL DEFAULT 0 COMMENT 'par défaut non actif: 0\nactif: 1\ndésactivé: 2\nbanni: 3',
  `droit_iddroit` SMALLINT UNSIGNED NOT NULL COMMENT 'clef étrangère venant de droit',
  PRIMARY KEY (`idutilisateur`),
  CONSTRAINT `fk_utilisateur_droit`
    FOREIGN KEY (`droit_iddroit`)
    REFERENCES `michadbpitz`.`droit` (`iddroit`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB;

CREATE UNIQUE INDEX `thelogin_UNIQUE` ON `michadbpitz`.`utilisateur` (`thelogin` ASC);

CREATE UNIQUE INDEX `themail_UNIQUE` ON `michadbpitz`.`utilisateur` (`themail` ASC);

CREATE INDEX `fk_utilisateur_droit_idx` ON `michadbpitz`.`utilisateur` (`droit_iddroit` ASC);


-- -----------------------------------------------------
-- Table `michadbpitz`.`thepage`
-- -----------------------------------------------------
DROP TABLE IF EXISTS `michadbpitz`.`thepage` ;

CREATE TABLE IF NOT EXISTS `michadbpitz`.`thepage` (
  `idthepage` INT UNSIGNED NOT NULL AUTO_INCREMENT,
  `theslug` VARCHAR(150) NOT NULL COMMENT 'titre sluggifié pour la réécriture de URL - champs unique',
  `thetitle` VARCHAR(180) NOT NULL,
  `thetext` TEXT NOT NULL,
  `thedate` DATETIME NULL DEFAULT CURRENT_TIMESTAMP,
  `actif` TINYINT UNSIGNED NULL DEFAULT 1 COMMENT '0 - à approuver\n1 - approuvé\n2 - attente de validation\n3 - attente de correction',
  `utilisateur_idutilisateur` INT UNSIGNED NOT NULL,
  PRIMARY KEY (`idthepage`),
  CONSTRAINT `fk_thepage_utilisateur1`
    FOREIGN KEY (`utilisateur_idutilisateur`)
    REFERENCES `michadbpitz`.`utilisateur` (`idutilisateur`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB;

CREATE UNIQUE INDEX `theslug_UNIQUE` ON `michadbpitz`.`thepage` (`theslug` ASC);

CREATE INDEX `fk_thepage_utilisateur1_idx` ON `michadbpitz`.`thepage` (`utilisateur_idutilisateur` ASC);


-- -----------------------------------------------------
-- Table `michadbpitz`.`rubrique`
-- -----------------------------------------------------
DROP TABLE IF EXISTS `michadbpitz`.`rubrique` ;

CREATE TABLE IF NOT EXISTS `michadbpitz`.`rubrique` (
  `idrubrique` SMALLINT UNSIGNED NOT NULL AUTO_INCREMENT,
  `rubriqueslug` VARCHAR(100) NOT NULL COMMENT 'Champs unique pour écriture URL',
  `rubriquetitre` VARCHAR(100) NOT NULL,
  `rubriquedesc` VARCHAR(500) NULL,
  `rubriqueordre` SMALLINT UNSIGNED NOT NULL DEFAULT 0 COMMENT '0 : racine du site\nautre numérique: id du parent de la rubrique',
  PRIMARY KEY (`idrubrique`))
ENGINE = InnoDB;

CREATE UNIQUE INDEX `rubriqueslug_UNIQUE` ON `michadbpitz`.`rubrique` (`rubriqueslug` ASC);


-- -----------------------------------------------------
-- Table `michadbpitz`.`thepage_has_rubrique`
-- -----------------------------------------------------
DROP TABLE IF EXISTS `michadbpitz`.`thepage_has_rubrique` ;

CREATE TABLE IF NOT EXISTS `michadbpitz`.`thepage_has_rubrique` (
  `thepage_idthepage` INT UNSIGNED NOT NULL,
  `rubrique_idrubrique` SMALLINT UNSIGNED NOT NULL,
  PRIMARY KEY (`thepage_idthepage`, `rubrique_idrubrique`),
  CONSTRAINT `fk_thepage_has_rubrique_thepage1`
    FOREIGN KEY (`thepage_idthepage`)
    REFERENCES `michadbpitz`.`thepage` (`idthepage`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION,
  CONSTRAINT `fk_thepage_has_rubrique_rubrique1`
    FOREIGN KEY (`rubrique_idrubrique`)
    REFERENCES `michadbpitz`.`rubrique` (`idrubrique`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB;

CREATE INDEX `fk_thepage_has_rubrique_rubrique1_idx` ON `michadbpitz`.`thepage_has_rubrique` (`rubrique_idrubrique` ASC);

CREATE INDEX `fk_thepage_has_rubrique_thepage1_idx` ON `michadbpitz`.`thepage_has_rubrique` (`thepage_idthepage` ASC);


-- -----------------------------------------------------
-- Table `michadbpitz`.`commentaire`
-- -----------------------------------------------------
DROP TABLE IF EXISTS `michadbpitz`.`commentaire` ;

CREATE TABLE IF NOT EXISTS `michadbpitz`.`commentaire` (
  `idcommentaire` BIGINT UNSIGNED NOT NULL AUTO_INCREMENT,
  `commenttitre` VARCHAR(100) NOT NULL,
  `commenttext` TEXT NOT NULL,
  `commentdate` DATETIME NULL DEFAULT CURRENT_TIMESTAMP,
  `actif` TINYINT NULL DEFAULT 0 COMMENT '0 : non validé\n1 : validé\n2 : supprimé',
  PRIMARY KEY (`idcommentaire`))
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `michadbpitz`.`commentaire_has_utilisateur`
-- -----------------------------------------------------
DROP TABLE IF EXISTS `michadbpitz`.`commentaire_has_utilisateur` ;

CREATE TABLE IF NOT EXISTS `michadbpitz`.`commentaire_has_utilisateur` (
  `commentaire_idcommentaire` BIGINT UNSIGNED NOT NULL,
  `utilisateur_idutilisateur` INT UNSIGNED NOT NULL,
  PRIMARY KEY (`commentaire_idcommentaire`, `utilisateur_idutilisateur`),
  CONSTRAINT `fk_commentaire_has_utilisateur_commentaire1`
    FOREIGN KEY (`commentaire_idcommentaire`)
    REFERENCES `michadbpitz`.`commentaire` (`idcommentaire`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION,
  CONSTRAINT `fk_commentaire_has_utilisateur_utilisateur1`
    FOREIGN KEY (`utilisateur_idutilisateur`)
    REFERENCES `michadbpitz`.`utilisateur` (`idutilisateur`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB;

CREATE INDEX `fk_commentaire_has_utilisateur_utilisateur1_idx` ON `michadbpitz`.`commentaire_has_utilisateur` (`utilisateur_idutilisateur` ASC);

CREATE INDEX `fk_commentaire_has_utilisateur_commentaire1_idx` ON `michadbpitz`.`commentaire_has_utilisateur` (`commentaire_idcommentaire` ASC);


-- -----------------------------------------------------
-- Table `michadbpitz`.`commentaire_has_thepage`
-- -----------------------------------------------------
DROP TABLE IF EXISTS `michadbpitz`.`commentaire_has_thepage` ;

CREATE TABLE IF NOT EXISTS `michadbpitz`.`commentaire_has_thepage` (
  `commentaire_idcommentaire` BIGINT UNSIGNED NOT NULL,
  `thepage_idthepage` INT UNSIGNED NOT NULL,
  PRIMARY KEY (`commentaire_idcommentaire`, `thepage_idthepage`),
  CONSTRAINT `fk_commentaire_has_thepage_commentaire1`
    FOREIGN KEY (`commentaire_idcommentaire`)
    REFERENCES `michadbpitz`.`commentaire` (`idcommentaire`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION,
  CONSTRAINT `fk_commentaire_has_thepage_thepage1`
    FOREIGN KEY (`thepage_idthepage`)
    REFERENCES `michadbpitz`.`thepage` (`idthepage`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB;

CREATE INDEX `fk_commentaire_has_thepage_thepage1_idx` ON `michadbpitz`.`commentaire_has_thepage` (`thepage_idthepage` ASC);

CREATE INDEX `fk_commentaire_has_thepage_commentaire1_idx` ON `michadbpitz`.`commentaire_has_thepage` (`commentaire_idcommentaire` ASC);


-- -----------------------------------------------------
-- Table `michadbpitz`.`fichier`
-- -----------------------------------------------------
DROP TABLE IF EXISTS `michadbpitz`.`fichier` ;

CREATE TABLE IF NOT EXISTS `michadbpitz`.`fichier` (
  `idfichier` BIGINT UNSIGNED NOT NULL AUTO_INCREMENT,
  `fichiername` VARCHAR(30) NOT NULL,
  `fichiertype` VARCHAR(10) NOT NULL COMMENT 'images jpg, gif, etc... fichiers pdf, doc, etc...',
  `fichierurl` VARCHAR(250) NULL,
  `fichierdate` DATETIME NULL DEFAULT CURRENT_TIMESTAMP,
  `fichieractif` TINYINT UNSIGNED NULL DEFAULT 1 COMMENT '0 : non validé\n1 : validé\n2 : invalidé',
  PRIMARY KEY (`idfichier`))
ENGINE = InnoDB;

CREATE UNIQUE INDEX `fichiername_UNIQUE` ON `michadbpitz`.`fichier` (`fichiername` ASC);


-- -----------------------------------------------------
-- Table `michadbpitz`.`fichier_has_thepage`
-- -----------------------------------------------------
DROP TABLE IF EXISTS `michadbpitz`.`fichier_has_thepage` ;

CREATE TABLE IF NOT EXISTS `michadbpitz`.`fichier_has_thepage` (
  `fichier_idfichier` BIGINT UNSIGNED NOT NULL,
  `thepage_idthepage` INT UNSIGNED NOT NULL,
  PRIMARY KEY (`fichier_idfichier`, `thepage_idthepage`),
  CONSTRAINT `fk_fichier_has_thepage_fichier1`
    FOREIGN KEY (`fichier_idfichier`)
    REFERENCES `michadbpitz`.`fichier` (`idfichier`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION,
  CONSTRAINT `fk_fichier_has_thepage_thepage1`
    FOREIGN KEY (`thepage_idthepage`)
    REFERENCES `michadbpitz`.`thepage` (`idthepage`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB;

CREATE INDEX `fk_fichier_has_thepage_thepage1_idx` ON `michadbpitz`.`fichier_has_thepage` (`thepage_idthepage` ASC);

CREATE INDEX `fk_fichier_has_thepage_fichier1_idx` ON `michadbpitz`.`fichier_has_thepage` (`fichier_idfichier` ASC);


-- -----------------------------------------------------
-- Table `michadbpitz`.`fichier_has_commentaire`
-- -----------------------------------------------------
DROP TABLE IF EXISTS `michadbpitz`.`fichier_has_commentaire` ;

CREATE TABLE IF NOT EXISTS `michadbpitz`.`fichier_has_commentaire` (
  `fichier_idfichier` BIGINT UNSIGNED NOT NULL,
  `commentaire_idcommentaire` BIGINT UNSIGNED NOT NULL,
  PRIMARY KEY (`fichier_idfichier`, `commentaire_idcommentaire`),
  CONSTRAINT `fk_fichier_has_commentaire_fichier1`
    FOREIGN KEY (`fichier_idfichier`)
    REFERENCES `michadbpitz`.`fichier` (`idfichier`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION,
  CONSTRAINT `fk_fichier_has_commentaire_commentaire1`
    FOREIGN KEY (`commentaire_idcommentaire`)
    REFERENCES `michadbpitz`.`commentaire` (`idcommentaire`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB;

CREATE INDEX `fk_fichier_has_commentaire_commentaire1_idx` ON `michadbpitz`.`fichier_has_commentaire` (`commentaire_idcommentaire` ASC);

CREATE INDEX `fk_fichier_has_commentaire_fichier1_idx` ON `michadbpitz`.`fichier_has_commentaire` (`fichier_idfichier` ASC);


-- -----------------------------------------------------
-- Table `michadbpitz`.`fichier_has_utilisateur`
-- -----------------------------------------------------
DROP TABLE IF EXISTS `michadbpitz`.`fichier_has_utilisateur` ;

CREATE TABLE IF NOT EXISTS `michadbpitz`.`fichier_has_utilisateur` (
  `fichier_idfichier` BIGINT UNSIGNED NOT NULL,
  `utilisateur_idutilisateur` INT UNSIGNED NOT NULL,
  PRIMARY KEY (`fichier_idfichier`, `utilisateur_idutilisateur`),
  CONSTRAINT `fk_fichier_has_utilisateur_fichier1`
    FOREIGN KEY (`fichier_idfichier`)
    REFERENCES `michadbpitz`.`fichier` (`idfichier`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION,
  CONSTRAINT `fk_fichier_has_utilisateur_utilisateur1`
    FOREIGN KEY (`utilisateur_idutilisateur`)
    REFERENCES `michadbpitz`.`utilisateur` (`idutilisateur`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB;

CREATE INDEX `fk_fichier_has_utilisateur_utilisateur1_idx` ON `michadbpitz`.`fichier_has_utilisateur` (`utilisateur_idutilisateur` ASC);

CREATE INDEX `fk_fichier_has_utilisateur_fichier1_idx` ON `michadbpitz`.`fichier_has_utilisateur` (`fichier_idfichier` ASC);


SET SQL_MODE=@OLD_SQL_MODE;
SET FOREIGN_KEY_CHECKS=@OLD_FOREIGN_KEY_CHECKS;
SET UNIQUE_CHECKS=@OLD_UNIQUE_CHECKS;
