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
	qtdTruta INT,
    tamanho_m² DECIMAL(7,2),
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
    nSerie VARCHAR(45),
    status_sen VARCHAR(45),
    CONSTRAINT chk_statusSensor CHECK (status_sen IN( 'Ativo','Inativo','Manutenção')),
    nome VARCHAR(45),
    fkTanque INT,
	CONSTRAINT fkTanqueSensor
		FOREIGN KEY (fkTanque)
        REFERENCES tanque(idTanque)
);

CREATE TABLE coletaTemp(
	idColeta INT AUTO_INCREMENT,
    temperatura DECIMAL(4,2),
    dtHora DATETIME DEFAULT CURRENT_TIMESTAMP,
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
		DESC plano;
			DESC pagamento;
		DESC tanque;
			DESC sensor;
				DESC coletaTemp;    

-- INSERSÃO DE DADOS
INSERT INTO tanque (TempMax, TempMin, qtdTruta, tamanho_m²,litragem, nome, setor, fkEmpresa) VALUES
-- Empresa 1
(18.5, 10.5, 250, 135.50,5000, 'Tanque Principal', 'Setor A', 1),
(17.0, 11.0, 180, 128.20,5000, 'Tanque Juvenil', 'Setor B', 1),
-- Empresa 2
(19.0, 9.8, 300, 155.50,5500, 'Tanque da Serra', 'Setor Norte', 2),
(18.2, 10.2, 150, 105.10,4000, 'Tanque Experimental', 'Setor Leste', 2),
-- Empresa 3
(18.8, 10.0, 270, 140,5000, 'Tanque Rio Claro', 'Setor 1', 3),
(17.5, 9.5, 120, 90,2000, 'Tanque Reserva', 'Setor 2', 3);

INSERT INTO sensor (nSerie, status_sen, nome, fkTanque) VALUES
-- Tanques da Empresa 1
('LM35-A001', 'Ativo', 'LM35', 1), -- tanque 1
('DS18B20-A002', 'Ativo', 'DS18B20', 1), 
('LM35-A003', 'Ativo', 'LM35', 2), -- Tanque 2
('DS18B20-A004', 'Inativo', 'DS18B20', 2),
-- Tanques da Empresa 2
('LM35-B001', 'Ativo', 'LM35', 3), -- Tanque 1 
('DS18B20-B002', 'Ativo', 'DS18B20', 3),
('LM35-B003', 'Ativo', 'LM35', 4), -- Tanque 2
('DS18B20-B004', 'Inativo', 'DS18B20', 4),
-- Tanques da Empresa 3
('LM35-C001', 'Ativo', 'LM35', 5), -- Tanque 1
('DS18B20-C002', 'Ativo', 'DS18B20', 5),
('LM35-C003', 'Ativo', 'LM35', 6), -- Tanque 2
('DS18B20-C004', 'Ativo', 'DS18B20', 6);

/* INSERT INTO coletaTemp (temperatura, dtHora, fkSensor) VALUES
-- Tanque 1 : EMpresa 1
(15.2, '2025-10-25 08:00:00', 1),
(15.5, '2025-10-25 12:30:00', 2),
(15.8, DEFAULT, 1),
-- Tanque 2: Empresa 1
(16.1, '2025-10-24 09:15:00', 3),
(16.4, '2025-10-24 14:45:00', 4),
-- Tanque 3 : Empresa 2
(14.9, '2025-10-25 07:50:00', 5),
(15.3, DEFAULT, 6),
-- Tanque 4 : Empresa 2
(16.0, '2025-10-24 10:10:00', 7),
(16.2, '2025-10-24 13:20:00', 8),
-- Tanque 5 : EMpresa 3
(15.5, '2025-10-27 09:00:00', 9),
(15.7, DEFAULT, 10),
-- Tanque 6 : Empresa 3
(16.1, '2025-10-27 11:30:00', 11),
(16.3, DEFAULT, 12);
*/        
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
    ct.dtHora AS ultimaCOleta
    FROM tanque t
		JOIN sensor s ON t.idTanque = s.fkTanque
        JOIN coletaTemp ct on s.idSensor = ct.fkSensor
	WHERE fkEmpresa = 1 AND idTanque = 1
    GROUP BY idTanque, dtHora;

SELECT nomeFantasia,
	razaoSocial,
    cnpj,
    cell AS CellEmpresa,
    tellFixo AS TellFixoEmpresa,
    func.nome AS Funcionario,
    func.email AS EmailFunc,
    supv.nome AS Supervisor 
    FROM usuario AS func JOIN empresa
		ON func.fkEmpresa = idEmpresa
	JOIN usuario AS supv -- Verse se é o Left ou Right para aparecer o supervisor
		ON func.Supervisor = supv.idUsuario;
        
SELECT nomeFantasia as Empresa, setor as Setor, nSerie as 'Número do sensor',
 temperatura as Temperatura, CASE 
 WHEN temperatura >= 20 THEN 'Crítico'
 WHEN temperatura >= 16 AND temperatura < 20 THEN 'Alerta'
 WHEN temperatura >= 10 AND temperatura < 16 THEN 'Estável'
 END 'Status do tanque' 
 FROM empresa JOIN tanque ON tanque.fkEmpresa = empresa.idEmpresa 
 JOIN sensor ON sensor.fkTanque = tanque.idTanque
 JOIN coletaTemp ON coletaTemp.fkSensor = sensor.idSensor;