CREATE TABLE clientes (
    id_cliente SERIAL PRIMARY KEY,
    nome VARCHAR(100),
    cidade VARCHAR(100),
    estado VARCHAR(50)
);

CREATE TABLE produtos (
    id_produto SERIAL PRIMARY KEY,
    nome_produto VARCHAR(100),
    categoria VARCHAR(50),
    preco NUMERIC(10,2)
);

CREATE TABLE vendas (
    id_venda SERIAL PRIMARY KEY,
    id_cliente INT REFERENCES clientes(id_cliente),
    id_produto INT REFERENCES produtos(id_produto),
    quantidade INT,
    data_venda DATE
);

INSERT INTO clientes (nome, cidade, estado) VALUES
('Ana Souza', 'Teresina', 'PI'),
('Carlos Lima', 'Fortaleza', 'CE'),
('Juliana Alves', 'São Paulo', 'SP'),
('Pedro Rocha', 'Recife', 'PE'),
('Marina Costa', 'Salvador', 'BA');

SELECT * FROM clientes;

INSERT INTO produtos (nome_produto, categoria, preco) VALUES
('Notebook', 'Eletrônicos', 3500.00),
('Mouse Gamer', 'Eletrônicos', 150.00),
('Cadeira Office', 'Móveis', 900.00),
('Teclado Mecânico', 'Eletrônicos', 300.00),
('Mesa Digitalizadora', 'Periféricos', 450.00);

SELECT * FROM produtos;

INSERT INTO vendas (id_cliente, id_produto, quantidade, data_venda) VALUES
(1, 1, 1, '2026-05-01'),
(2, 2, 2, '2026-05-02'),
(3, 3, 1, '2026-05-03'),
(4, 4, 3, '2026-05-04'),
(5, 5, 2, '2026-05-05'),
(1, 2, 1, '2026-05-06'),
(2, 1, 1, '2026-05-07'),
(3, 5, 4, '2026-05-08');

SELECT * FROM vendas;

-- Total vendas
SELECT SUM(v.quantidade * p.preco) AS total_vendas
FROM vendas v
JOIN produtos p 
ON v.id_produto = p.id_produto;

-- Total vendido + faturamento
SELECT p.nome_produto,
SUM(v.quantidade) AS total_vendido,
SUM(v.quantidade * p.preco) AS faturamento
FROM vendas v
JOIN produtos p 
ON v.id_produto = p.id_produto
GROUP BY p.nome_produto
ORDER BY total_vendido DESC;

-- Novos clientes
INSERT INTO clientes (nome, cidade, estado) VALUES
('Lucas Martins', 'Teresina', 'PI'),
('Fernanda Silva', 'Natal', 'RN'),
('Ricardo Gomes', 'São Luís', 'MA'),
('Patrícia Melo', 'João Pessoa', 'PB'),
('Bruno Henrique', 'Belo Horizonte', 'MG'),
('Camila Ferreira', 'Curitiba', 'PR'),
('Rafael Oliveira', 'Manaus', 'AM'),
('Aline Barbosa', 'Aracaju', 'SE'),
('Thiago Santos', 'Rio de Janeiro', 'RJ'),
('Beatriz Lima', 'Florianópolis', 'SC');

-- Novos produtos
INSERT INTO produtos (nome_produto, categoria, preco) VALUES
('Monitor Ultrawide', 'Eletrônicos', 1800.00),
('Headset Gamer', 'Periféricos', 320.00),
('Impressora Multifuncional', 'Eletrônicos', 750.00),
('Webcam HD', 'Periféricos', 220.00),
('SSD 1TB', 'Hardware', 500.00),
('Notebook Gamer', 'Eletrônicos', 6200.00),
('Mesa Office', 'Móveis', 1200.00),
('Suporte para Notebook', 'Acessórios', 95.00),
('Hub USB', 'Acessórios', 80.00),
('Caixa de Som Bluetooth', 'Áudio', 260.00);

-- Novas Vendas 
INSERT INTO vendas (id_cliente, id_produto, quantidade, data_venda) VALUES
(6, 6, 1, '2026-05-09'),
(7, 7, 2, '2026-05-10'),
(8, 8, 1, '2026-05-10'),
(9, 9, 3, '2026-05-11'),
(10, 10, 1, '2026-05-11'),
(11, 11, 2, '2026-05-12'),
(12, 12, 1, '2026-05-12'),
(13, 13, 1, '2026-05-13'),
(14, 14, 4, '2026-05-13'),
(15, 15, 2, '2026-05-14'),

(1, 6, 1, '2026-05-15'),
(2, 7, 1, '2026-05-15'),
(3, 8, 2, '2026-05-16'),
(4, 9, 1, '2026-05-16'),
(5, 10, 2, '2026-05-17'),

(6, 1, 1, '2026-05-18'),
(7, 2, 3, '2026-05-18'),
(8, 3, 1, '2026-05-19'),
(9, 4, 2, '2026-05-19'),
(10, 5, 1, '2026-05-20'),

(11, 6, 1, '2026-05-20'),
(12, 7, 2, '2026-05-21'),
(13, 8, 1, '2026-05-21'),
(14, 9, 5, '2026-05-22'),
(15, 10, 2, '2026-05-22'),

(1, 11, 1, '2026-05-23'),
(2, 12, 1, '2026-05-23'),
(3, 13, 2, '2026-05-24'),
(4, 14, 1, '2026-05-24'),
(5, 15, 3, '2026-05-25'),

(6, 2, 2, '2026-05-25'),
(7, 4, 1, '2026-05-26'),
(8, 6, 1, '2026-05-26'),
(9, 8, 3, '2026-05-27'),
(10, 10, 2, '2026-05-27'),

(11, 12, 1, '2026-05-28'),
(12, 14, 2, '2026-05-28'),
(13, 1, 1, '2026-05-29'),
(14, 3, 1, '2026-05-29'),
(15, 5, 4, '2026-05-30');

-- Valor médio de faturamento por venda 
SELECT 
    AVG(v.quantidade * p.preco) AS media_por_venda
FROM vendas v
JOIN produtos p ON v.id_produto = p.id_produto;

-- Clientes que mais compraram 
SELECT 
    c.nome,
    COUNT(v.id_venda) AS quantidade_compras
FROM vendas v
JOIN clientes c ON v.id_cliente = c.id_cliente
GROUP BY c.nome
ORDER BY quantidade_compras DESC;

-- SELECT com WHERE
SELECT *
FROM clientes
WHERE estado = 'SP';

-- ORDER BY ASC
SELECT *
FROM produtos
ORDER BY preco ASC;

-- MIN e MAX
SELECT 
MIN(preco) AS menor_preco,
MAX(preco) AS maior_preco
FROM produtos;