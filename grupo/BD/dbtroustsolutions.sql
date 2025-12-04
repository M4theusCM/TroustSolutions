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
    dtHora DATETIME default current_timestamp,
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
insert into empresa (nomeFantasia,razaoSocial ,cnpj ,cell,tellFixo, codigo) values
	('troustsolutions', 'Troustsolutions LTDA', 11111111111111, 11111111111, 1111111111, 123456);
    
INSERT INTO tanque (TempMax, TempMin, mts_quadrados, litragem, nome, setor, fkEmpresa) VALUES
-- Empresa 1
(18.5, 10.5, 135.50,5000, 'Tanque Principal', 'Setor A', 1),
(17.0, 11.0, 128.20,5000, 'Tanque Juvenil', 'Setor B', 1);
/*
-- Empresa 2
(19.0, 9.8, 155.50,5500, 'Tanque da Serra', 'Setor Norte', 2),
(18.2, 10.2, 105.10,4000, 'Tanque Experimental', 'Setor Leste', 2);
*/
INSERT INTO sensor (status_sen, fkTanque) VALUES
-- Tanques da Empresa 1
('Ativo', 1), -- tanque 1
('Ativo', 1), 
('Ativo', 1), -- Tanque 2
('Inativo', 1);
/*
-- Tanques da Empresa 2
('Ativo', 3), -- Tanque 1 
('Ativo', 3),
('Ativo', 4), -- Tanque 2
('Inativo', 4);
*/
INSERT INTO coletaTemp (temperatura, dtHora, fkSensor) VALUES
-- Tanque 1 : EMpresa 1
(25.2, '2025-10-25 19:54:00', 1);
-- Tanque 2: Empresa 1
(16.1, '2025-10-24 03:15:00', 2),
(16.4, '2025-10-24 04:45:00', 2);
/*
-- Tanque 3 : Empresa 2
(14.9, '2025-10-25 07:50:00', 1),
(15.3, '2025-10-25 07:50:00', 2),
-- Tanque 4 : Empresa 2
(16.0, '2025-10-24 10:10:00', 3),
(16.2, '2025-10-24 13:20:00', 4);
*/
desc usuario;
insert into usuario (nome, email, senha, fkEmpresa) VALUES
	('Matheus S. Rodrigues', 'matheus@gmail.com', '123456', 1);

-- SELECT
SELECT * FROM empresa;
SELECT * FROM usuario;
SELECT * FROM logradouro;
SELECT * FROM tanque;
SELECT * FROM sensor;
SELECT * FROM coletaTemp;
SELECT nomeFantasia, codigo FROM empresa;
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

SELECT idTanque, nomeTanque, setorTanque, mediaTanque FROM vw_alerta_tanque WHERE fkEmpresa = 2;	
select * from empresa;
select * from usuario;
select * from tanque;


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
            MAX(ct.dtHora) AS ultimaColeta
            FROM tanque t
                JOIN sensor s ON t.idTanque = s.fkTanque
                JOIN coletaTemp ct on s.idSensor = ct.fkSensor
            WHERE fkEmpresa = 1 AND dtHora = (select dtHora from coletaTemp JOIN sensor on fkSensor = idSensor WHERE fktanque = t.idTanque order by dtHora DESC limit 1)
            GROUP BY idTanque;
            
CREATE VIEW vw_alerta_tanque AS SELECT t.idTanque,
	t.nome AS nometanque,
    t.setor AS setortanque,
    t.TempMax AS configMaxTemp,
    t.TempMin AS configMinTemp,
    ROUND(AVG(ct.temperatura), 2) AS mediaTanque,
    MAX(ct.dtHora) AS ultimaColeta,
    t.fkEmpresa AS fkEmpresa
    FROM tanque t
		JOIN sensor s ON t.idTanque = s.fkTanque
        JOIN coletaTemp ct on s.idSensor = ct.fkSensor
        WHERE fkEmpresa = 1 AND dtHora = (select dtHora from coletaTemp JOIN sensor on fkSensor = idSensor WHERE fktanque = t.idTanque order by dtHora DESC limit 1)
    GROUP BY idTanque
    HAVING ROUND(AVG(ct.temperatura), 2) > t.tempMax OR ROUND(AVG(ct.temperatura), 2) < t.tempMin;
        
 SELECT t.idTanque,
            t.nome AS nometanque,
            t.setor AS setortanque,
            ROUND(AVG(ct.temperatura), 2) AS mediaTanque,
            MAX(ct.dtHora) AS ultimaColeta
            FROM tanque t
                JOIN sensor s ON t.idTanque = s.fkTanque
                JOIN coletaTemp ct on s.idSensor = ct.fkSensor
                where fkEmpresa = 1 and idTanque = 1
            GROUP BY idTanque, dtHora 
            order by dtHora limit 7;
            
select * from coletaTemp ORDER BY idColeta DESC;

select t.idTanque,
		t.nome AS nometanque,
        t.setor AS setortanque,
		t.TempMax AS configMaxTemp,
		t.TempMin AS configMinTemp,
        ROUND(AVG(ct.temperatura), 2) AS mediaTanque,
		MAX(ct.dtHora) AS ultimaColeta
		FROM tanque t
        JOIN sensor s ON t.idTanque = s.fkTanque
        JOIN coletaTemp ct on s.idSensor = ct.fkSensor
        WHERE fkEmpresa = 1 AND dtHora = (select dtHora from coletaTemp JOIN sensor on fkSensor = idSensor WHERE fktanque = t.idTanque order by dtHora DESC limit 1)
        GROUP BY idTanque;
        
        SELECT ROUND(AVG(ct.temperatura), 2) AS mediaTanque,
            DATE_FORMAT(MAX(ct.dtHora), '%H:%i') AS ultimaColeta
            FROM tanque t
                JOIN sensor s ON t.idTanque = s.fkTanque
                JOIN coletaTemp ct on s.idSensor = ct.fkSensor
                where fkEmpresa = 1 and idTanque = 1
            GROUP BY idTanque, dtHora 
            order by ultimaColeta DESC limit 7;

select * from vw_alerta_tanque;

select count(DISTINCT t.idtanque) AS qtdTanque,
	count(DISTINCT s.idSensor) AS qtdSensor,
    (select COUNT(DISTINCT idTanque) from vw_alerta_tanque WHERE t.fkEmpresa = 1) AS qtdAlertas
    from tanque t 
    JOIN sensor s ON t.idTanque = s.fktanque  
    WHERE t.fkEmpresa = 1;
    

