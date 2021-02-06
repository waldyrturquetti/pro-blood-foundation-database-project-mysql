-- phpMyAdmin SQL Dump
-- version 4.8.5
-- https://www.phpmyadmin.net/
--
-- Host: 127.0.0.1
-- Generation Time: 16-Set-2020 às 02:34
-- Versão do servidor: 10.1.38-MariaDB
-- versão do PHP: 7.3.2

SET SQL_MODE = "NO_AUTO_VALUE_ON_ZERO";
SET AUTOCOMMIT = 0;
START TRANSACTION;
SET time_zone = "+00:00";


/*!40101 SET @OLD_CHARACTER_SET_CLIENT=@@CHARACTER_SET_CLIENT */;
/*!40101 SET @OLD_CHARACTER_SET_RESULTS=@@CHARACTER_SET_RESULTS */;
/*!40101 SET @OLD_COLLATION_CONNECTION=@@COLLATION_CONNECTION */;
/*!40101 SET NAMES utf8mb4 */;

--
-- Database: `fundacao_prosangue`
--

DELIMITER $$
--
-- Procedures
--
CREATE DEFINER=`root`@`localhost` PROCEDURE `SP_ALTERAAVALIACAO` (IN `PCODIGO` INTEGER, `PDOADOR` INTEGER, `PDATAAVALIACAO` DATETIME, `PRESULTADOGERAL` BOOL, OUT `MENSAGEM` VARCHAR(100))  BEGIN
IF (NOT EXISTS(SELECT IDAVALIACAO FROM AVALIACAO
WHERE IDAVALIACAO <> PCODIGO AND
      PDATAAVALIACAO = DATAAVALIACAO AND
      IDDOADOR = PDOADOR )) THEN
BEGIN
UPDATE AVALIACAO
SET IDDOADOR = PDOADOR,
DATAAVALIACAO = PDATAAVALIACAO,
RESULTADOGERAL = PRESULTADOGERAL 
WHERE IDAVALIACAO = PCODIGO;

SET MENSAGEM = 'Operação realizada com sucesso!';
END;
ELSE
SET MENSAGEM = 'Candidato já fez avaliação nessa data e horário já cadastrados, alteração não realizada';
END IF;
END$$

CREATE DEFINER=`root`@`localhost` PROCEDURE `SP_ALTERACONSULTA` (IN `PIDCONSULTA` INTEGER, `PIDMEDICO` INTEGER, `PIDDOACAO` INTEGER, `PDATACONSULTA` DATETIME, OUT `MENSAGEM` VARCHAR(150))  BEGIN
IF(NOT EXISTS(SELECT IDCONSULTA 
FROM CONSULTA 
WHERE PIDCONSULTA<>IDCONSULTA AND ( (PIDMEDICO=IDMEDICO AND PDATACONSULTA=DATACONSULTA) OR (PIDDOACAO=IDDOACAO AND PDATACONSULTA=DATACONSULTA) ) )) THEN
BEGIN 
UPDATE CONSULTA 
SET IDDOACAO=PIDDOACAO,
    IDMEDICO=PIDMEDICO,
    DATACONSULTA=PDATACONSULTA 
    WHERE IDCONSULTA=PIDCONSULTA;

SET MENSAGEM='Data da consulta alterada!';
END;
ELSE
SET MENSAGEM='Ja existe uma consulta com esse medico marcada ou uma consulta para essa doacao para essa data,operação cancelada.';
END IF;
END$$

CREATE DEFINER=`root`@`localhost` PROCEDURE `SP_ALTERADOACAO` (IN `PCODIGO` INTEGER, `PDOADOR` INTEGER, `PDATA` DATETIME, `PQTDCOLETADA` DECIMAL(5,2), OUT `MENSAGEM` VARCHAR(100))  BEGIN
IF (NOT EXISTS(SELECT IDDOADOR FROM DOACAO
WHERE IDDOACAO <> PCODIGO AND
      DATADOACAO = PDATA AND
      IDDOADOR = PDOADOR AND QTDCOLETADA = PQTDCOLETADA)) THEN
BEGIN
UPDATE DOACAO
SET DATADOACAO = PDATA, IDDOADOR = PDOADOR, 
QTDCOLETADA = PQTDCOLETADA  
WHERE IDDOACAO = PCODIGO;

SET MENSAGEM = 'Operação realizada com sucesso!';
END;
ELSE
SET MENSAGEM = 'Doador já realizou uma doação nessa data e horário, alteração não realizada';
END IF;
END$$

CREATE DEFINER=`root`@`localhost` PROCEDURE `SP_ALTERADOADOR` (IN `PCODIGO` INTEGER, IN `PNOME` VARCHAR(150), `PNOMEPAI` VARCHAR(150), `PNOMEMAE` VARCHAR(150), `PDATANASCIMENTO` DATE, `PSEXO` CHAR(1), `PRG` CHAR(9), `PRUA` VARCHAR(150), `PBAIRRO` VARCHAR(150), `PCIDADE` VARCHAR(150), `PESTADO` CHAR(2), `PNUMERORESIDENCIA` VARCHAR(10), `PCEP` CHAR(9), OUT `MENSAGEM` VARCHAR(100))  BEGIN
IF (NOT EXISTS (SELECT IDDOADOR
        FROM DOADOR
WHERE IDDOADOR <> PCODIGO AND RG = PRG)) THEN
BEGIN
UPDATE DOADOR
SET NOME = PNOME,
NOMEPAI = PNOMEPAI,
NOMEMAE = PNOMEMAE,
DATANASCIMENTO = PDATANASCIMENTO,
SEXO = PSEXO,
RG = PRG,
RUA = PRUA,
BAIRRO = PBAIRRO,
CIDADE = PCIDADE,
ESTADO = PESTADO,
NUMERORESIDENCIAL = PNUMERORESIDENCIA,
CEP = PCEP
WHERE IDDoador = PCODIGO;

SET MENSAGEM = 'Operação realizada com sucesso!';
END;
ELSE
SET MENSAGEM = 'RG incorreto, operação não realizada!';
END IF;
END$$

CREATE DEFINER=`root`@`localhost` PROCEDURE `SP_ALTERAEXAME` (IN `PCODIGO` INTEGER, IN `PPERGUNTA` VARCHAR(300), IN `PNVLREFHEMOGLOBINA` DECIMAL(5,2), OUT `MENSAGEM` VARCHAR(100))  BEGIN
IF ( ((NOT EXISTS(SELECT IDEXAMES 
FROM EXAMES WHERE IDEXAMES <> PCODIGO AND UPPER(PERGUNTA) = UPPER(PPERGUNTA) )) AND PNVLREFHEMOGLOBINA IS NULL)  OR   

((NOT EXISTS(SELECT IDEXAMES 
FROM EXAMES)) AND PPERGUNTA IS NULL) ) THEN

BEGIN
UPDATE EXAMES
SET PERGUNTA = PPERGUNTA,
NVLREFHEMOGLOBINA = PNVLREFHEMOGLOBINA 
WHERE IDEXAMES = PCODIGO;


SET MENSAGEM = 'Operação realizada com sucesso!';
END;
ELSE
SET MENSAGEM = 'Informação de exame já existente, operação cancelada!';
END IF;

END$$

CREATE DEFINER=`root`@`localhost` PROCEDURE `SP_ALTERAEXAMESANGUE` (IN `PCODEXAMESANGUE` INTEGER, `PCODDOACAO` INTEGER, `PCODTESTESANGUE` INTEGER, `PRESULTADO` VARCHAR(150), `PDATA` DATETIME, OUT `MENSAGEM` VARCHAR(100))  BEGIN
IF( NOT EXISTS(SELECT IDEXAMESANGUE
FROM EXAMESANGUE
WHERE IDEXAMESANGUE <> PCODEXAMESANGUE AND IDDOACAO = PCODDOACAO AND IDTESTESANGUE = PCODTESTESANGUE
AND RESULTADO = PRESULTADO AND PDATA = DATAEXAMESANGUE)) THEN


BEGIN

UPDATE EXAMESANGUE
SET IDDOACAO = PCODDOACAO,
IDTESTESANGUE = PCODTESTESANGUE,
RESULTADO = PRESULTADO,
DATAEXAMESANGUE = PDATA 
WHERE IDEXAMESANGUE = PCODEXAMESANGUE;


SET MENSAGEM = 'Operação realizada com sucesso!';
END;
ELSE
SET MENSAGEM = 'Informação de exame de sangue já existente, operação cancelada!';
END IF;

END$$

CREATE DEFINER=`root`@`localhost` PROCEDURE `SP_ALTERAMEDICO` (IN `PNOME` VARCHAR(150), IN `PCODIGO` INTEGER, IN `PCRM` CHAR(6), IN `PESTADOCRM` CHAR(2), OUT `MENSAGEM` VARCHAR(100))  BEGIN
IF (NOT EXISTS (SELECT IDMEDICO
        FROM MEDICO
WHERE IDMEDICO <> PCODIGO AND CRM = PCRM AND PESTADOCRM = ESTADOCRM)) THEN
BEGIN
UPDATE MEDICO
SET NOME = PNOME,
CRM = PCRM,
ESTADOCRM = PESTADOCRM
WHERE IDMEDICO = PCODIGO;

SET MENSAGEM = 'Operação realizada com sucesso!';
END;
ELSE
SET MENSAGEM = 'CRM incorreto, operação não realizada!';
END IF;
END$$

CREATE DEFINER=`root`@`localhost` PROCEDURE `SP_ALTERATESTESANGUE` (IN `PCODIGO` INTEGER, `PNOME` VARCHAR(150), `PVALORREF` DECIMAL(5,2), `PTIPOSANGUINEO` VARCHAR(2), `PFATORRH` CHAR(1), `PANTICORPOS` VARCHAR(150), OUT `MENSAGEM` VARCHAR(100))  BEGIN
IF ( ((NOT EXISTS(SELECT IDTESTESANGUE 
FROM TESTESANGUE WHERE IDTESTESANGUE <> PCODIGO AND UPPER(NOME) = UPPER(PNOME) )) AND PTIPOSANGUINEO IS NULL AND PFATORRH IS NULL AND PANTICORPOS IS NULL)  OR   
((NOT EXISTS(SELECT IDTESTESANGUE 
FROM TESTESANGUE WHERE IDTESTESANGUE <> PCODIGO AND 
TIPOSANGUINEO = PTIPOSANGUINEO AND FATORRH = PFATORRH AND 
ANTICORPOS = PANTICORPOS)) AND PNOME IS NULL AND PVALORREF IS NULL) ) THEN

BEGIN
UPDATE TESTESANGUE
SET NOME = PNOME,
VALORREF = PVALORREF,
TIPOSANGUINEO = PTIPOSANGUINEO,
FATORRH = PFATORRH,
ANTICORPOS = PANTICORPOS
WHERE IDTESTESANGUE = PCODIGO;


SET MENSAGEM = 'Operação realizada com sucesso!';
END;
ELSE
SET MENSAGEM = 'Informação de Teste de sangue já existente e/ou Dados inseridos de forma incorreta , operação cancelada!';
END IF;

END$$

CREATE DEFINER=`root`@`localhost` PROCEDURE `SP_INSEREAVALIACAO` (IN `PCODIGO` INTEGER, `PDATAAVALIACAO` DATETIME, `PRESULTADOGERAL` BOOL, OUT `MENSAGEM` VARCHAR(100))  BEGIN
IF(NOT EXISTS(SELECT IDAVALIACAO FROM  AVALIACAO
WHERE CAST(DATAAVALIACAO AS DATE) = CAST(PDATAAVALIACAO AS DATE) AND
IDDOADOR = PCODIGO )) THEN

BEGIN

INSERT INTO AVALIACAO (IDDOADOR, DATAAVALIACAO, RESULTADOGERAL)
VALUES (PCODIGO, PDATAAVALIACAO, PRESULTADOGERAL);

SET MENSAGEM = 'Operação realizada com sucesso!';
END;
ELSE

SET MENSAGEM = 'Candidato já fez uma avalição no dia, operação cancelada!';
END IF;

END$$

CREATE DEFINER=`root`@`localhost` PROCEDURE `SP_INSERECONSULTA` (IN `PCODIGO` INTEGER, `PDATA` DATETIME, `PCODIGO2` INTEGER, `PCODIGO3` INTEGER, `PCODIGO4` INTEGER, OUT `MENSAGEM` VARCHAR(100))  BEGIN
IF(NOT EXISTS(SELECT IDCONSULTA
FROM CONSULTA
WHERE (PCODIGO=IDMEDICO AND PDATA=DATACONSULTA) OR
PCODIGO3 = IDDOACAO AND PDATA = DATACONSULTA )) THEN
BEGIN
INSERT INTO CONSULTA (IDMEDICO,DATACONSULTA,IDEXAMESANGUE,IDDOACAO,IDTESTESANGUE)
VALUES (PCODIGO,PDATA,PCODIGO2,PCODIGO3,PCODIGO4);

SET MENSAGEM = 'Consulta agendada com sucesso!';
END;
ELSE
SET MENSAGEM = 'Ja existe uma consulta agendada para essa doação, operação cancelada!';
END IF;

END$$

CREATE DEFINER=`root`@`localhost` PROCEDURE `SP_INSEREDOACAO` (IN `PCODIGO` INTEGER, `PDATADOACAO` DATETIME, `PQTDCOLETADA` DECIMAL(5,2), OUT `MENSAGEM` VARCHAR(100))  BEGIN
DECLARE AUX1 SMALLINT;
SET AUX1 = (SELECT (DATEDIFF(CURDATE(), MAX( CAST(D.DATADOACAO AS DATE) ))) AS ULTDOACAO
FROM DOADOR AS DR, DOACAO AS D
WHERE  PCODIGO = D.IDDOADOR);

IF((( AUX1 > 90 AND (SELECT SEXO FROM  DOADOR WHERE IDDOADOR = PCODIGO) = 'M') OR 
( AUX1 > 120 AND  (SELECT SEXO FROM  DOADOR WHERE IDDOADOR = PCODIGO) = 'F') OR AUX1 IS NULL) AND (SELECT RESULTADOGERAL FROM AVALIACAO
WHERE IDDOADOR = PCODIGO AND DATAAVALIACAO = 
(SELECT MAX(DATAAVALIACAO) FROM AVALIACAO WHERE IDDOADOR = PCODIGO)) IS TRUE)  THEN

BEGIN

INSERT INTO DOACAO (IDDOADOR, DATADOACAO, QTDCOLETADA)
VALUES (PCODIGO, PDATADOACAO, PQTDCOLETADA);

SET MENSAGEM = 'Operação realizada com sucesso!';
END;
ELSE
SET MENSAGEM = 'Doador não compriu os requisitos necessários para doar, operação cancelada!';
END IF;

END$$

CREATE DEFINER=`root`@`localhost` PROCEDURE `SP_INSEREDOADOR` (IN `PNOME` VARCHAR(150), `PNOMEPAI` VARCHAR(150), `PNOMEMAE` VARCHAR(150), `PDATANASCIMENTO` DATE, `PSEXO` CHAR(1), `PRG` CHAR(9), `PRUA` VARCHAR(150), `PBAIRRO` VARCHAR(150), `PCIDADE` VARCHAR(150), `PESTADO` CHAR(2), `PNUMERORESIDENCIA` VARCHAR(10), `PCEP` CHAR(9), OUT `MENSAGEM` VARCHAR(100))  BEGIN
IF(NOT EXISTS(SELECT RG
FROM DOADOR
WHERE PRG = RG)) THEN
BEGIN
INSERT INTO DOADOR (NOME, NOMEPAI, NOMEMAE, DATANASCIMENTO, SEXO, RG, RUA, BAIRRO, CIDADE, ESTADO, NUMERORESIDENCIAL, CEP)
VALUES (PNOME, PNOMEPAI, PNOMEMAE, PDATANASCIMENTO, PSEXO, PRG, PRUA, PBAIRRO, PCIDADE, PESTADO, PNUMERORESIDENCIA, PCEP);

SET MENSAGEM = 'Candidato inserido no Banco de Dados, Operação realizada com sucesso!';
END;
ELSE

SET MENSAGEM = 'Candidato existente no Banco de Dados, operação cancelada!';

END IF;

END$$

CREATE DEFINER=`root`@`localhost` PROCEDURE `SP_INSEREEXAMES` (IN `PPERGUNTA` VARCHAR(300), `PNVLREFHEMOGLOBINA` DECIMAL(5,2), OUT `MENSAGEM` VARCHAR(100))  BEGIN
IF ( NOT EXISTS(SELECT IDEXAMES 
FROM EXAMES WHERE UPPER(PERGUNTA) = UPPER(PPERGUNTA) OR NVLREFHEMOGLOBINA = PNVLREFHEMOGLOBINA)) THEN
BEGIN
INSERT INTO EXAMES (PERGUNTA, NVLREFHEMOGLOBINA)
VALUES (PPERGUNTA, PNVLREFHEMOGLOBINA);

SET MENSAGEM = 'Operação realizada com sucesso!';
END;
ELSE
SET MENSAGEM = 'Informação de exame já existente, operação cancelada!';
END IF;

END$$

CREATE DEFINER=`root`@`localhost` PROCEDURE `SP_INSEREEXAMESANGUE` (IN `PCODIGO1` INTEGER, `PCODIGO2` INTEGER, `PRESULTADO` VARCHAR(150), `PDATA` DATETIME, OUT `MENSAGEM` VARCHAR(100))  BEGIN
IF(NOT EXISTS(SELECT IDEXAMESANGUE
FROM EXAMESANGUE
WHERE PCODIGO1=IDDOACAO AND PCODIGO2=IDTESTESANGUE)) THEN
BEGIN
INSERT INTO EXAMESANGUE (IDDOACAO,IDTESTESANGUE,RESULTADO,DATAEXAMESANGUE)
VALUES (PCODIGO1,PCODIGO2,PRESULTADO,PDATA);

SET MENSAGEM = 'Exame de sangue armazenado com sucesso!';
END;
ELSE
SET MENSAGEM = 'Ja existe um exame de sangue armazenado para essa doação, operação cancelada!';
END IF;

END$$

CREATE DEFINER=`root`@`localhost` PROCEDURE `SP_INSEREMEDICO` (IN `PNOME` VARCHAR(150), IN `PCODIGO` CHAR(6), IN `PESTADOCRM` CHAR(2), OUT `MENSAGEM` VARCHAR(100))  BEGIN
IF(NOT EXISTS(SELECT IDMEDICO FROM MEDICO WHERE NOME = PNOME AND CRM = PCODIGO AND ESTADOCRM = PESTADOCRM)) THEN
BEGIN
INSERT INTO MEDICO (NOME,CRM,ESTADOCRM)
VALUES (PNOME,PCODIGO,PESTADOCRM);

SET MENSAGEM = 'Operação realizada com sucesso!';
END;
ELSE
SET MENSAGEM = 'Medico existente, operação cancelada!';
END IF;

END$$

CREATE DEFINER=`root`@`localhost` PROCEDURE `SP_INSERIRCANDEXAME` (IN `PCODIGO` INTEGER, `PCODIGO2` INTEGER, `PRESULTADO` VARCHAR(300), `PDATA` DATETIME, OUT `MENSAGEM` VARCHAR(100))  BEGIN
IF(NOT EXISTS(SELECT IDEXAMES,IDAVALIACAO
FROM CANDEXAME
WHERE PCODIGO=IDEXAMES AND PCODIGO2=IDAVALIACAO)) THEN
BEGIN
INSERT INTO CANDEXAME (IDEXAMES,IDAVALIACAO,RESULTADO,DATAEXAME)
VALUES (PCODIGO,PCODIGO2,PRESULTADO,PDATA);

SET MENSAGEM = 'Resposta do exame inserida com sucesso!';
END;
ELSE
SET MENSAGEM = 'Ja existe um resultado da avaliacao cadastrado nesse exame, operação cancelada!';
END IF;

END$$

CREATE DEFINER=`root`@`localhost` PROCEDURE `SP_INSERIRTESTESANGUE` (IN `PNOME` VARCHAR(150), `PVALORREF` DECIMAL(5,2), `PTIPOSANGUINEO` VARCHAR(2), `PFATORRH` CHAR(1), `PANTICORPOS` VARCHAR(150), OUT `MENSAGEM` VARCHAR(100))  BEGIN
IF( (PNOME IS NULL AND PVALORREF IS NULL AND NOT EXISTS(SELECT IDTESTESANGUE 
FROM TESTESANGUE
WHERE PTIPOSANGUINEO=TIPOSANGUINEO AND PFATORRH=FATORRH AND PANTICORPOS=ANTICORPOS))
 OR 
( PTIPOSANGUINEO IS NULL AND PFATORRH IS NULL AND PANTICORPOS IS NULL AND NOT EXISTS(SELECT IDTESTESANGUE 
FROM TESTESANGUE
WHERE PNOME = NOME)) ) THEN


BEGIN
INSERT INTO TESTESANGUE (NOME,VALORREF,TIPOSANGUINEO,FATORRH,ANTICORPOS)
VALUES (PNOME,PVALORREF,PTIPOSANGUINEO,PFATORRH,PANTICORPOS);

SET MENSAGEM = 'Teste de sangue inserido com sucesso!';
END;
ELSE
SET MENSAGEM = 'Ja existe um teste de sangue com esses dados e/ou Dados inseridos de forma incorreta , operação cancelada!';
END IF;

END$$

DELIMITER ;

-- --------------------------------------------------------

--
-- Estrutura da tabela `avaliacao`
--

CREATE TABLE `avaliacao` (
  `IDAvaliacao` int(11) NOT NULL,
  `IDDoador` int(11) DEFAULT NULL,
  `DataAvaliacao` datetime NOT NULL,
  `ResultadoGeral` tinyint(1) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=latin1;

--
-- Extraindo dados da tabela `avaliacao`
--

INSERT INTO `avaliacao` (`IDAvaliacao`, `IDDoador`, `DataAvaliacao`, `ResultadoGeral`) VALUES
(9, 1, '2019-11-27 15:07:30', 1),
(10, 4, '2019-11-30 13:49:43', 1),
(11, 3, '2019-11-30 13:49:48', 1),
(12, 2, '2019-11-30 13:50:04', 0);

-- --------------------------------------------------------

--
-- Estrutura da tabela `candexame`
--

CREATE TABLE `candexame` (
  `IDExames` int(11) NOT NULL,
  `IDAvaliacao` int(11) NOT NULL,
  `Resultado` varchar(300) NOT NULL,
  `DataExame` datetime NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=latin1;

--
-- Extraindo dados da tabela `candexame`
--

INSERT INTO `candexame` (`IDExames`, `IDAvaliacao`, `Resultado`, `DataExame`) VALUES
(4, 10, 'NÃO', '2019-11-30 13:54:19');

-- --------------------------------------------------------

--
-- Estrutura da tabela `consulta`
--

CREATE TABLE `consulta` (
  `IDConsulta` int(11) NOT NULL,
  `IDMedico` int(11) NOT NULL,
  `IDExameSangue` int(11) NOT NULL,
  `IDDoacao` int(11) NOT NULL,
  `IDTesteSangue` int(11) NOT NULL,
  `DataConsulta` datetime NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=latin1;

--
-- Extraindo dados da tabela `consulta`
--

INSERT INTO `consulta` (`IDConsulta`, `IDMedico`, `IDExameSangue`, `IDDoacao`, `IDTesteSangue`, `DataConsulta`) VALUES
(3, 3, 2, 2, 4, '2019-11-30 11:31:29'),
(2, 1, 2, 2, 4, '2019-11-30 14:25:41'),
(1, 1, 2, 2, 4, '2019-12-01 13:49:00');

-- --------------------------------------------------------

--
-- Stand-in structure for view `count_tiposanguneo`
-- (See below for the actual view)
--
CREATE TABLE `count_tiposanguneo` (
`TIPOSANGUINEO` varchar(2)
,`NUMERODOACOES` bigint(21)
);

-- --------------------------------------------------------

--
-- Estrutura da tabela `doacao`
--

CREATE TABLE `doacao` (
  `IDDoacao` int(11) NOT NULL,
  `IDDoador` int(11) DEFAULT NULL,
  `DataDoacao` datetime NOT NULL,
  `QtdColetada` decimal(5,2) DEFAULT '0.00'
) ENGINE=InnoDB DEFAULT CHARSET=latin1;

--
-- Extraindo dados da tabela `doacao`
--

INSERT INTO `doacao` (`IDDoacao`, `IDDoador`, `DataDoacao`, `QtdColetada`) VALUES
(1, 1, '2017-11-22 10:20:32', '330.00'),
(2, 2, '2018-05-13 09:50:50', '450.00'),
(3, 3, '2019-06-19 16:00:15', '400.00'),
(4, 4, '2016-08-10 17:19:20', '380.00'),
(5, 5, '2015-03-15 14:07:36', '330.00'),
(6, 6, '2019-10-10 10:30:44', '395.00'),
(7, 7, '2019-11-26 21:23:04', '330.01'),
(8, 8, '2019-11-27 01:00:15', '300.00'),
(9, 1, '2019-11-27 15:07:49', '300.00');

-- --------------------------------------------------------

--
-- Estrutura da tabela `doador`
--

CREATE TABLE `doador` (
  `IDDoador` int(11) NOT NULL,
  `NomePai` varchar(150) NOT NULL,
  `NomeMae` varchar(150) NOT NULL,
  `DataNascimento` date NOT NULL,
  `Sexo` char(1) NOT NULL,
  `RG` varchar(9) NOT NULL,
  `Nome` varchar(150) NOT NULL,
  `Rua` varchar(150) NOT NULL,
  `Bairro` varchar(150) NOT NULL,
  `Cidade` varchar(150) NOT NULL,
  `Estado` char(2) NOT NULL,
  `NumeroResidencial` varchar(10) NOT NULL,
  `CEP` char(9) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=latin1;

--
-- Extraindo dados da tabela `doador`
--

INSERT INTO `doador` (`IDDoador`, `NomePai`, `NomeMae`, `DataNascimento`, `Sexo`, `RG`, `Nome`, `Rua`, `Bairro`, `Cidade`, `Estado`, `NumeroResidencial`, `CEP`) VALUES
(1, 'Francisco Pires', 'Claudia Pires', '1996-12-09', 'M', '330993653', 'Matheus Pires', 'Rua Adolfo Valentini', 'Osasco', 'Sao Paulo', 'SP', '35', '06018-060'),
(2, 'Gabriel Martins', 'Gabriela Martins', '1998-12-09', 'F', '181821679', 'Maria Martins', 'Travessa Adrião Henrique dos Reis', 'Centro', 'Osasco', 'SP', '315', '06110-020'),
(3, 'Carlos Souza', 'Naty Souza', '1992-10-10', 'M', '268305316', 'Waldyr Souza', 'Rua Afonso Schmidt', 'Centro', 'Osasco', 'SP', '50', '06083-250'),
(4, 'Adam Augusto', 'Scarlet Augusto', '2000-01-22', 'F', '453303924', 'Joana Augusto', 'Rua Albino Guilherme Esteves', 'Centro', 'Osasco', 'SP', '501', '06018-130'),
(5, 'Andrey Sutil', 'Isabela Sutil', '1990-05-27', 'F', '299882743', 'Paloma Sutil', 'Rua Albino dos Santos', 'Centro', 'Osasco', 'SP', '150', '06093-060'),
(6, 'Diogo Nascimento', 'Josiane Nascimento', '2001-02-10', 'M', '214956982', 'Mbappé Nascimento', 'Rua Alexandre Rossi', 'Centro', 'Osasco', 'SP', '43', '06110-010'),
(7, 'Valdir', 'Monica', '1999-12-26', 'M', '533378559', 'Waldyrzão', 'Rua Henrique da Costa', 'Jardim Itacolomi', 'São Paulo', 'SP', '8', '04386000'),
(8, 'Valdir', 'Monica', '1999-12-26', 'M', '533378513', 'Waldyrzão ZIKA', 'Rua Henrique da Costa', 'Jardim Itacolomi', 'São Paulo', 'SP', '8', '04386000');

-- --------------------------------------------------------

--
-- Estrutura da tabela `exames`
--

CREATE TABLE `exames` (
  `IDExames` int(11) NOT NULL,
  `Pergunta` varchar(300) DEFAULT NULL,
  `NvlRefHemoglobina` decimal(5,2) DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=latin1;

--
-- Extraindo dados da tabela `exames`
--

INSERT INTO `exames` (`IDExames`, `Pergunta`, `NvlRefHemoglobina`) VALUES
(1, 'ultima vez que fumou?', NULL),
(2, 'ultima vez que bebeu?', NULL),
(4, 'tem alguma doenca?', NULL),
(5, 'Usou drogas?', NULL),
(6, 'Tomou vacina para gripe?', NULL),
(7, 'USOU DROGAS', NULL),
(8, 'Colocou piercing?', NULL),
(9, 'Usou drogas?', NULL),
(10, 'Usou drogas?', NULL),
(11, 'Fez endoscopia?', NULL),
(12, 'Ja possuiu malaria?', NULL),
(14, NULL, '45.50'),
(15, NULL, '45.60');

-- --------------------------------------------------------

--
-- Estrutura da tabela `examesangue`
--

CREATE TABLE `examesangue` (
  `IDExameSangue` int(11) NOT NULL,
  `IDDoacao` int(11) NOT NULL,
  `IDTesteSangue` int(11) NOT NULL,
  `Resultado` varchar(300) NOT NULL,
  `DataExameSangue` datetime NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=latin1;

--
-- Extraindo dados da tabela `examesangue`
--

INSERT INTO `examesangue` (`IDExameSangue`, `IDDoacao`, `IDTesteSangue`, `Resultado`, `DataExameSangue`) VALUES
(1, 1, 4, 'Viadão', '2017-11-24 10:00:15'),
(2, 2, 4, 'Hepatite C', '2018-05-15 09:30:32'),
(3, 3, 6, 'Sifilis', '2019-06-21 16:15:03'),
(4, 4, 1, 'HTLV I', '2016-08-12 17:22:48'),
(5, 5, 3, 'AIDS', '2015-03-17 14:14:14'),
(6, 6, 5, 'Chagas', '2019-10-12 10:40:20');

-- --------------------------------------------------------

--
-- Estrutura da tabela `medico`
--

CREATE TABLE `medico` (
  `IDMedico` int(11) NOT NULL,
  `Nome` varchar(150) NOT NULL,
  `CRM` char(6) NOT NULL,
  `EstadoCRM` char(2) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=latin1;

--
-- Extraindo dados da tabela `medico`
--

INSERT INTO `medico` (`IDMedico`, `Nome`, `CRM`, `EstadoCRM`) VALUES
(1, 'Dr. César Gruppi', '254845', 'SP'),
(2, 'Dr. Cristiano Faria Pisani', '118484', 'SP'),
(3, 'Dra. Luciana Sacilotto Fernandes', '499579', 'SP'),
(4, 'Dra. Paola Pretti Nunes Ferreira Falochio', '639332', 'SP'),
(5, 'Dra. Sissy de Melo', '293586', 'SP'),
(6, 'Dr. Mateus Paiva Marques Feitosa', '223227', 'SP'),
(7, 'Vladimir Putin', '878963', 'RU');

-- --------------------------------------------------------

--
-- Estrutura da tabela `testesangue`
--

CREATE TABLE `testesangue` (
  `IDTesteSangue` int(11) NOT NULL,
  `Nome` varchar(150) DEFAULT NULL,
  `ValorRef` decimal(5,2) DEFAULT NULL,
  `TipoSanguineo` varchar(2) DEFAULT NULL,
  `FatorRH` char(1) DEFAULT NULL,
  `Anticorpos` varchar(150) DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=latin1;

--
-- Extraindo dados da tabela `testesangue`
--

INSERT INTO `testesangue` (`IDTesteSangue`, `Nome`, `ValorRef`, `TipoSanguineo`, `FatorRH`, `Anticorpos`) VALUES
(1, NULL, NULL, 'A', '+', 'Nenhum'),
(2, 'Hepatite C', '130.10', NULL, NULL, NULL),
(3, 'Sifilis', '180.95', NULL, NULL, NULL),
(4, 'HTLV I', '201.51', NULL, NULL, NULL),
(5, NULL, NULL, 'B', '+', 'Antiglobulina'),
(6, NULL, NULL, 'B', '-', 'Antiglobulina'),
(7, 'GONORREIA', '121.40', NULL, NULL, NULL),
(8, NULL, NULL, 'O', '+', 'NENHUMA'),
(9, NULL, NULL, 'O', '-', 'NENHUMA');

-- --------------------------------------------------------

--
-- Stand-in structure for view `ultimadoacao_tiposanguineo`
-- (See below for the actual view)
--
CREATE TABLE `ultimadoacao_tiposanguineo` (
`DOADOR` varchar(150)
,`TIPOSANGUINEO` varchar(2)
,`FATORRH` char(1)
,`ULTDOACAO` datetime
);

-- --------------------------------------------------------

--
-- Structure for view `count_tiposanguneo`
--
DROP TABLE IF EXISTS `count_tiposanguneo`;

CREATE ALGORITHM=UNDEFINED DEFINER=`root`@`localhost` SQL SECURITY DEFINER VIEW `count_tiposanguneo`  AS  select `t`.`TipoSanguineo` AS `TIPOSANGUINEO`,count(0) AS `NUMERODOACOES` from ((`testesangue` `t` join `doacao` `d`) join `examesangue` `e`) where ((`t`.`TipoSanguineo` is not null) and (cast(`d`.`DataDoacao` as date) >= (curdate() - interval 5 year)) and (`e`.`IDDoacao` = `d`.`IDDoacao`) and (`t`.`IDTesteSangue` = `e`.`IDTesteSangue`)) group by `t`.`TipoSanguineo` order by count(0) ;

-- --------------------------------------------------------

--
-- Structure for view `ultimadoacao_tiposanguineo`
--
DROP TABLE IF EXISTS `ultimadoacao_tiposanguineo`;

CREATE ALGORITHM=UNDEFINED DEFINER=`root`@`localhost` SQL SECURITY DEFINER VIEW `ultimadoacao_tiposanguineo`  AS  select `dr`.`Nome` AS `DOADOR`,`t`.`TipoSanguineo` AS `TIPOSANGUINEO`,`t`.`FatorRH` AS `FATORRH`,max(`d`.`DataDoacao`) AS `ULTDOACAO` from (((`doador` `dr` join `examesangue` `e`) join `doacao` `d`) join `testesangue` `t`) where ((`t`.`TipoSanguineo` is not null) and (`t`.`FatorRH` is not null) and (`dr`.`IDDoador` = `d`.`IDDoador`) and (`d`.`IDDoacao` = `e`.`IDDoacao`) and (`t`.`IDTesteSangue` = `e`.`IDTesteSangue`)) group by `dr`.`IDDoador` order by `t`.`TipoSanguineo`,4 ;

--
-- Indexes for dumped tables
--

--
-- Indexes for table `avaliacao`
--
ALTER TABLE `avaliacao`
  ADD PRIMARY KEY (`IDAvaliacao`),
  ADD KEY `IDDoador` (`IDDoador`),
  ADD KEY `IDX_DATAAVALIACAO` (`DataAvaliacao`),
  ADD KEY `IDX_RESULTADOAVALIACAO` (`ResultadoGeral`);

--
-- Indexes for table `candexame`
--
ALTER TABLE `candexame`
  ADD PRIMARY KEY (`IDExames`,`IDAvaliacao`),
  ADD KEY `IDAvaliacao` (`IDAvaliacao`),
  ADD KEY `IDX_DATAEXAME` (`DataExame`);

--
-- Indexes for table `consulta`
--
ALTER TABLE `consulta`
  ADD PRIMARY KEY (`IDConsulta`,`IDMedico`,`IDExameSangue`,`IDDoacao`,`IDTesteSangue`),
  ADD KEY `IDExameSangue` (`IDExameSangue`,`IDDoacao`,`IDTesteSangue`),
  ADD KEY `IDMedico` (`IDMedico`),
  ADD KEY `IDX_DATACONSULTA` (`DataConsulta`);

--
-- Indexes for table `doacao`
--
ALTER TABLE `doacao`
  ADD PRIMARY KEY (`IDDoacao`),
  ADD KEY `IDDoador` (`IDDoador`),
  ADD KEY `IDX_DATADOACAO` (`DataDoacao`);

--
-- Indexes for table `doador`
--
ALTER TABLE `doador`
  ADD PRIMARY KEY (`IDDoador`),
  ADD KEY `IDX_DoadorRG` (`RG`);

--
-- Indexes for table `exames`
--
ALTER TABLE `exames`
  ADD PRIMARY KEY (`IDExames`);

--
-- Indexes for table `examesangue`
--
ALTER TABLE `examesangue`
  ADD PRIMARY KEY (`IDExameSangue`,`IDDoacao`,`IDTesteSangue`),
  ADD KEY `IDTesteSangue` (`IDTesteSangue`),
  ADD KEY `IDDoacao` (`IDDoacao`),
  ADD KEY `IDX_DATAEXAMESANGUE` (`DataExameSangue`);

--
-- Indexes for table `medico`
--
ALTER TABLE `medico`
  ADD PRIMARY KEY (`IDMedico`),
  ADD KEY `IDX_MedicoCRM` (`CRM`),
  ADD KEY `IDX_MedicoESTADOCRM` (`EstadoCRM`);

--
-- Indexes for table `testesangue`
--
ALTER TABLE `testesangue`
  ADD PRIMARY KEY (`IDTesteSangue`);

--
-- AUTO_INCREMENT for dumped tables
--

--
-- AUTO_INCREMENT for table `avaliacao`
--
ALTER TABLE `avaliacao`
  MODIFY `IDAvaliacao` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=13;

--
-- AUTO_INCREMENT for table `consulta`
--
ALTER TABLE `consulta`
  MODIFY `IDConsulta` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=4;

--
-- AUTO_INCREMENT for table `doacao`
--
ALTER TABLE `doacao`
  MODIFY `IDDoacao` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=10;

--
-- AUTO_INCREMENT for table `doador`
--
ALTER TABLE `doador`
  MODIFY `IDDoador` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=9;

--
-- AUTO_INCREMENT for table `exames`
--
ALTER TABLE `exames`
  MODIFY `IDExames` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=16;

--
-- AUTO_INCREMENT for table `examesangue`
--
ALTER TABLE `examesangue`
  MODIFY `IDExameSangue` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=7;

--
-- AUTO_INCREMENT for table `medico`
--
ALTER TABLE `medico`
  MODIFY `IDMedico` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=8;

--
-- AUTO_INCREMENT for table `testesangue`
--
ALTER TABLE `testesangue`
  MODIFY `IDTesteSangue` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=10;

--
-- Constraints for dumped tables
--

--
-- Limitadores para a tabela `avaliacao`
--
ALTER TABLE `avaliacao`
  ADD CONSTRAINT `avaliacao_ibfk_1` FOREIGN KEY (`IDDoador`) REFERENCES `doador` (`IDDoador`);

--
-- Limitadores para a tabela `candexame`
--
ALTER TABLE `candexame`
  ADD CONSTRAINT `candexame_ibfk_1` FOREIGN KEY (`IDExames`) REFERENCES `exames` (`IDExames`),
  ADD CONSTRAINT `candexame_ibfk_2` FOREIGN KEY (`IDAvaliacao`) REFERENCES `avaliacao` (`IDAvaliacao`);

--
-- Limitadores para a tabela `consulta`
--
ALTER TABLE `consulta`
  ADD CONSTRAINT `consulta_ibfk_1` FOREIGN KEY (`IDExameSangue`,`IDDoacao`,`IDTesteSangue`) REFERENCES `examesangue` (`IDExameSangue`, `IDDoacao`, `IDTesteSangue`),
  ADD CONSTRAINT `consulta_ibfk_2` FOREIGN KEY (`IDMedico`) REFERENCES `medico` (`IDMedico`);

--
-- Limitadores para a tabela `doacao`
--
ALTER TABLE `doacao`
  ADD CONSTRAINT `doacao_ibfk_1` FOREIGN KEY (`IDDoador`) REFERENCES `doador` (`IDDoador`);

--
-- Limitadores para a tabela `examesangue`
--
ALTER TABLE `examesangue`
  ADD CONSTRAINT `examesangue_ibfk_1` FOREIGN KEY (`IDTesteSangue`) REFERENCES `testesangue` (`IDTesteSangue`),
  ADD CONSTRAINT `examesangue_ibfk_2` FOREIGN KEY (`IDDoacao`) REFERENCES `doacao` (`IDDoacao`);
COMMIT;

/*!40101 SET CHARACTER_SET_CLIENT=@OLD_CHARACTER_SET_CLIENT */;
/*!40101 SET CHARACTER_SET_RESULTS=@OLD_CHARACTER_SET_RESULTS */;
/*!40101 SET COLLATION_CONNECTION=@OLD_COLLATION_CONNECTION */;
