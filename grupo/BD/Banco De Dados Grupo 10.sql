/*
---------- GRUPO 10 ----------

Mudanças:

- Criada tabelas: Financeiro, Sensor, Pagamento, Empresa, Logradouro

- Tabela apagada: Login

- Coluna apagada: tanque(temperatura),

- Colunas Adicionadas: coleta(localizacao), 

- Check : 

* Check que tem que ter @ no email
* dtCadastro agora é o dia e hora que realizou o cadastro
* alerta com check - 'moderado','critico','estavel'

*/

DROP DATABASE TRUTICULTURA;
CREATE DATABASE TRUTICULTURA ;

USE TRUTICULTURA; 

show tables;
-- -----------------------------------------------------------------------------------------------------------------------
CREATE TABLE empresa (
    idEmpresa INT PRIMARY KEY AUTO_INCREMENT,
    nome_empresa VARCHAR(50) NOT NULL UNIQUE,
    representante varchar(50) not null,
    telefone VARCHAR(13) UNIQUE,
    senha VARCHAR(20) NOT NULL,
    cnpj CHAR(18)NOT NULL UNIQUE,
    dtCadastro DATETIME DEFAULT CURRENT_TIMESTAMP,
    email VARCHAR(50) NOT NULL UNIQUE,
    CONSTRAINT chk_email CHECK(email LIKE '%@%'),
    status_cliente varchar(30) not null,
	constraint chk_status check(status_cliente in('Ativo','Inativo'))
);

create table logradouro(
pk_fk_Empresa int,
cep char(9) not null,
num_endereco varchar(45) not null,
bairro varchar(50),
constraint pk_Empresa primary key (pk_fk_Empresa), 
constraint fk_Empresa_logra foreign key (pk_fk_Empresa) references empresa(idEmpresa));


-- ----------------------------------------------------------------------------------------------------------------------------

CREATE TABLE sensor (
	id_sensor INT PRIMARY KEY AUTO_INCREMENT,
    nSerie VARCHAR(40),
    status_sensor VARCHAR(15),
		CONSTRAINT chkStatus CHECK (status_sensor IN ('Ativo', 'Inativo', 'Manutenção'))
);

CREATE TABLE tanque (
	idTanque INT PRIMARY KEY AUTO_INCREMENT,
    fkcliente int NOT NULL,
    constraint fk_cliente_tanque foreign key (fkcliente) references empresa (idEmpresa),
    localizacao varchar(70) not null,
	temperaturaIdealMinima DECIMAL(3,1) NOT NULL,
	temperaturaMedia DECIMAL(3,1) NOT NULL,
	temperaturaIdealMaxima DECIMAL(3,1) NOT NULL,
	qtdTruta INT NOT NULL, 
	faseTruta VARCHAR(30),
			CONSTRAINT chkFase
				CHECK(faseTruta IN('crescimento','cultivo')),
	periodoFertil BOOLEAN
);

CREATE TABLE coletaArduino (
    idColeta INT PRIMARY KEY AUTO_INCREMENT,
    fksensor INT NOT NULL,
    fkcliente int NOT NULL,
    fktanque INT NOT NULL,
    dtColeta datetime default current_timestamp,
    temperatura DECIMAL(4,1),
    alerta varchar(30) not null,
    constraint chk_alerta check(alerta in('Critico','Moderado','Estavel')),
    constraint fk_sensor_coleta foreign key (fksensor) references sensor(id_sensor),
     constraint fk_cliente_coleta foreign key (fkcliente) references empresa(idEmpresa),
      constraint fk_tanque_coleta foreign key (fktanque) references tanque(idTanque)
    );
    
    CREATE TABLE finaceiro (
	id_financeiro INT PRIMARY KEY AUTO_INCREMENT,
    fkcliente int,
	moeda VARCHAR(30) DEFAULT 'BRL',
    preco DECIMAL(10,2),
    metodo VARCHAR(30),
		CONSTRAINT chkMetodo CHECK(metodo IN ('Pix', 'Boleto', 'Débito', 'Crédito')),
	quantidadeParcela INT DEFAULT 1,
    dtContratacao DATETIME DEFAULT current_timestamp,
	constraint fkcliente_financa foreign key (fkcliente) references empresa(idEmpresa)
);
create table pagamento (
idPagamento int primary key auto_increment,
fkcliente int,
dtEnvio date,
constraint chk_envio check(dtEnvio < dtVencimento),
	dtPagamento DATE,
constraint chk_pagamento check(dtPagamento < dtVencimento),
	dtVencimento DATE,
status_pagamento VARCHAR(25) DEFAULT 'Pendente',
CONSTRAINT chkPagamento CHECK( status_pagamento IN ('Inadimplente', 'Pago', 'Cancelado', 'Pendente')),
constraint fkcliente_pag foreign key (fkcliente) references empresa (idEmpresa)
);
    

-- ------------------------------------------------------------------------------------------------------------------------
   -- INSERTS DAS TABELAS 
   
   -- TABELA EMPRESA
   
   INSERT INTO empresa (nome_empresa, representante, telefone, senha, cnpj, email, status_cliente)
VALUES
('AquaTech', 'João Silva', '11987654321', 'senha123', '12.345.678/0001-90', 'contato@aquatech.com', 'Ativo'),
('TrutaViva', 'Maria Oliveira', '21976543210', 'segura321', '98.765.432/0001-55', 'maria@trutaviva.com', 'Ativo'),
('EcoFish', 'Carlos Souza', '31965432109', 'fishpass', '11.222.333/0001-44', 'carlos@ecofish.com', 'Inativo'),
('BioÁgua', 'Fernanda Lima', '41912345678', 'bioagua2025', '22.333.444/0001-77', 'fernanda@bioagua.com', 'Ativo'),
('HydroFarm', 'Rafael Costa', '51923456789', 'hydro2025', '55.666.777/0001-22', 'rafael@hydrofarm.com', 'Ativo');

-- TABELA LOGRADOURO

INSERT INTO logradouro (pk_fk_Empresa, cep, num_endereco, bairro)
VALUES
(1, '01001-000', '123', 'Centro'),
(2, '20040-020', '456', 'Copacabana'),
(3, '30130-010', '789', 'Savassi'),
(4, '80010-150', '101', 'Centro Cívico'),
(5, '90020-090', '202', 'Moinhos de Vento');

-- TABELA SENSOR

INSERT INTO sensor (nSerie, status_sensor)
VALUES
('SN-1001', 'Ativo'),
('SN-1002', 'Inativo'),
('SN-1003', 'Ativo'),
('SN-1004', 'Manutenção'),
('SN-1005', 'Ativo');

-- TABELA TANQUE

INSERT INTO tanque (fkcliente, localizacao, temperaturaIdealMinima, temperaturaMedia, temperaturaIdealMaxima, qtdTruta, faseTruta, periodoFertil)
VALUES
(1, 'Galpão Norte', 15.0, 16.5, 18.0, 500, 'crescimento', TRUE),
(2, 'Sede Rio', 14.0, 15.2, 17.0, 600, 'cultivo', FALSE),
(3, 'Unidade BH', 13.5, 14.8, 16.5, 450, 'crescimento', TRUE),
(4, 'Estação Sul', 12.0, 13.7, 15.5, 700, 'cultivo', TRUE),
(5, 'Fazenda Porto', 15.5, 16.0, 17.5, 550, 'crescimento', FALSE);

-- TABELA COLETA

INSERT INTO coletaArduino (fksensor, fkcliente, fktanque, temperatura, alerta)
VALUES
(1, 1, 1, 16.5, 'Estavel'),
(2, 2, 2, 15.1, 'Moderado'),
(3, 3, 3, 14.7, 'Estavel'),
(4, 4, 4, 13.5, 'Critico'),
(5, 5, 5, 16.2, 'Moderado');

-- TABELA FINANCEIRO

INSERT INTO finaceiro (fkcliente, preco, metodo, quantidadeParcela)
VALUES
(1, 1500.00, 'Pix', 1),
(2, 2500.50, 'Crédito', 3),
(3, 1000.00, 'Débito', 1),
(4, 3000.75, 'Boleto', 2),
(5, 2200.00, 'Pix', 1);

-- TABELA PAGAMENTO

INSERT INTO pagamento (fkcliente, dtEnvio, dtPagamento, dtVencimento, status_pagamento)
VALUES
(1, '2025-09-01', '2025-09-05', '2025-09-10', 'Pago'),
(2, '2025-09-03', '2025-09-07', '2025-09-12', 'Pago'),
(3, '2025-09-05', NULL, '2025-09-15', 'Pendente'),
(4, '2025-09-02', '2025-09-20', '2025-09-25', 'Inadimplente'),
(5, '2025-09-04', '2025-09-08', '2025-09-15', 'Pago');






