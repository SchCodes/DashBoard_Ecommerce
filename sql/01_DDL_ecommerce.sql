DROP DATABASE IF EXISTS ecommerce;
CREATE DATABASE ecommerce CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci;
USE ecommerce;

-- TABELA: CLIENTE
CREATE TABLE Cliente (
    id_cliente INT AUTO_INCREMENT PRIMARY KEY,
    nome VARCHAR(150) NOT NULL,
    email VARCHAR(150) NOT NULL UNIQUE,
    telefone VARCHAR(15),
    data_cadastro DATETIME DEFAULT CURRENT_TIMESTAMP
);

-- TABELA: CLIENTE PESSOA FÍSICA
CREATE TABLE ClientePF (
    id_cliente INT PRIMARY KEY,
    cpf CHAR(11) NOT NULL UNIQUE,
    data_nascimento DATE NOT NULL,
    CONSTRAINT fk_cliente_pf FOREIGN KEY (id_cliente)
        REFERENCES Cliente(id_cliente)
        ON DELETE CASCADE
);

-- TABELA: CLIENTE PESSOA JURÍDICA
CREATE TABLE ClientePJ (
    id_cliente INT PRIMARY KEY,
    cnpj CHAR(14) NOT NULL UNIQUE,
    razao_social VARCHAR(150) NOT NULL,
    inscricao_estadual VARCHAR(20),
    CONSTRAINT fk_cliente_pj FOREIGN KEY (id_cliente)
        REFERENCES Cliente(id_cliente)
        ON DELETE CASCADE
);

-- TABELA: ENDERECO
CREATE TABLE Endereco (
    id_endereco INT AUTO_INCREMENT PRIMARY KEY,
    id_cliente INT NOT NULL,
    logradouro VARCHAR(150) NOT NULL,
    numero VARCHAR(10),
    complemento VARCHAR(50),
    bairro VARCHAR(50),
    cidade VARCHAR(50) NOT NULL,
    estado CHAR(2) NOT NULL,
    cep CHAR(8) NOT NULL,
    CONSTRAINT fk_endereco_cliente FOREIGN KEY (id_cliente)
        REFERENCES Cliente(id_cliente)
        ON DELETE CASCADE
);

-- TABELA: PRODUTO
CREATE TABLE Produto (
    id_produto INT AUTO_INCREMENT PRIMARY KEY,
    nome VARCHAR(150) NOT NULL,
    descricao TEXT,
    preco DECIMAL(10,2) NOT NULL,
    estoque INT DEFAULT 0,
    categoria VARCHAR(50)
);

-- TABELA: FORMA DE PAGAMENTO
CREATE TABLE FormaPagamento (
    id_pagamento INT AUTO_INCREMENT PRIMARY KEY,
    tipo ENUM('Cartão de Crédito', 'Cartão de Débito', 'Pix', 'Boleto', 'Transferência') NOT NULL
);

-- TABELA: PEDIDO
CREATE TABLE Pedido (
    id_pedido INT AUTO_INCREMENT PRIMARY KEY,
    id_cliente INT NOT NULL,
    id_pagamento INT NOT NULL,
    data_pedido DATETIME DEFAULT CURRENT_TIMESTAMP,
    status ENUM('Em Processamento','Pago','Enviado','Entregue','Cancelado') DEFAULT 'Em Processamento',
    valor_frete DECIMAL(10,2) DEFAULT 0.00,
    CONSTRAINT fk_pedido_cliente FOREIGN KEY (id_cliente)
        REFERENCES Cliente(id_cliente)
        ON DELETE CASCADE,
    CONSTRAINT fk_pedido_pagamento FOREIGN KEY (id_pagamento)
        REFERENCES FormaPagamento(id_pagamento)
);

-- TABELA: ITEM DO PEDIDO
CREATE TABLE ItemPedido (
    id_item INT AUTO_INCREMENT PRIMARY KEY,
    id_pedido INT NOT NULL,
    id_produto INT NOT NULL,
    quantidade INT NOT NULL CHECK (quantidade > 0),
    preco_unitario DECIMAL(10,2) NOT NULL,
    CONSTRAINT fk_item_pedido FOREIGN KEY (id_pedido)
        REFERENCES Pedido(id_pedido)
        ON DELETE CASCADE,
    CONSTRAINT fk_item_produto FOREIGN KEY (id_produto)
        REFERENCES Produto(id_produto)
);

-- TABELA: ENTREGA
CREATE TABLE Entrega (
    id_entrega INT AUTO_INCREMENT PRIMARY KEY,
    id_pedido INT NOT NULL,
    codigo_rastreio VARCHAR(50),
    status_entrega ENUM('Pendente','Em Transporte','Entregue','Devolvido') DEFAULT 'Pendente',
    data_envio DATETIME,
    data_entrega DATETIME,
    CONSTRAINT fk_entrega_pedido FOREIGN KEY (id_pedido)
        REFERENCES Pedido(id_pedido)
        ON DELETE CASCADE
);

-- TABELA: LOG DE AÇÕES (auditoria LGPD)
CREATE TABLE Log_Acoes (
    id_log INT AUTO_INCREMENT PRIMARY KEY,
    acao VARCHAR(100),
    id_afetado INT,
    data_acao DATETIME DEFAULT CURRENT_TIMESTAMP
);

-- TRIGGERS DE ANONIMIZAÇÃO E LOG
DELIMITER $$

-- Antes de excluir o cliente: registra evento de anonimização
CREATE TRIGGER tr_anonimiza_cliente
BEFORE DELETE ON Cliente
FOR EACH ROW
BEGIN
    INSERT INTO Log_Acoes (acao, id_afetado, data_acao)
    VALUES ('Anonimização Cliente', OLD.id_cliente, NOW());
END$$

-- Após a exclusão do cliente: registra evento final
CREATE TRIGGER tr_log_exclusao
AFTER DELETE ON Cliente
FOR EACH ROW
BEGIN
    INSERT INTO Log_Acoes (acao, id_afetado, data_acao)
    VALUES ('Exclusão Cliente', OLD.id_cliente, NOW());
END$$

DELIMITER ;