    SET @OLD_UNIQUE_CHECKS=@@UNIQUE_CHECKS, UNIQUE_CHECKS=0;
    SET @OLD_FOREIGN_KEY_CHECKS=@@FOREIGN_KEY_CHECKS, FOREIGN_KEY_CHECKS=0;
    SET @OLD_SQL_MODE=@@SQL_MODE, SQL_MODE='TRADITIONAL,ALLOW_INVALID_DATES';

    DROP SCHEMA IF EXISTS `horario` ;
    CREATE SCHEMA IF NOT EXISTS `horario` DEFAULT CHARACTER SET latin1 ;
    USE `horario` ;

    -- -----------------------------------------------------
    -- Table `horario`.`grau`
    -- -----------------------------------------------------
    CREATE  TABLE IF NOT EXISTS `horario`.`modalidade` (
      `id` TINYINT(4) NOT NULL AUTO_INCREMENT ,
      `nome_modalidade` VARCHAR(50) NOT NULL ,
      `codigo` INT(11) NOT NULL ,
      `deletado_em` TIMESTAMP NULL DEFAULT NULL ,
      PRIMARY KEY (`id`) ,
      UNIQUE INDEX `codigo_UNIQUE` (`codigo` ASC) )
    ENGINE = InnoDB
    DEFAULT CHARACTER SET = latin1;


    -- -----------------------------------------------------
    -- Table `horario`.`area`
    -- -----------------------------------------------------
    CREATE  TABLE IF NOT EXISTS `horario`.`area` (
      `id` SMALLINT NOT NULL AUTO_INCREMENT ,
      `nome_area` VARCHAR(50) NOT NULL ,
      `codigo` CHAR(2) NOT NULL ,
      `deletado_em` TIMESTAMP NULL DEFAULT NULL ,
      PRIMARY KEY (`id`) )
    ENGINE = InnoDB;


    -- -----------------------------------------------------
-- Table `horario`.`pessoa`
-- -----------------------------------------------------
DROP TABLE IF EXISTS `horario`.`pessoa` ;

CREATE TABLE IF NOT EXISTS `horario`.`pessoa` (
  `id` INT NOT NULL AUTO_INCREMENT,
  `nome` VARCHAR(150) NOT NULL,
  `prontuario` CHAR(6) NOT NULL,
  `senha` CHAR(64) NOT NULL,
  `email` VARCHAR(100) NOT NULL,
  `deletado_em` TIMESTAMP NULL,
  PRIMARY KEY (`id`))
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `horario`.`docente`
-- -----------------------------------------------------
DROP TABLE IF EXISTS `horario`.`docente` ;

CREATE TABLE IF NOT EXISTS `horario`.`docente` (
  `id` INT NOT NULL AUTO_INCREMENT,
  `pessoa_id` INT NOT NULL,
  `area_id` SMALLINT NOT NULL,
  `nascimento` DATE NOT NULL,
  `ingresso_campus` DATE NOT NULL,
  `ingresso_ifsp` DATE NOT NULL,
  `regime` CHAR(1) NOT NULL,
  `deletado_em` TIMESTAMP NULL,
  PRIMARY KEY (`id`),
  INDEX `fk_docente_area1_idx` (`area_id` ASC),
  INDEX `fk_docente_pessoa1_idx` (`pessoa_id` ASC),
  CONSTRAINT `fk_docente_area1`
    FOREIGN KEY (`area_id`)
    REFERENCES `horario`.`area` (`id`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION,
  CONSTRAINT `fk_docente_pessoa1`
    FOREIGN KEY (`pessoa_id`)
    REFERENCES `horario`.`pessoa` (`id`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB;



    -- -----------------------------------------------------
    -- Table `horario`.`curso`
    -- -----------------------------------------------------
    CREATE  TABLE IF NOT EXISTS `horario`.`curso` (
      `id` SMALLINT(6) NOT NULL AUTO_INCREMENT ,
      `docente_id` INT NULL ,
      `modalidade_id` TINYINT(4) NOT NULL ,
      `codigo_curso` CHAR(5) NOT NULL ,
      `nome_curso` VARCHAR(75) NOT NULL ,
      `sigla_curso` CHAR(3) NOT NULL ,
      `qtd_semestre` TINYINT(2) NOT NULL ,
      `fechamento` CHAR(1) NOT NULL ,
      `deletado_em` TIMESTAMP NULL DEFAULT NULL ,
      PRIMARY KEY (`id`) ,
      INDEX `fk_curso_modalidade1_idx` (`modalidade_id` ASC) ,
      INDEX `fk_curso_docente1_idx` (`docente_id` ASC) ,
      CONSTRAINT `fk_curso_modalidade1`
        FOREIGN KEY (`modalidade_id` )
        REFERENCES `horario`.`modalidade` (`id` )
        ON DELETE CASCADE
        ON UPDATE CASCADE,
      CONSTRAINT `fk_curso_docente1`
        FOREIGN KEY (`docente_id` )
        REFERENCES `horario`.`docente` (`id` )
        ON DELETE NO ACTION
        ON UPDATE NO ACTION)
    ENGINE = InnoDB
    DEFAULT CHARACTER SET = latin1;


    -- -----------------------------------------------------
    -- Table `horario`.`tipo_sala`
    -- -----------------------------------------------------
    CREATE  TABLE IF NOT EXISTS `horario`.`tipo_sala` (
      `id` TINYINT(4) NOT NULL AUTO_INCREMENT ,
      `nome_tipo_sala` VARCHAR(30) NOT NULL ,
      `descricao_tipo_sala` VARCHAR(254) NOT NULL ,
      `deletado_em` TIMESTAMP NULL DEFAULT NULL ,
      PRIMARY KEY (`id`) )
    ENGINE = InnoDB
    DEFAULT CHARACTER SET = latin1;


    -- -----------------------------------------------------
    -- Table `horario`.`disciplina`
    -- -----------------------------------------------------
    CREATE  TABLE IF NOT EXISTS `horario`.`disciplina` (
      `id` SMALLINT(6) NOT NULL AUTO_INCREMENT ,
      `curso_id` SMALLINT(6) NOT NULL ,
      `tipo_sala_id` TINYINT(4) NOT NULL ,
      `nome_disciplina` VARCHAR(50) NOT NULL ,
      `modulo` TINYINT(2) NOT NULL,
      `sigla_disciplina` CHAR(5) NOT NULL ,
      `qtd_professor` TINYINT(1) NOT NULL ,
      `qtd_aulas` TINYINT(2) NOT NULL ,
      `deletado_em` TIMESTAMP NULL DEFAULT NULL ,
      PRIMARY KEY (`id`) ,
      INDEX `fk_disciplina_curso1_idx` (`curso_id` ASC) ,
      INDEX `fk_disciplina_tipo_sala` (`tipo_sala_id` ASC) ,
      CONSTRAINT `fk_disciplina_curso1`
        FOREIGN KEY (`curso_id` )
        REFERENCES `horario`.`curso` (`id` )
        ON DELETE CASCADE
        ON UPDATE CASCADE,
      CONSTRAINT `fk_disciplina_tipo_sala`
        FOREIGN KEY (`tipo_sala_id` )
        REFERENCES `horario`.`tipo_sala` (`id` ))
    ENGINE = InnoDB
    DEFAULT CHARACTER SET = latin1;


    -- -----------------------------------------------------
    -- Table `horario`.`turno`
    -- -----------------------------------------------------
    CREATE  TABLE IF NOT EXISTS `horario`.`turno` (
      `id` TINYINT(4) NOT NULL AUTO_INCREMENT ,
      `nome_turno` VARCHAR(25) NOT NULL ,
      `deletado_em` TIMESTAMP NULL DEFAULT NULL ,
      PRIMARY KEY (`id`) ,
      UNIQUE INDEX `nome_turno_UNIQUE` (`nome_turno` ASC) )
    ENGINE = InnoDB
    DEFAULT CHARACTER SET = latin1;


    -- -----------------------------------------------------
    -- Table `horario`.`horario`
    -- -----------------------------------------------------
    CREATE TABLE IF NOT EXISTS `horario`.`horario` (
      `id` TINYINT(4) NOT NULL AUTO_INCREMENT,
      `inicio` TIME NOT NULL,
      `fim` TIME NOT NULL,
      `deletado_em` TIMESTAMP NULL DEFAULT NULL,
      PRIMARY KEY (`id`))
    ENGINE = InnoDB
    AUTO_INCREMENT = 6
    DEFAULT CHARACTER SET = latin1;

    CREATE TABLE IF NOT EXISTS `horario`.`turno_horario` (
      `turno_id` TINYINT(4) NOT NULL,
      `horario_id` TINYINT(4) NOT NULL,
      PRIMARY KEY (`turno_id`, `horario_id`),
      INDEX `fk_turno_has_horario_horario1_idx` (`horario_id` ASC),
      INDEX `fk_turno_has_horario_turno1_idx` (`turno_id` ASC),
      CONSTRAINT `fk_turno_has_horario_turno1`
        FOREIGN KEY (`turno_id`)
        REFERENCES `horario`.`turno` (`id`)
        ON DELETE NO ACTION
        ON UPDATE NO ACTION,
      CONSTRAINT `fk_turno_has_horario_horario1`
        FOREIGN KEY (`horario_id`)
        REFERENCES `horario`.`horario` (`id`)
        ON DELETE NO ACTION
        ON UPDATE NO ACTION)
    ENGINE = InnoDB
    DEFAULT CHARACTER SET = latin1;

    -- -----------------------------------------------------
    -- Table `horario`.`tipo`
    -- -----------------------------------------------------
    CREATE  TABLE IF NOT EXISTS `horario`.`tipo` (
      `id` TINYINT NOT NULL AUTO_INCREMENT ,
      `nome` VARCHAR(25) NOT NULL ,
      `deletado_em` TIMESTAMP NULL ,
      PRIMARY KEY (`id`) )
    ENGINE = InnoDB;


    -- -----------------------------------------------------
    -- Table `horario`.`tipo_pessoa`
    -- -----------------------------------------------------
    CREATE  TABLE IF NOT EXISTS `horario`.`tipo_pessoa` (
      `tipo_id` TINYINT NOT NULL ,
      `pessoa_id` INT NOT NULL ,
      PRIMARY KEY (`tipo_id`, `pessoa_id`) ,
      INDEX `fk_tipo_has_pessoa_pessoa1_idx` (`pessoa_id` ASC) ,
      INDEX `fk_tipo_has_pessoa_tipo1_idx` (`tipo_id` ASC) ,
      CONSTRAINT `fk_tipo_has_pessoa_tipo1`
        FOREIGN KEY (`tipo_id` )
        REFERENCES `horario`.`tipo` (`id` )
        ON DELETE NO ACTION
        ON UPDATE NO ACTION,
      CONSTRAINT `fk_tipo_has_pessoa_pessoa1`
        FOREIGN KEY (`pessoa_id` )
        REFERENCES `horario`.`pessoa` (`id` )
        ON DELETE NO ACTION
        ON UPDATE NO ACTION)
    ENGINE = InnoDB;


    -- -----------------------------------------------------
    -- Table `horario`.`periodo`
    -- -----------------------------------------------------
    CREATE  TABLE IF NOT EXISTS `horario`.`periodo` (
      `id` INT NOT NULL AUTO_INCREMENT ,
      `nome` CHAR(6) NOT NULL ,
      `ativo` CHAR(1) NOT NULL DEFAULT 0,
      `deletado_em` TIMESTAMP NULL ,
      PRIMARY KEY (`id`) ,
      UNIQUE INDEX `nome_UNIQUE` (`nome` ASC) )
    ENGINE = InnoDB;

    -- -----------------------------------------------------
    -- Table `horario`.`fpa`
    -- -----------------------------------------------------
    CREATE  TABLE IF NOT EXISTS `horario`.`fpa` (
      `id` INT NOT NULL AUTO_INCREMENT ,
      `docente_id` INT NOT NULL ,
      `periodo_id` INT NOT NULL ,
      PRIMARY KEY (`id`) ,
      INDEX `fk_fpa_docente1_idx` (`docente_id` ASC) ,
      INDEX `fk_fpa_periodo1_idx` (`periodo_id` ASC) ,
      CONSTRAINT `fk_fpa_docente1`
        FOREIGN KEY (`docente_id` )
        REFERENCES `horario`.`docente` (`id` )
        ON DELETE NO ACTION
        ON UPDATE NO ACTION,
      CONSTRAINT `fk_fpa_periodo1`
        FOREIGN KEY (`periodo_id` )
        REFERENCES `horario`.`periodo` (`id` )
        ON DELETE NO ACTION
        ON UPDATE NO ACTION)
    ENGINE = InnoDB;


    -- -----------------------------------------------------
    -- Table `horario`.`turma`
    -- -----------------------------------------------------
    CREATE  TABLE IF NOT EXISTS `horario`.`turma` (
      `id` INT NOT NULL AUTO_INCREMENT,
      `disciplina_id` SMALLINT(6) NOT NULL ,
      `periodo_id` INT NOT NULL ,
      `turno_id` TINYINT(4) NOT NULL ,
      `qtd_alunos` INT NOT NULL ,
      `dp` TINYINT(1) NOT NULL ,
      `deletado_em` TIMESTAMP NULL DEFAULT NULL,
      PRIMARY KEY (`id`) ,
      INDEX `fk_disciplina_has_periodo_periodo1_idx` (`periodo_id` ASC) ,
      INDEX `fk_disciplina_has_periodo_disciplina1_idx` (`disciplina_id` ASC) ,
      INDEX `fk_disciplinas_oferecidas_turno1_idx` (`turno_id` ASC) ,
      CONSTRAINT `fk_disciplina_has_periodo_disciplina1`
        FOREIGN KEY (`disciplina_id` )
        REFERENCES `horario`.`disciplina` (`id` )
        ON DELETE NO ACTION
        ON UPDATE NO ACTION,
      CONSTRAINT `fk_disciplina_has_periodo_periodo1`
        FOREIGN KEY (`periodo_id` )
        REFERENCES `horario`.`periodo` (`id` )
        ON DELETE NO ACTION
        ON UPDATE NO ACTION,
      CONSTRAINT `fk_disciplinas_oferecidas_turno1`
        FOREIGN KEY (`turno_id` )
        REFERENCES `horario`.`turno` (`id` )
        ON DELETE NO ACTION
        ON UPDATE NO ACTION)
    ENGINE = InnoDB
    DEFAULT CHARACTER SET = latin1;


    -- -----------------------------------------------------
    -- Table `horario`.`disponibilidade`
    -- -----------------------------------------------------
    CREATE  TABLE IF NOT EXISTS `horario`.`disponibilidade` (
      `fpa_id` INT NOT NULL ,
      `horario_id` TINYINT(4) NOT NULL ,
	  `dia_semana` VARCHAR(10) NOT NULL,
      INDEX `fk_fpa_has_horario_horario1_idx` (`horario_id` ASC) ,
      INDEX `fk_fpa_has_horario_fpa1_idx` (`fpa_id` ASC) ,
      PRIMARY KEY (`fpa_id`, `horario_id`) ,
      CONSTRAINT `fk_fpa_has_horario_fpa1`
        FOREIGN KEY (`fpa_id` )
        REFERENCES `horario`.`fpa` (`id` )
        ON DELETE NO ACTION
        ON UPDATE NO ACTION,
      CONSTRAINT `fk_fpa_has_horario_horario1`
        FOREIGN KEY (`horario_id` )
        REFERENCES `horario`.`horario` (`id` )
        ON DELETE NO ACTION
        ON UPDATE NO ACTION)
    ENGINE = InnoDB;


    -- -----------------------------------------------------
    -- Table `horario`.`preferencia`
    -- -----------------------------------------------------
    CREATE  TABLE IF NOT EXISTS `horario`.`preferencia` (
      `fpa_id` INT NOT NULL ,
      `turma_id` INT NOT NULL ,
      `ordem` INT NOT NULL ,
      PRIMARY KEY (`fpa_id`, `turma_id`) ,
      INDEX `fk_disciplina_has_fpa_fpa1_idx` (`fpa_id` ASC) ,
      INDEX `fk_preferencias_turma1_idx` (`turma_id` ASC) ,
      CONSTRAINT `fk_disciplina_has_fpa_fpa1`
        FOREIGN KEY (`fpa_id` )
        REFERENCES `horario`.`fpa` (`id` )
        ON DELETE NO ACTION
        ON UPDATE NO ACTION,
      CONSTRAINT `fk_preferencias_turma1`
        FOREIGN KEY (`turma_id` )
        REFERENCES `horario`.`turma` (`id` )
        ON DELETE NO ACTION
        ON UPDATE NO ACTION)
    ENGINE = InnoDB
    DEFAULT CHARACTER SET = latin1;

    USE `horario` ;

    -- -----------------------------------------------------
    -- Stored Procedure responsável por ativar o periodo
    -- -----------------------------------------------------
    DROP PROCEDURE IF EXISTS ativa_periodo;
    DELIMITER //
    CREATE PROCEDURE IF NOT EXISTS ativa_periodo(idPeriodo INT)
    BEGIN
    	UPDATE periodo SET ativo = 0 WHERE id != idPeriodo;
    	UPDATE periodo SET ativo = 1 WHERE id = idPeriodo;
    END//
    DELIMITER ;


    SET SQL_MODE=@OLD_SQL_MODE;
    SET FOREIGN_KEY_CHECKS=@OLD_FOREIGN_KEY_CHECKS;
    SET UNIQUE_CHECKS=@OLD_UNIQUE_CHECKS;

    -- -----------------------------------------------------
    -- Inserção de dados
    -- -----------------------------------------------------

    INSERT INTO tipo(nome) VALUES ('Administrador'), ('CRA'), ('DAE'), ('Docente');

    INSERT INTO tipo_sala(nome_tipo_sala, descricao_tipo_sala) VALUES("Teorica", "Mesas e Cadeiras");
    INSERT INTO tipo_sala(nome_tipo_sala, descricao_tipo_sala) VALUES("Pratica", "Computadores");
    INSERT INTO tipo_sala(nome_tipo_sala, descricao_tipo_sala) VALUES("Hibrida", "Mesas, cadeiras e computadores");
    INSERT INTO tipo_sala(nome_tipo_sala, descricao_tipo_sala) VALUES("Auditorio", "Apresentacoes");
    INSERT INTO tipo_sala(nome_tipo_sala, descricao_tipo_sala) VALUES("VideoConferencia", "Videoconferencias ao vivo");

    INSERT INTO modalidade(nome_modalidade, codigo) VALUES("Tecnologia", "00001");
    INSERT INTO modalidade(nome_modalidade, codigo) VALUES("Bacharel", "00021");
    INSERT INTO modalidade(nome_modalidade, codigo) VALUES("Pos Graduação", "00231");
    INSERT INTO modalidade(nome_modalidade, codigo) VALUES("Mestrado", "001321");
    INSERT INTO modalidade(nome_modalidade, codigo) VALUES("Doutorado", "44121");

    INSERT INTO curso(modalidade_id, codigo_curso, nome_curso, sigla_curso, qtd_semestre, fechamento)
        VALUES(1, 111, "Análise e Desenvolvimento de Sistemas", "ADS", 6, "B");
    INSERT INTO curso(modalidade_id, codigo_curso, nome_curso, sigla_curso, qtd_semestre, fechamento)
        VALUES(2, 222, "Processos Gerenciais", "PRG", 8, "S");
    INSERT INTO curso(modalidade_id, codigo_curso, nome_curso, sigla_curso, qtd_semestre, fechamento)
        VALUES(3, 333, "Fisica", "FIS", 4, "S");
    INSERT INTO curso(modalidade_id, codigo_curso, nome_curso, sigla_curso, qtd_semestre, fechamento)
        VALUES(4, 444, "Computação Avançada", "CPA", 3, "B");
    INSERT INTO curso(modalidade_id, codigo_curso, nome_curso, sigla_curso, qtd_semestre, fechamento)
        VALUES(5, 544, "Cura do Cancer", "CDC", 8, "B");

    INSERT INTO disciplina(curso_id, tipo_sala_id, nome_disciplina, modulo, sigla_disciplina, qtd_professor, qtd_aulas)
        VALUES(1, 5, "Análise de Sistemas", 1, "ADS", 2, 4);
    INSERT INTO disciplina(curso_id, tipo_sala_id, nome_disciplina, modulo, sigla_disciplina, qtd_professor, qtd_aulas)
        VALUES(2, 4, "Matemática", 1, "MAT", 1, 6);
    INSERT INTO disciplina(curso_id, tipo_sala_id, nome_disciplina, modulo, sigla_disciplina, qtd_professor, qtd_aulas)
        VALUES(3, 3, "Fisica Avancada", 1, "FSA", 1, 8);
    INSERT INTO disciplina(curso_id, tipo_sala_id, nome_disciplina, modulo, sigla_disciplina, qtd_professor, qtd_aulas)
        VALUES(4, 2, "Hardware", 1, "HDW", 2, 2);
    INSERT INTO disciplina(curso_id, tipo_sala_id, nome_disciplina, modulo, sigla_disciplina, qtd_professor, qtd_aulas)
        VALUES(5, 1, "Medicina", 1, "MED", 2, 2);

    INSERT INTO turno(nome_turno) VALUES("Matutino");
    INSERT INTO turno(nome_turno) VALUES("Vespertino");
    INSERT INTO turno(nome_turno) VALUES("Noturno");
    INSERT INTO turno(nome_turno) VALUES("Integral");
    INSERT INTO turno(nome_turno) VALUES("Diário");

    INSERT INTO periodo(nome, ativo) VALUES ('2017-1', '0'), ('2017-2', '0'), ('2018-1', '1');

    INSERT INTO area(id, nome_area, codigo) VALUES(1, "Banco de dados", 01), (2, "Inteligência Artificial", 02), (3, "Redes de Computadores", 03);
