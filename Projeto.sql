CREATE DATABASE tarefa_BD_Ex01

GO

USE tarefa_BD_Ex01

GO

CREATE TABLE projeto (
ID_projeto		int				not null	IDENTITY(10001, 1),
nome			varchar(45)		not null,
descricao		varchar(45)		not null,
data_projeto	date			not null	CHECK(data_projeto > '2014-09-01')
PRIMARY KEY(ID_projeto)
)

GO 

CREATE TABLE usuario (
ID_usuario		int				not null	IDENTITY(1, 1),
nome			varchar(45)		not null,
username		varchar(45)		not null	UNIQUE,
senha			varchar(45)		not null	DEFAULT('123Mudar'),
email			varchar(45)		not null
PRIMARY KEY (ID_usuario)
)

GO

CREATE TABLE usuario_projeto (
ID_projeto		int				not null,
ID_usuario		int				not null
PRIMARY KEY(ID_projeto, ID_usuario)
FOREIGN KEY (ID_projeto) REFERENCES projeto (ID_projeto),
FOREIGN KEY (ID_usuario) REFERENCES usuario (ID_usuario)
)

GO

DROP TABLE usuario_projeto

GO

DROP TABLE usuario

GO

CREATE TABLE usuario (
ID_usuario		int				not null	IDENTITY(1, 1),
nome			varchar(45)		not null,
username		varchar(10)		not null	UNIQUE,
senha			varchar(45)		not null	DEFAULT('123Mudar'),
email			varchar(45)		not null
PRIMARY KEY (ID_usuario)
)

GO

CREATE TABLE usuario_projeto (
ID_projeto		int				not null,
ID_usuario		int				not null
PRIMARY KEY(ID_projeto, ID_usuario)
FOREIGN KEY (ID_projeto) REFERENCES projeto (ID_projeto),
FOREIGN KEY (ID_usuario) REFERENCES usuario (ID_usuario)
)

GO

ALTER TABLE usuario
ALTER COLUMN senha	varchar(8)	not null

GO

INSERT INTO usuario (nome, username, email)VALUES
('Maria', 'Rh_maria','maria@empresa.com'),
('Ana', 'Rh_ana','ana@empresa.com'),
('Clara', 'Ti_clara','clara@empresa.com')

INSERT INTO usuario(nome, username, senha, email) VALUES
('Paulo', 'Ti_paulo', '123@456', 'paulo@empresa.com'),
('Aparecido', 'Rh_apareci', '55@!cido', 'aparecido@empresa.com')

GO

INSERT INTO projeto (nome, descricao, data_projeto)VALUES
('Re-folha', 'Refatoração das Folhas', '2014-09-05'),
('Manutenção PCS', 'Manutenção PCS', '2014-09-06'),
('Auditoria', 'NULL', '2014-09-07')

GO 

INSERT INTO usuario_projeto (ID_usuario, ID_projeto)VALUES
(1, 10001),
(5, 10001),
(3, 10003),
(4, 10002),
(2, 10002)

GO

UPDATE projeto
SET data_projeto = '2014-09-12'
WHERE ID_projeto = 10002

UPDATE usuario
SET username = 'Rh_cido'
WHERE nome = 'Aparecido'

UPDATE usuario
SET senha = '888@*'
WHERE nome = 'Maria' AND senha = '123Mudar'

DELETE usuario_projeto
WHERE ID_usuario = 2

SELECT ID_usuario, nome, email, username, 
		Passwrd = CASE senha 
		WHEN '123Mudar' THEN 
			senha 
		ELSE 
			'********' 
		END
FROM usuario

GO

SELECT nome, descricao, data_projeto,
	   CONVERT(CHAR(10), DATEADD(DAY, 15, data_projeto), 103) AS Data_Final
FROM projeto
WHERE ID_projeto IN
(
	SELECT ID_projeto
	FROM usuario_projeto
	WHERE ID_usuario IN
	(
			SELECT ID_usuario
			FROM usuario
			WHERE email = 'aparecido@empresa.com'
	)
)

GO

SELECT nome, email
FROM usuario
WHERE ID_usuario IN
(
	SELECT ID_usuario
	FROM usuario_projeto
	WHERE ID_projeto IN
	(	
		SELECT ID_projeto
		FROM projeto
		WHERE nome = 'Auditoria'
	)
)

GO

SELECT nome, descricao, data_projeto, '2014-09-16' AS Data_Final,
	   DATEDIFF(DAY, data_projeto, '2014-09-16') * 79.85 AS Custo_Total
FROM projeto
WHERE nome LIKE 'Manutenção%'
	
 

select * from projeto
select * from usuario
SELECT * FROM usuario_projeto


