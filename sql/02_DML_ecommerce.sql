USE ecommerce;

-- =========================================================
-- CLIENTES
-- =========================================================
INSERT INTO Cliente (nome, email, telefone) VALUES
('Carlos Almeida', 'carlos.almeida@email.com', '(41)99999-1111'),
('Fernanda Souza', 'fernanda.souza@email.com', '(41)98888-2222'),
('Marcos Lima', 'marcos.lima@email.com', '(41)97777-3333'),
('Juliana Costa', 'juliana.costa@email.com', '(41)96666-4444'),
('Loja Tech Solutions', 'contato@techsolutions.com', '(11)4002-8922'),
('Mercado Bom Preço LTDA', 'vendas@bombpreco.com', '(11)4040-3030'),
('Construtora Alpha S.A.', 'contato@alphasa.com', '(21)90000-5050'),
('Patrícia Ribeiro', 'patricia.ribeiro@email.com', '(41)95555-8888'),
('Guilherme Tavares', 'guilherme.tavares@email.com', '(41)94444-7777'),
('Eduardo Nascimento', 'eduardo.nascimento@email.com', '(41)93333-6666'),
('Clínica Vida Plena LTDA', 'contato@vidaplena.com', '(11)4200-2222'),
('Auto Center SpeedCar', 'speedcar@contato.com', '(21)4004-5050'),
-- novos clientes sem pedidos
('Laura Martins', 'laura.martins@email.com', '(41)92222-1111'),
('João Vitor Ribeiro', 'joao.vitor@email.com', '(41)97777-8888'),
('SuperTech Automação LTDA', 'contato@supertech.com', '(11)4141-2222'),
('Delícias do Campo LTDA', 'vendas@deliciasdocampo.com', '(31)3003-3030');

-- =========================================================
-- PESSOAS FÍSICAS
-- =========================================================
INSERT INTO ClientePF (id_cliente, cpf, data_nascimento) VALUES
(1, '12345678901', '1988-05-21'),
(2, '23456789012', '1992-08-12'),
(3, '34567890123', '1985-03-17'),
(4, '45678901234', '1990-10-30'),
(8, '56789012345', '1989-09-15'),
(9, '67890123456', '1995-12-20'),
(10, '78901234567', '1983-07-09'),
(13, '89012345678', '1996-04-18'),
(14, '90123456789', '1999-01-12');

-- =========================================================
-- PESSOAS JURÍDICAS
-- =========================================================
INSERT INTO ClientePJ (id_cliente, cnpj, razao_social, inscricao_estadual) VALUES
(5, '11222333000181', 'Tech Solutions LTDA', 'ISENTO'),
(6, '22333444000192', 'Mercado Bom Preço LTDA', '123.456.789.000'),
(7, '33444555000103', 'Construtora Alpha S.A.', '987.654.321.000'),
(11, '44555666000114', 'Clínica Vida Plena LTDA', 'ISENTO'),
(12, '55666777000125', 'Auto Center SpeedCar', '101.202.303.404'),
(15, '66777888000199', 'SuperTech Automação LTDA', 'ISENTO'),
(16, '77888999000100', 'Delícias do Campo LTDA', 'ISENTO');

-- =========================================================
-- ENDEREÇOS
-- =========================================================
INSERT INTO Endereco (id_cliente, logradouro, numero, complemento, bairro, cidade, estado, cep) VALUES
(1, 'Rua das Flores', '123', 'Ap 12', 'Centro', 'Curitiba', 'PR', '80000000'),
(2, 'Av. Brasil', '456', NULL, 'Centro', 'Londrina', 'PR', '86000000'),
(3, 'Rua Paraná', '789', 'Casa', 'Jardim das Américas', 'Maringá', 'PR', '87000000'),
(4, 'Rua XV de Novembro', '321', NULL, 'Centro', 'Ponta Grossa', 'PR', '84000000'),
(5, 'Rua dos Inovadores', '500', NULL, 'Tech Park', 'São Paulo', 'SP', '01000000'),
(6, 'Rua das Ofertas', '222', NULL, 'Comércio', 'Campinas', 'SP', '13000000'),
(7, 'Av. das Construções', '999', NULL, 'Industrial', 'Rio de Janeiro', 'RJ', '20000000'),
(8, 'Rua Bela Vista', '400', NULL, 'Centro', 'Joinville', 'SC', '89200000'),
(9, 'Av. Atlântica', '900', NULL, 'Balneário', 'Camboriú', 'SC', '88330000'),
(10, 'Rua Verde Vale', '75', 'Casa', 'Campo Belo', 'São José dos Pinhais', 'PR', '83000000'),
(11, 'Av. Paulista', '1200', NULL, 'Bela Vista', 'São Paulo', 'SP', '01310000'),
(12, 'Av. das Indústrias', '550', NULL, 'Centro', 'Volta Redonda', 'RJ', '27200000'),
(13, 'Rua Monte Alegre', '321', NULL, 'Centro', 'Ponta Grossa', 'PR', '84005000'),
(14, 'Rua das Flores', '800', NULL, 'Centro', 'Lapa', 'PR', '83750000'),
(15, 'Rua Inovação', '450', NULL, 'TecPark', 'São Paulo', 'SP', '01100000'),
(16, 'Rodovia BR-381', '1000', NULL, 'Zona Rural', 'Belo Horizonte', 'MG', '31000000');

-- =========================================================
-- FORMAS DE PAGAMENTO
-- =========================================================
INSERT INTO FormaPagamento (tipo) VALUES
('Cartão de Crédito'),
('Cartão de Débito'),
('Pix'),
('Boleto'),
('Transferência');

-- =========================================================
-- PRODUTOS
-- =========================================================
-- =========================================================
-- PRODUTOS
-- =========================================================
INSERT INTO Produto (nome, descricao, preco, estoque, categoria) VALUES
('Notebook Dell Inspiron', 'Notebook 15" com processador i7 e SSD 512GB', 4800.00, 12, 'Informática'),
('Smartphone Samsung S23', 'Celular 128GB 5G', 3600.00, 20, 'Telefonia'),
('Mouse Gamer Logitech', 'Mouse óptico RGB 12000dpi', 250.00, 35, 'Acessórios'),
('Teclado Mecânico Redragon', 'Switch Blue ABNT2', 320.00, 28, 'Acessórios'),
('Monitor LG 27"', 'Monitor IPS Full HD', 1200.00, 14, 'Informática'),
('Headset HyperX Cloud', 'Fone gamer com microfone removível', 450.00, 25, 'Acessórios'),
('Cadeira Gamer ThunderX3', 'Cadeira ergonômica preta/vermelha', 1350.00, 10, 'Móveis'),
('HD Externo Seagate 2TB', 'USB 3.0', 550.00, 20, 'Informática'),
('Pendrive Kingston 64GB', 'USB 3.1 alta velocidade', 80.00, 60, 'Acessórios'),
('Impressora HP DeskJet', 'Multifuncional jato de tinta Wi-Fi', 600.00, 12, 'Periféricos'),
('Caixa de Som JBL Go 3', 'Bluetooth portátil', 280.00, 30, 'Áudio'),
('Smartwatch Amazfit Bip', 'Relógio inteligente com GPS', 500.00, 18, 'Wearables'),
('Tablet Lenovo M10', '10.1", 64GB, Android 12', 1100.00, 11, 'Tablets'),
('Roteador TP-Link AX3000', 'Wi-Fi 6 Dual Band', 700.00, 14, 'Redes'),
('Webcam Logitech C920', 'Full HD 1080p com microfone estéreo', 420.00, 20, 'Acessórios'),
('Cadeira Escritório Ergonômica', 'Ajuste lombar e altura, base cromada', 890.00, 10, 'Móveis'),
('Microfone Condensador Fifine', 'USB plug and play', 480.00, 20, 'Áudio'),
('SSD Kingston 1TB', 'Leitura 3500MB/s NVMe', 720.00, 15, 'Informática'),
('Teclado Sem Fio Logitech', 'Compacto com receptor USB', 180.00, 25, 'Acessórios'),
('Monitor Dell Ultrasharp 32"', '4K, HDR, ajuste de altura', 3400.00, 8, 'Informática'),
('Hub USB-C Baseus', '7 portas, HDMI e PD', 210.00, 20, 'Acessórios'),
('Suporte Notebook Regulável', 'Alumínio, ergonômico', 140.00, 30, 'Acessórios'),
('Estabilizador APC 600VA', 'Proteção contra surtos elétricos', 390.00, 10, 'Periféricos'),
('Impressora Laser Brother', 'Alta velocidade, toner incluso', 980.00, 7, 'Periféricos'),
('Projetor Epson X10', 'Full HD, 3500 lumens', 2500.00, 5, 'Eletrônicos');

-- =========================================================
-- PEDIDOS (25 pedidos para dar mais volume às análises)
-- =========================================================
INSERT INTO Pedido (id_cliente, id_pagamento, data_pedido, status, valor_frete) VALUES
(1, 1, '2025-09-02 10:30:00', 'Pago', 35.00),
(2, 3, '2025-09-05 14:10:00', 'Entregue', 25.00),
(3, 2, '2025-09-10 09:00:00', 'Enviado', 40.00),
(4, 4, '2025-09-15 11:45:00', 'Cancelado', 0.00),
(5, 5, '2025-09-20 15:00:00', 'Em Processamento', 55.00),
(6, 2, '2025-09-25 13:15:00', 'Pago', 30.00),
(7, 3, '2025-09-28 16:20:00', 'Pago', 60.00),
(8, 1, '2025-10-01 09:10:00', 'Entregue', 25.00),
(9, 4, '2025-10-03 10:40:00', 'Pago', 30.00),
(10, 5, '2025-10-05 12:25:00', 'Cancelado', 0.00),
(11, 2, '2025-10-07 08:45:00', 'Pago', 35.00),
(12, 3, '2025-10-08 15:30:00', 'Entregue', 20.00),
(1, 4, '2025-10-10 14:00:00', 'Pago', 25.00),
(3, 5, '2025-10-12 10:15:00', 'Enviado', 40.00),
(2, 3, '2025-10-14 16:10:00', 'Pago', 35.00),
(8, 1, '2025-10-15 11:05:00', 'Em Processamento', 50.00),
(9, 2, '2025-10-17 09:50:00', 'Pago', 30.00),
(10, 3, '2025-10-18 13:20:00', 'Entregue', 25.00),
(11, 1, '2025-10-20 15:40:00', 'Pago', 40.00),
(12, 5, '2025-10-21 10:00:00', 'Em Processamento', 45.00),
(5, 1, '2025-10-22 10:15:00', 'Entregue', 30.00),
(6, 2, '2025-10-23 11:00:00', 'Pago', 30.00),
(7, 3, '2025-10-24 12:30:00', 'Pago', 35.00),
(8, 1, '2025-10-25 14:15:00', 'Pago', 25.00),
(9, 4, '2025-10-26 09:45:00', 'Cancelado', 0.00);

-- =========================================================
-- ITENS DE PEDIDO
-- =========================================================
-- (mantém padrão de distribuição equilibrada e variedade de produtos)
-- =========================================================
INSERT INTO ItemPedido (id_pedido, id_produto, quantidade, preco_unitario) VALUES
(1, 1, 1, 4800.00), (1, 3, 1, 250.00),
(2, 2, 1, 3600.00), (2, 9, 2, 80.00),
(3, 5, 1, 1200.00), (3, 6, 1, 450.00),
(4, 7, 1, 1350.00),
(5, 10, 1, 600.00), (5, 14, 1, 700.00),
(6, 8, 1, 550.00), (6, 12, 1, 500.00),
(7, 15, 1, 420.00), (7, 9, 3, 80.00),
(8, 11, 2, 280.00), (8, 13, 1, 1100.00),
(9, 18, 1, 720.00), (9, 19, 1, 180.00),
(10, 20, 1, 3400.00),
(11, 4, 1, 320.00), (11, 5, 1, 1200.00),
(12, 17, 1, 480.00), (12, 23, 1, 390.00),
(13, 2, 1, 3600.00),
(14, 21, 1, 210.00), (14, 22, 1, 140.00),
(15, 3, 2, 250.00), (15, 18, 1, 720.00),
(16, 6, 1, 450.00), (16, 9, 5, 80.00),
(17, 10, 1, 600.00), (17, 14, 1, 700.00),
(18, 24, 1, 980.00), (18, 25, 1, 2500.00),
(19, 1, 1, 4800.00), (19, 7, 1, 1350.00),
(20, 11, 1, 280.00), (20, 13, 1, 1100.00),
(21, 8, 2, 550.00),
(22, 12, 1, 500.00), (22, 15, 1, 420.00),
(23, 19, 1, 180.00), (23, 3, 2, 250.00),
(24, 9, 5, 80.00), (24, 6, 1, 450.00),
(25, 4, 1, 320.00), (25, 5, 1, 1200.00);

-- =========================================================
-- ENTREGAS (sem incluir pedidos cancelados)
-- =========================================================
INSERT INTO Entrega (id_pedido, codigo_rastreio, status_entrega, data_envio, data_entrega) VALUES
(1, 'BR100000001BR', 'Entregue', '2025-09-03', '2025-09-06'),
(2, 'BR100000002BR', 'Entregue', '2025-09-06', '2025-09-09'),
(3, 'BR100000003BR', 'Em Transporte', '2025-09-11', NULL),
(5, 'BR100000005BR', 'Pendente', NULL, NULL),
(6, 'BR100000006BR', 'Entregue', '2025-09-26', '2025-09-29'),
(7, 'BR100000007BR', 'Em Transporte', '2025-09-29', NULL),
(8, 'BR100000008BR', 'Entregue', '2025-10-02', '2025-10-04'),
(9, 'BR100000009BR', 'Entregue', '2025-10-04', '2025-10-07'),
(11, 'BR100000011BR', 'Pendente', NULL, NULL),
(12, 'BR100000012BR', 'Entregue', '2025-10-09', '2025-10-11'),
(13, 'BR100000013BR', 'Em Transporte', '2025-10-11', NULL),
(14, 'BR100000014BR', 'Pendente', NULL, NULL),
(15, 'BR100000015BR', 'Entregue', '2025-10-15', '2025-10-18'),
(16, 'BR100000016BR', 'Pendente', NULL, NULL),
(17, 'BR100000017BR', 'Entregue', '2025-10-17', '2025-10-20'),
(18, 'BR100000018BR', 'Entregue', '2025-10-19', '2025-10-22'),
(19, 'BR100000019BR', 'Em Transporte', '2025-10-21', NULL),
(20, 'BR100000020BR', 'Pendente', NULL, NULL),
(21, 'BR100000021BR', 'Entregue', '2025-10-23', '2025-10-26'),
(22, 'BR100000022BR', 'Entregue', '2025-10-23', '2025-10-26'),
(23, 'BR100000023BR', 'Em Transporte', '2025-10-24', NULL),
(24, 'BR100000024BR', 'Pendente', NULL, NULL),
(25, 'BR100000025BR', 'Pendente', NULL, NULL);