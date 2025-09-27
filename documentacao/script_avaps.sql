-- ===========================
-- TABELA INDEPENDENTE: Produto (TênisDeVolei)
-- ===========================
CREATE TABLE Produto (
    id_tenis SERIAL PRIMARY KEY,
    nome_tenis VARCHAR(45) NOT NULL,
    tamanho_disponivel VARCHAR(10),
    quantidade_em_estoque INT NOT NULL,
    preco_unitario DOUBLE PRECISION NOT NULL
);

-- ===========================
-- TABELA INDEPENDENTE: FormaDePagamento
-- ===========================
CREATE TABLE FormaDePagamento (
    id_forma_pagamento SERIAL PRIMARY KEY,
    nome_forma_pagamento VARCHAR(100) NOT NULL
);

-- ===========================
-- TABELA INDEPENDENTE: Cargo
-- ===========================
CREATE TABLE Cargo (
    id_cargo SERIAL PRIMARY KEY,
    nome_cargo VARCHAR(45) NOT NULL
);

-- ===========================
-- TABELA Endereco
-- ===========================
CREATE TABLE Endereco (
    id_endereco SERIAL PRIMARY KEY,
    logradouro VARCHAR(100) NOT NULL,
    numero VARCHAR(10),
    referencia VARCHAR(45),
    cep VARCHAR(9),
    cidade VARCHAR(100)
);

-- ===========================
-- TABELA Pessoa
-- ===========================
CREATE TABLE Pessoa (
    cpf_pessoa VARCHAR(20) PRIMARY KEY,
    nome_pessoa VARCHAR(60) NOT NULL,
    data_nascimento_pessoa DATE NOT NULL,
    endereco_id_endereco INT,
    FOREIGN KEY (endereco_id_endereco) REFERENCES Endereco(id_endereco)
);

-- ===========================
-- TABELA Cliente (1:1 com Pessoa)
-- ===========================
CREATE TABLE Cliente (
    pessoa_cpf_pessoa VARCHAR(20) PRIMARY KEY,
    renda_cliente DOUBLE PRECISION,
    data_de_cadastro_cliente DATE,
    FOREIGN KEY (pessoa_cpf_pessoa) REFERENCES Pessoa(cpf_pessoa)
);

-- ===========================
-- TABELA Funcionario (1:1 com Pessoa)
-- ===========================
CREATE TABLE Funcionario (
    pessoa_cpf_pessoa VARCHAR(20) PRIMARY KEY,
    salario DOUBLE PRECISION,
    cargo_id_cargo INT,
    porcentagem_comissao DOUBLE PRECISION,
    FOREIGN KEY (pessoa_cpf_pessoa) REFERENCES Pessoa(cpf_pessoa),
    FOREIGN KEY (cargo_id_cargo) REFERENCES Cargo(id_cargo)
);

-- ===========================
-- TABELA Pedido
-- ===========================
CREATE TABLE Pedido (
    id_pedido SERIAL PRIMARY KEY,
    data_do_pedido DATE NOT NULL,
    cliente_pessoa_cpf_pessoa VARCHAR(20),
    funcionario_pessoa_cpf_pessoa VARCHAR(20),
    FOREIGN KEY (cliente_pessoa_cpf_pessoa) REFERENCES Cliente(pessoa_cpf_pessoa),
    FOREIGN KEY (funcionario_pessoa_cpf_pessoa) REFERENCES Funcionario(pessoa_cpf_pessoa)
);

-- ===========================
-- TABELA Pagamento (1:1 com Pedido)
-- ===========================
CREATE TABLE Pagamento (
    pedido_id_pedido INT PRIMARY KEY,
    data_pagamento TIMESTAMP,
    valor_total_pagamento DOUBLE PRECISION,
    FOREIGN KEY (pedido_id_pedido) REFERENCES Pedido(id_pedido)
);

-- ===========================
-- TABELA PedidoHasTenis (N:N entre Pedido e Produto)
-- ===========================
CREATE TABLE PedidoHasTenis (
    tenis_id_tenis INT,
    pedido_id_pedido INT,
    quantidade INT,
    preco_unitario DOUBLE PRECISION,
    PRIMARY KEY (tenis_id_tenis, pedido_id_pedido),
    FOREIGN KEY (tenis_id_tenis) REFERENCES Produto(id_tenis),
    FOREIGN KEY (pedido_id_pedido) REFERENCES Pedido(id_pedido)
);

-- ===========================
-- TABELA PagamentoHasFormaPagamento (N:N entre Pagamento e FormaDePagamento)
-- ===========================
CREATE TABLE PagamentoHasFormaPagamento (
    pagamento_id_pedido INT,
    forma_pagamento_id_forma_pagamento INT,
    valor_pago DOUBLE PRECISION,
    PRIMARY KEY (pagamento_id_pedido, forma_pagamento_id_forma_pagamento),
    FOREIGN KEY (pagamento_id_pedido) REFERENCES Pagamento(pedido_id_pedido),
    FOREIGN KEY (forma_pagamento_id_forma_pagamento) REFERENCES FormaDePagamento(id_forma_pagamento)
);

-- ===========================
-- PRODUTO (10 registros)
-- ===========================
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

-- ===========================
-- FORMA DE PAGAMENTO (10 registros)
-- ===========================
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

-- ===========================
-- CARGO (10 registros)
-- ===========================
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

-- ===========================
-- ENDERECO (10 registros)
-- ===========================
INSERT INTO Endereco (logradouro, numero, referencia, cep, cidade) VALUES
('Rua das Palmeiras', '100', 'Próximo ao mercado', '01001-000', 'São Paulo'),
('Av. Brasil', '2000', 'Ao lado da padaria', '20040-001', 'Rio de Janeiro'),
('Rua XV de Novembro', '150', 'Centro histórico', '80020-310', 'Curitiba'),
('Av. Independência', '500', 'Próximo ao shopping', '30140-002', 'Belo Horizonte'),
('Rua das Flores', '75', 'Em frente à praça', '88010-420', 'Florianópolis'),
('Av. Goiás', '800', 'Perto da igreja', '74000-100', 'Goiânia'),
('Rua Bahia', '250', 'Atrás do hospital', '40020-120', 'Salvador'),
('Av. Paulista', '1500', 'Próximo ao MASP', '01310-200', 'São Paulo'),
('Rua Ceará', '300', 'Próximo ao colégio', '69005-030', 'Manaus'),
('Av. das Torres', '999', 'Ao lado da farmácia', '69050-010', 'Manaus');

-- ===========================
-- PESSOA (10 registros)
-- ===========================
INSERT INTO Pessoa (cpf_pessoa, nome_pessoa, data_nascimento_pessoa, endereco_id_endereco) VALUES
('11111111111', 'João Silva', '1990-05-12', 1),
('22222222222', 'Maria Oliveira', '1985-03-20', 2),
('33333333333', 'Carlos Souza', '1992-07-08', 3),
('44444444444', 'Ana Pereira', '1998-11-25', 4),
('55555555555', 'Lucas Fernandes', '2000-02-10', 5),
('66666666666', 'Mariana Costa', '1995-09-18', 6),
('77777777777', 'Rafael Gomes', '1988-06-01', 7),
('88888888888', 'Juliana Rocha', '1993-10-30', 8),
('99999999999', 'Paulo Henrique', '1997-04-15', 9),
('10101010101', 'Fernanda Lima', '2001-12-05', 10);

-- ===========================
-- CLIENTE (10 registros)
-- ===========================
INSERT INTO Cliente (pessoa_cpf_pessoa, renda_cliente, data_de_cadastro_cliente) VALUES
('11111111111', 3500.00, '2023-01-15'),
('22222222222', 4200.00, '2022-05-20'),
('33333333333', 2800.00, '2023-07-11'),
('44444444444', 5000.00, '2021-09-30'),
('55555555555', 3200.00, '2023-02-17'),
('66666666666', 4100.00, '2022-12-01'),
('77777777777', 2900.00, '2023-06-06'),
('88888888888', 6000.00, '2021-03-25'),
('99999999999', 2700.00, '2023-08-19'),
('10101010101', 3300.00, '2023-09-10');

-- ===========================
-- FUNCIONARIO (10 registros)
-- ===========================
INSERT INTO Funcionario (pessoa_cpf_pessoa, salario, cargo_id_cargo, porcentagem_comissao) VALUES
('11111111111', 2000.00, 1, 5.0),
('22222222222', 3500.00, 2, 10.0),
('33333333333', 1800.00, 3, 2.0),
('44444444444', 2500.00, 4, 3.5),
('55555555555', 2200.00, 5, 4.0),
('66666666666', 2700.00, 6, 6.0),
('77777777777', 1900.00, 7, 2.5),
('88888888888', 4000.00, 8, 8.0),
('99999999999', 3000.00, 9, 7.0),
('10101010101', 1500.00, 10, 1.5);

-- ===========================
-- PEDIDO (10 registros)
-- ===========================
INSERT INTO Pedido (data_do_pedido, cliente_pessoa_cpf_pessoa, funcionario_pessoa_cpf_pessoa) VALUES
('2023-01-10', '11111111111', '22222222222'),
('2023-02-15', '33333333333', '44444444444'),
('2023-03-20', '55555555555', '66666666666'),
('2023-04-25', '77777777777', '88888888888'),
('2023-05-30', '99999999999', '10101010101'),
('2023-06-05', '22222222222', '11111111111'),
('2023-07-12', '44444444444', '33333333333'),
('2023-08-18', '66666666666', '55555555555'),
('2023-09-22', '88888888888', '77777777777'),
('2023-10-28', '10101010101', '99999999999');

-- ===========================
-- PAGAMENTO (10 registros)
-- ===========================
INSERT INTO Pagamento (pedido_id_pedido, data_pagamento, valor_total_pagamento) VALUES
(1, '2023-01-10 15:30:00', 599.80),
(2, '2023-02-15 16:00:00', 259.50),
(3, '2023-03-20 17:10:00', 349.99),
(4, '2023-04-25 12:45:00', 279.00),
(5, '2023-05-30 14:20:00', 319.75),
(6, '2023-06-05 13:40:00', 239.90),
(7, '2023-07-12 15:55:00', 359.99),
(8, '2023-08-18 11:10:00', 269.90),
(9, '2023-09-22 18:25:00', 389.00),
(10, '2023-10-28 19:30:00', 299.00);

-- ===========================
-- PEDIDOHASTENIS (5 registros - relação N:N)
-- ===========================
INSERT INTO PedidoHasTenis (tenis_id_tenis, pedido_id_pedido, quantidade, preco_unitario) VALUES
(1, 1, 2, 299.90),
(2, 2, 1, 259.50),
(3, 3, 1, 349.99),
(4, 4, 1, 279.00),
(5, 5, 1, 319.75);

-- ===========================
-- PAGAMENTOHASFORMAPAGAMENTO (5 registros - relação N:N)
-- ===========================
INSERT INTO PagamentoHasFormaPagamento (pagamento_id_pedido, forma_pagamento_id_forma_pagamento, valor_pago) VALUES
(1, 1, 599.80),  -- Cartão de Crédito
(2, 3, 259.50),  -- Pix
(3, 1, 349.99),  -- Cartão de Crédito
(4, 3, 279.00),  -- Pix
(5, 2, 319.75);  -- Cartão de Débito
