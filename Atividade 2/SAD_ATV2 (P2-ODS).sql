-- Criando o Banco de Dados
CREATE DATABASE BD_Atividade2;

-- Criando o ODS
-- Esse banco de dados foi criado com base no original da atividade, com algumas mudanças de tipos de dados,  
-- melhoria de suas nomenclaturas de tabelas e colunas e por fim aperfeiçoamento dos contéudo dos dados.

-- Definindo o Banco de Dados para Uso
USE BD_Atividade2;

-- tbvdd foi renomeado para (Tabela de Vendedores)
-- tbdep foi renomeado para (Tabela de Dependentes)
-- tbpro foi renomeado para (Tabela de Produtos)
-- tbven foi renomeado para (Tabela de Vendas)
-- tbven_item foi renomeado para (Tabela de Itens de Venda)

-- Criando a Tabela de Vendedores

-- Modificações de nomenclatura das colunas:
-- cdvdd -> ID_Vendedor, nmvdd -> Nome, sxvdd -> Sexo,
-- perccomissao -> Percentual_Comissao, matfunc -> Matricula

CREATE TABLE Vendedores (
   ID_Vendedor      smallint IDENTITY(1,1) PRIMARY KEY,
   Nome             varchar(50),
   Sexo             char(1), -- Padronizado
   Percentual_Comissao decimal(19,2),
   Matricula smallint not null
); 

-- Criando a Tabela de Dependentes
CREATE TABLE Dependentes (
   ID_Dependente    INT IDENTITY(1,1) PRIMARY KEY,
   Nome             varchar(50),
   Data_Nascimento  date,
   Sexo             char(1),
   ID_Vendedor      smallint,
   InepEscola       varchar(10) UNIQUE, -- Evitar duplicidade
   CONSTRAINT FK_Dependente_Vendedor FOREIGN KEY (ID_Vendedor) REFERENCES Vendedores (ID_Vendedor)
);

-- Criando a Tabela de Produtos
CREATE TABLE Produtos(
    ID_Produto      INT IDENTITY(1,1) PRIMARY KEY,
    Nome            varchar(50) NULL,
    Tipo            varchar(1) NULL,
    Unidade         varchar(2) NULL,
    Saldo           int NULL,
    Status          varchar(50) NULL
);

-- Criando a Tabela de Clientes (Nova)
CREATE TABLE Clientes (
    ID_Cliente smallint PRIMARY KEY,
    Nome varchar(50),
    Idade smallint,
    Classificacao smallint,
    Sexo char(1),
    Cidade varchar(50),
    Estado varchar(50),
    Pais varchar(50)
);

-- Criando a Tabela de Venda
CREATE TABLE Venda(
    ID_Venda         smallint PRIMARY KEY,
    Data_Venda       date NULL,
    ID_Cliente       smallint NULL,
    Canal_Venda      varchar(12) NOT NULL,
    Status_Venda     smallint NULL,
    ID_Vendedor      smallint NULL,
    CONSTRAINT FK_Venda_Vendedor FOREIGN KEY (ID_Vendedor) REFERENCES Vendedores (ID_Vendedor),
    CONSTRAINT FK_Venda_Cliente FOREIGN KEY (ID_Cliente) REFERENCES Clientes(ID_Cliente)
);

-- Criando a Tabela Item de Venda
CREATE TABLE Item_Venda(
    ID_Item_Venda    smallint PRIMARY KEY,
    ID_Produto       INT NULL,
    Quantidade_Venda int NULL,
    Valor_Unitario   decimal(18, 2) NULL,
    Valor_Total      AS (Quantidade_Venda * Valor_Unitario), -- Mudança para já compor o cálculo do Valor Total
    ID_Venda         smallint NULL,
    CONSTRAINT FK_ItemVenda_Produto FOREIGN KEY (ID_Produto) REFERENCES Produtos (ID_Produto),
    CONSTRAINT FK_ItemVenda_Venda FOREIGN KEY (ID_Venda) REFERENCES Venda (ID_Venda)
);
