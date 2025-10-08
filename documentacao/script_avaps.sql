-- ===========================
-- CRIAÇÃO DAS TABELAS
-- ===========================

-- Produto (Tênis de Vôlei)
CREATE TABLE Produto (
    id_tenis SERIAL PRIMARY KEY,
    nome_tenis VARCHAR(45) NOT NULL,
    tamanho_disponivel VARCHAR(10),
    quantidade_em_estoque INT NOT NULL,
    preco_unitario DOUBLE PRECISION NOT NULL,
    imagem_url VARCHAR(255) -- coluna para armazenar o endereço da imagem
);
-- Forma de Pagamento
CREATE TABLE FormaDePagamento (
    id_forma_pagamento SERIAL PRIMARY KEY,
    nome_forma_pagamento VARCHAR(100) NOT NULL
);

-- Cargo
CREATE TABLE Cargo (
    id_cargo SERIAL PRIMARY KEY,
    nome_cargo VARCHAR(45) NOT NULL
);

-- Pessoa
CREATE TABLE Pessoa (
    id_pessoa SERIAL PRIMARY KEY,
    nome_pessoa VARCHAR(60) NOT NULL,
    email_pessoa VARCHAR(70) NOT NULL UNIQUE,
    id_pedido_atual INT,
    senha_pessoa VARCHAR(32) NOT NULL,
    data_nascimento_pessoa DATE NOT NULL,
    endereco VARCHAR(200) NOT NULL
);

-- Cliente
CREATE TABLE Cliente (
    id_pessoa INT PRIMARY KEY,
    renda_cliente DOUBLE PRECISION,
    data_de_cadastro_cliente DATE,
    FOREIGN KEY (id_pessoa) REFERENCES Pessoa(id_pessoa) ON DELETE CASCADE
);

-- Funcionário
CREATE TABLE Funcionario (
    id_pessoa INT PRIMARY KEY,
    salario DOUBLE PRECISION,
    cargo_id_cargo INT,
    porcentagem_comissao DOUBLE PRECISION,
    FOREIGN KEY (id_pessoa) REFERENCES Pessoa(id_pessoa) ON DELETE CASCADE,
    FOREIGN KEY (cargo_id_cargo) REFERENCES Cargo(id_cargo)
);

-- Pedido
CREATE TABLE Pedido (
    id_pedido SERIAL PRIMARY KEY,
    data_do_pedido DATE NOT NULL,
    id_cliente INT,
    id_funcionario INT,
    FOREIGN KEY (id_cliente) REFERENCES Cliente(id_pessoa) ON DELETE CASCADE,
    FOREIGN KEY (id_funcionario) REFERENCES Funcionario(id_pessoa) ON DELETE CASCADE
);

-- Pagamento
CREATE TABLE Pagamento (
    id_pedido INT PRIMARY KEY,
    data_pagamento TIMESTAMP,
    valor_total_pagamento DOUBLE PRECISION,
    status_pagamento VARCHAR(32) NOT NULL,
    FOREIGN KEY (id_pedido) REFERENCES Pedido(id_pedido) ON DELETE CASCADE
);

-- PedidoHasTenis (N:N Pedido x Produto)
CREATE TABLE PedidoHasTenis (
    id_tenis INT,
    id_pedido INT,
    quantidade INT,
    preco_unitario DOUBLE PRECISION,
    PRIMARY KEY (id_tenis, id_pedido),
    FOREIGN KEY (id_tenis) REFERENCES Produto(id_tenis)  ON DELETE CASCADE,
    FOREIGN KEY (id_pedido) REFERENCES Pedido(id_pedido) ON DELETE CASCADE
);

-- PagamentoHasFormaPagamento (N:N Pagamento x FormaPagamento)
CREATE TABLE PagamentoHasFormaPagamento (
    id_pedido INT,
    id_forma_pagamento INT,
    valor_pago DOUBLE PRECISION,
    PRIMARY KEY (id_pedido, id_forma_pagamento),
    FOREIGN KEY (id_pedido) REFERENCES Pagamento(id_pedido) ON DELETE CASCADE,
    FOREIGN KEY (id_forma_pagamento) REFERENCES FormaDePagamento(id_forma_pagamento)
);

-- ===========================
-- INSERTS
-- ===========================

-- Produtos (10 registros)
INSERT INTO Produto (nome_tenis, tamanho_disponivel, quantidade_em_estoque, preco_unitario) VALUES
('Tênis Pro Attack', '38-44', 50, 299.90),
('Tênis Smash Pro', '36-42', 40, 259.50),
('Tênis Volley Master', '37-44', 30, 349.99),
('Tênis Jump Force', '39-43', 25, 279.00),
('Tênis Power Spike', '38-44', 60, 319.75),
('Tênis Air Block', '37-41', 35, 239.90),
('Tênis Fast Court', '39-45', 45, 359.99),
('Tênis Impact Max', '36-42', 55, 269.90),
('Tênis Ultra Volley', '38-44', 20, 389.00),
('Tênis Light Speed', '37-42', 28, 299.00);

-- Formas de Pagamento (10 registros)
INSERT INTO FormaDePagamento (nome_forma_pagamento) VALUES
('Cartão de Crédito'),
('Cartão de Débito'),
('Pix'),
('Boleto Bancário'),
('Transferência'),
('Dinheiro'),
('Vale Presente'),
('Carteira Digital'),
('Cheque'),
('Crediário');

-- Cargos (10 registros)
INSERT INTO Cargo (nome_cargo) VALUES
('Vendedor'),
('Gerente'),
('Caixa'),
('Estoquista'),
('Assistente de Vendas'),
('Supervisor'),
('Atendente Online'),
('Administrador'),
('Analista de Marketing'),
('Auxiliar de Limpeza');

-- Pessoas (10 registros)
INSERT INTO Pessoa (nome_pessoa, email_pessoa, senha_pessoa, data_nascimento_pessoa, endereco) VALUES
('João Silva', 'joao.silva@email.com', 'senha123', '1990-05-12', 'Rua das Palmeiras, 100 - São Paulo - SP'),
('Maria Oliveira', 'maria.oliveira@email.com', 'senha123', '1985-03-20', 'Av. Brasil, 2000 - Rio de Janeiro - RJ'),
('Carlos Souza', 'carlos.souza@email.com', 'senha123', '1992-07-08', 'Rua XV de Novembro, 150 - Curitiba - PR'),
('Ana Pereira', 'ana.pereira@email.com', 'senha123', '1998-11-25', 'Av. Independência, 500 - Belo Horizonte - MG'),
('Lucas Fernandes', 'lucas.fernandes@email.com', 'senha123', '2000-02-10', 'Rua das Flores, 75 - Florianópolis - SC'),
('Mariana Costa', 'mariana.costa@email.com', 'senha123', '1995-09-18', 'Av. Goiás, 800 - Goiânia - GO'),
('Rafael Gomes', 'rafael.gomes@email.com', 'senha123', '1988-06-01', 'Rua Bahia, 250 - Salvador - BA'),
('Juliana Rocha', 'juliana.rocha@email.com', 'senha123', '1993-10-30', 'Av. Paulista, 1500 - São Paulo - SP'),
('Paulo Henrique', 'paulo.henrique@email.com', 'senha123', '1997-04-15', 'Rua Ceará, 300 - Manaus - AM'),
('Fernanda Lima', 'fernanda.lima@email.com', 'senha123', '2001-12-05', 'Av. das Torres, 999 - Manaus - AM');

-- Clientes (10 registros)
INSERT INTO Cliente (id_pessoa, renda_cliente, data_de_cadastro_cliente) VALUES
(1, 3500.00, '2023-01-15'),
(2, 4200.00, '2022-05-20'),
(3, 2800.00, '2023-07-11'),
(4, 5000.00, '2021-09-30'),
(5, 3200.00, '2023-02-17'),
(6, 4100.00, '2022-12-01'),
(7, 2900.00, '2023-06-06'),
(8, 6000.00, '2021-03-25'),
(9, 2700.00, '2023-08-19'),
(10, 3300.00, '2023-09-10');

-- Funcionários (10 registros)
INSERT INTO Funcionario (id_pessoa, salario, cargo_id_cargo, porcentagem_comissao) VALUES
(1, 2000.00, 1, 5.0),
(2, 3500.00, 2, 10.0),
(3, 1800.00, 3, 2.0),
(4, 2500.00, 4, 3.5),
(5, 2200.00, 5, 4.0),
(6, 2700.00, 6, 6.0),
(7, 1900.00, 7, 2.5),
(8, 4000.00, 8, 8.0),
(9, 3000.00, 9, 7.0),
(10, 1500.00, 10, 1.5);

-- Pedidos (10 registros)
INSERT INTO Pedido (data_do_pedido, id_cliente, id_funcionario) VALUES
('2023-01-10', 1, 2),
('2023-02-15', 3, 4),
('2023-03-20', 5, 6),
('2023-04-25', 7, 8),
('2023-05-30', 9, 10),
('2023-06-05', 2, 1),
('2023-07-12', 4, 3),
('2023-08-18', 6, 5),
('2023-09-22', 8, 7),
('2023-10-28', 10, 9);

-- Pagamentos (10 registros)
INSERT INTO Pagamento (id_pedido, data_pagamento, status_pagamento, valor_total_pagamento) VALUES
(1, '2023-01-10 15:30:00', 'concluido', 599.80),
(2, '2023-02-15 16:00:00', 'concluido', 259.50),
(3, '2023-03-20 17:10:00', 'concluido', 349.99),
(4, '2023-04-25 12:45:00', 'concluido', 279.00),
(5, '2023-05-30 14:20:00', 'concluido', 319.75),
(6, '2023-06-05 13:40:00', 'concluido', 239.90),
(7, '2023-07-12 15:55:00', 'concluido', 359.99),
(8, '2023-08-18 11:10:00', 'concluido', 269.90),
(9, '2023-09-22 18:25:00', 'concluido', 389.00),
(10, '2023-10-28 19:30:00', 'concluido', 299.00);

-- PedidoHasTenis (10 registros)
INSERT INTO PedidoHasTenis (id_tenis, id_pedido, quantidade, preco_unitario) VALUES
(1, 1, 2, 299.90),
(2, 2, 1, 259.50),
(3, 3, 1, 349.99),
(4, 4, 1, 279.00),
(5, 5, 1, 319.75),
(6, 6, 2, 239.90),
(7, 7, 1, 359.99),
(8, 8, 1, 269.90),
(9, 9, 1, 389.00),
(10, 10, 1, 299.00);

-- PagamentoHasFormaPagamento (10 registros)
INSERT INTO PagamentoHasFormaPagamento (id_pedido, id_forma_pagamento, valor_pago) VALUES
(1, 1, 599.80),
(2, 3, 259.50),
(3, 1, 349.99),
(4, 3, 279.00),
(5, 2, 319.75),
(6, 6, 239.90),
(7, 4, 359.99),
(8, 5, 269.90),
(9, 7, 389.00),
(10, 8, 299.00);
