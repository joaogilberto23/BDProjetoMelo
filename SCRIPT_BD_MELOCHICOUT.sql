SET LANGUAGE 'brazilian'
USE master;

------------------------------------------------------------

IF DB_ID('MELOCHICOUT') IS NOT NULL
	DROP DATABASE MELOCHICOUT;
	CREATE DATABASE MELOCHICOUT;
GO
USE MELOCHICOUT;

------------------------------------------------------------

CREATE TABLE usuario (
id_usuario			INTEGER			NOT NULL	IDENTITY(1,1)	PRIMARY KEY,
tipo_usuario		CHAR(3)			NOT NULL,
nome				VARCHAR(150)	NOT NULL,
login				VARCHAR(50)		NOT NULL	UNIQUE,
senha				VARCHAR(20)		NOT NULL,
cpf					VARCHAR(11)		NOT NULL	UNIQUE,
email				VARCHAR(150)	NOT NULL	UNIQUE,
data_nascimento		DATE			NOT NULL,
tel_celular			VARCHAR(12)		NOT NULL,
tel_fixo			VARCHAR(12),
CONSTRAINT ck_tipo_usuario	CHECK(tipo_usuario IN ('ADM','CLI')), --permite apenas estes dois tipos de usuários
CONSTRAINT ck_email01 CHECK (email like '[a-z,0-9,_,-]%@[a-z,0-9,_,-]%.[a-z]%'), -- exige formato: [letras-numeros-underline-traço] + [qualquer coisa] + [@] + [letras-numeros-underline-traço] + [qualquer coisa] + [.] + [letras] + qualquer coisa
CONSTRAINT ck_email02 CHECK (email not like '%[^a-z0-9@._-]%'), -- impede caracteres que não sejam: a-z 0-9 @ . _ -
CONSTRAINT ck_email03 CHECK (email not like '%@%@%'), -- impede dois arrobas
CONSTRAINT ck_email04 CHECK (email not like '%.@%'), -- impede .@
CONSTRAINT ck_email05 CHECK (email not like '%..%'), -- impede ..
CONSTRAINT ck_email06 CHECK (email not like '%.') -- impede terminar com .
)

------------------------------------------------------------

CREATE TABLE endereco (
id_endereco		INTEGER			NOT NULL	IDENTITY(1,1)		PRIMARY KEY,
id_usuario		INTEGER			NOT NULL,
logradouro		VARCHAR(150)	NOT NULL,
numero			INTEGER			NOT NULL,
cidade			VARCHAR(20)		NOT NULL,
bairro			VARCHAR(50)		NOT NULL,
estado			CHAR(2)			NOT NULL,
cep				INTEGER			NOT NULL,
complemento		VARCHAR(150),
referencia		VARCHAR(150),
FOREIGN KEY(id_usuario) REFERENCES usuario(id_usuario)
)

------------------------------------------------------------

CREATE TABLE formaPagamento (
id_formaPagamento	INTEGER		NOT NULL	IDENTITY(1,1)	PRIMARY KEY,
descricao_fp		VARCHAR(50)	NOT NULL,
tipo_fp				VARCHAR(50)	NOT NULL
)

------------------------------------------------------------

CREATE TABLE pedido (
id_pedido				INTEGER		NOT NULL	IDENTITY(1,1)	PRIMARY KEY,
id_usuario				INTEGER		NOT NULL,
id_formaPagamento		INTEGER		NOT NULL,
data_pedido				DATE		NOT NULL,
data_entrega			DATE,
valor_pedido			FLOAT		NOT NULL,
FOREIGN KEY(id_usuario)			REFERENCES usuario(id_usuario),
FOREIGN KEY(id_formaPagamento)	REFERENCES formaPagamento(id_formaPagamento),
CONSTRAINT ck_valor_pedido	CHECK(valor_pedido > 0)
)

------------------------------------------------------------

CREATE TABLE categoria (
id_categoria	INTEGER		NOT NULL	IDENTITY(1,1)	PRIMARY KEY,
tipo_categoria	VARCHAR(50)	NOT NULL
)

------------------------------------------------------------

CREATE TABLE produto (
id_produto		INTEGER			NOT NULL	IDENTITY(1,1)	PRIMARY KEY,
id_categoria	INTEGER			NOT NULL,
nome			VARCHAR(150)	NOT NULL,
valor_produto	FLOAT			NOT NULL,
estoque			INTEGER			NOT NULL,
tamanho			CHAR(3),
FOREIGN KEY(id_categoria)		REFERENCES categoria(id_categoria),
CONSTRAINT ck_tamanho		CHECK(tamanho IN ('P','M','G','GG')),
CONSTRAINT ck_valor_produto	CHECK(valor_produto > 0)
)

------------------------------------------------------------

CREATE TABLE itensPedido (
id_pedido	INTEGER		NOT NULL,
id_produto	INTEGER		NOT NULL,
quantidade	INTEGER		NOT NULL,
valor_itens FLOAT		NOT NULL,
FOREIGN KEY(id_pedido)	REFERENCES pedido(id_pedido),
FOREIGN KEY(id_produto) REFERENCES produto(id_produto),
CONSTRAINT ck_quantidade	CHECK(quantidade > 0),
CONSTRAINT ck_valor_itens	CHECK(quantidade > 0)
);