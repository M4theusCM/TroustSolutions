CREATE DATABASE troustsolutions;
USE troustsolutions;

/* ORDEM CRIAÇÃO 
Empresa
	Usuario
    Logradouro
	Plano
		Pagamento
	Tnaque
		Sensor
			ColetaTemp
*/

CREATE TABLE empresa(
	idEmpresa INT PRIMARY KEY AUTO_INCREMENT,
    nomeFantasia VARCHAR(45),
    razaoSocial VARCHAR(100),
    cnpj CHAR(14) UNIQUE,
    cell CHAR(11),
    tellFixo CHAR(10),
    codigo varchar(45)
);

CREATE TABLE usuario(
	idUsuario INT PRIMARY KEY AUTO_INCREMENT,
    nome VARCHAR(45),
    email VARCHAR(45) UNIQUE,
    CONSTRAINT chk_email CHECK (email LIKE '%@%'),
    senha VARCHAR(45),
    fkEmpresa INT,
	CONSTRAINT fkEmpresaUsuario
		FOREIGN KEY (fkEmpresa)
        REFERENCES empresa(idEmpresa)
);

CREATE TABLE logradouro(
	idLogradouro INT PRIMARY KEY AUTO_INCREMENT,
    cep CHAR(8),
    numero VARCHAR(10),
    complemento VARCHAR(45),
    rua VARCHAR(45),
    bairro VARCHAR(45),
    estado VARCHAR(45),
    fkEmpresa INT,
    CONSTRAINT fkEmpresaLogradouro
		FOREIGN KEY (fkEmpresa)
        REFERENCES empresa(idEmpresa)
);

CREATE TABLE tanque(
	idTanque INT PRIMARY KEY AUTO_INCREMENT,
    TempMax DECIMAL(4,2),
    TempMin DECIMAL(4,2),
    mts_quadrados DECIMAL(7,2),
    litragem DECIMAL(7,2),
    nome VARCHAR(45),
    setor VARCHAR(45),
    fkEmpresa INT,
    CONSTRAINT fkEmpresaTanque
		FOREIGN KEY (fkEmpresa)
        REFERENCES empresa(idEmpresa)
);

CREATE TABLE sensor(
	idSensor INT PRIMARY KEY AUTO_INCREMENT,
    status_sen VARCHAR(45),
    CONSTRAINT chk_statusSensor CHECK (status_sen IN( 'Ativo','Inativo','Manutenção')),
    fkTanque INT,
	CONSTRAINT fkTanqueSensor
		FOREIGN KEY (fkTanque)
        REFERENCES tanque(idTanque)
);

CREATE TABLE coletaTemp(
	idColeta INT AUTO_INCREMENT,
    temperatura DECIMAL(4,2),
    dtHora DATETIME,
    fkSensor INT,
    CONSTRAINT pk_sensor_coleta PRIMARY KEY (idColeta, fkSensor),
    CONSTRAINT fkSensorColetaTemp
		FOREIGN KEY (fkSensor)
        REFERENCES sensor(idSensor)
);

-- ESTRUTURA DAS TABELAS
	DESC empresa;
		DESC usuario;
		DESC logradouro;
		DESC tanque;
			DESC sensor;
				DESC coletaTemp;    

-- INSERSÃO DE DADOS
INSERT INTO empresa (nomeFantasia, razaoSocial, cnpj , cell, tellFixo, codigo) VALUES 
	(1, 1, 11111111111111, 11111111111, 1111111111, 123456),
	(2, 2, 22222222222222, 22222222222, 2222222222, 123456);
    
INSERT INTO usuario (nome, email, senha , fkEmpresa) VALUES 
	(1, '1@.com', 123456, 1),
	(2, '2@.com', 123456, 2);

INSERT INTO tanque (TempMax, TempMin, mts_quadrados, litragem, nome, setor, fkEmpresa) VALUES
-- Empresa 1
(18.5, 10.5, 135.50,5000, 'Tanque Principal', 'Setor A', 1),
(17.0, 11.0, 128.20,5000, 'Tanque Juvenil', 'Setor B', 1),
-- Empresa 2
(19.0, 9.8, 155.50,5500, 'Tanque da Serra', 'Setor Norte', 1),
(18.2, 10.2, 105.10,4000, 'Tanque Experimental', 'Setor Leste', 1);

INSERT INTO sensor (status_sen, fkTanque) VALUES
-- Tanques da Empresa 1
('Ativo', 5), -- tanque 1
('Ativo', 6), 
('Ativo', 7), -- Tanque 2
('Inativo', 8),
-- Tanques da Empresa 2
('Ativo', 3), -- Tanque 1 
('Ativo', 3),
('Ativo', 4), -- Tanque 2
('Inativo', 4);

INSERT INTO coletaTemp (temperatura, dtHora, fkSensor) VALUES
-- Tanque 1 : EMpresa 1
(15.2, '2025-10-25 08:00:00', 9),
(15.5, '2025-10-25 10:30:00', 9),
(15.2, '2025-10-25 09:00:00', 10),
(15.5, '2025-10-25 12:30:00', 10),
(15, '2025-10-25 12:30:00', 11),
(15.9, '2025-10-25 10:30:00', 11),
(15, '2025-10-25 15:30:00', 12),
(15.9, '2025-10-25 14:30:00', 12),
-- Tanque 2: Empresa 1
(16.1, '2025-10-24 09:15:00', 4),
(16.4, '2025-10-24 14:45:00', 4),
-- Tanque 3 : Empresa 2
(14.9, '2025-10-25 07:50:00', 1),
(15.3, '2025-10-25 07:50:00', 2),
-- Tanque 4 : Empresa 2
(16.0, '2025-10-24 10:10:00', 1),
(16.2, '2025-10-24 13:20:00', 2);
       
-- SELECT
SELECT * FROM empresa;
SELECT * FROM usuario;
SELECT * FROM logradouro;
SELECT * FROM tanque;
SELECT * FROM sensor;
SELECT * FROM coletaTemp;

SELECT t.idTanque,
	t.nome AS nometanque,
    t.setor AS setortanque,
    t.TempMax AS configMaxTemp,
    t.TempMin AS configMinTemp,
    ROUND(AVG(ct.temperatura), 2) AS mediaTanque,
    MAX(ct.dtHora) AS ultimaCOleta
    FROM tanque t
		JOIN sensor s ON t.idTanque = s.fkTanque
        JOIN coletaTemp ct on s.idSensor = ct.fkSensor
	WHERE fkEmpresa = 1
    GROUP BY idTanque;
	
SELECT t.idTanque,
	t.nome AS nometanque,
    t.setor AS setortanque,
    t.TempMax AS configMaxTemp,
    t.TempMin AS configMinTemp,
    ROUND(AVG(ct.temperatura), 2) AS mediaTanque,
    MAX(ct.dtHora) AS ultimaCOleta
    FROM tanque t
		JOIN sensor s ON t.idTanque = s.fkTanque
        JOIN coletaTemp ct on s.idSensor = ct.fkSensor
	WHERE fkEmpresa = 1
    GROUP BY idTanque;

 SELECT t.idTanque,
            t.nome AS nometanque,
            t.setor AS setortanque,
            t.TempMax AS configMaxTemp,
            t.TempMin AS configMinTemp,
            ROUND(AVG(ct.temperatura), 2) AS mediaTanque,
            MAX(ct.dtHora) AS ultimaCOleta
            FROM tanque t
                JOIN sensor s ON t.idTanque = s.fkTanque
                JOIN coletaTemp ct on s.idSensor = ct.fkSensor
            WHERE fkEmpresa = 1
            GROUP BY idTanque;	
select * from empresa;
select * from usuario;
select * from coletaTemp ORDER BY idColeta DESC;

select temperatura from coletaTemp 
JOIN sensor ON idSensor = fkSensor
JOIN tanque ON idTanque = fkTanque
WHERE fkTanque = 1 ORDER BY idColeta DESC;

 SELECT t.idTanque,
            t.nome AS nometanque,
            t.setor AS setortanque,
            t.TempMax AS configMaxTemp,
            t.TempMin AS configMinTemp,
            ROUND(AVG(ct.temperatura), 2) AS mediaTanque,
            MAX(ct.dtHora) AS ultimaCOleta
            FROM tanque t
                JOIN sensor s ON t.idTanque = s.fkTanque
                JOIN coletaTemp ct on s.idSensor = ct.fkSensor
            WHERE fkEmpresa = 1 AND dtHora = (select dtHora from coletaTemp JOIN sensor on fkSensor = idSensor WHERE fktanque = t.idTanque order by dtHora DESC limit 1)
            GROUP BY idTanque;
            
SELECT 
    t.idTanque,
    t.nome AS nomeTanque,
    ROUND(AVG(ultimas.temperatura), 2) AS mediaTanque
FROM tanque t
JOIN sensor s ON s.fkTanque = t.idTanque
JOIN (SELECT ct1.fkSensor, ct1.temperatura
    FROM coletaTemp ct1
    JOIN (SELECT fkSensor, MAX(dtHora) AS ultimaData
        FROM coletaTemp
        GROUP BY fkSensor) 
        ult ON ult.fkSensor = ct1.fkSensor AND ult.ultimaData = ct1.dtHora) 
        ultimas ON ultimas.fkSensor = s.idSensor
WHERE t.fkEmpresa = 1
GROUP BY t.idTanque;