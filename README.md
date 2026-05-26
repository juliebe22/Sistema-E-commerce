# 📊 Dashboard Analítico de E-Commerce

Projeto desenvolvido com Python, Streamlit, PostgreSQL e Plotly para análise de vendas de um e-commerce.

---

# 🚀 Tecnologias Utilizadas

- Python
- Streamlit
- PostgreSQL
- Pandas
- Plotly
- Psycopg2

---

# 📁 Estrutura do Banco de Dados

O projeto utiliza três tabelas relacionais:

## Clientes

```sql
CREATE TABLE clientes (
    id_cliente SERIAL PRIMARY KEY,
    nome VARCHAR(100),
    cidade VARCHAR(100),
    estado VARCHAR(50)
);
```

## Produtos

```sql
CREATE TABLE produtos (
    id_produto SERIAL PRIMARY KEY,
    nome_produto VARCHAR(100),
    categoria VARCHAR(50),
    preco NUMERIC(10,2)
);
```

## Vendas

```sql
CREATE TABLE vendas (
    id_venda SERIAL PRIMARY KEY,
    id_cliente INT REFERENCES clientes(id_cliente),
    id_produto INT REFERENCES produtos(id_produto),
    quantidade INT,
    data_venda DATE
);
```

---

# 📊 Funcionalidades do Dashboard

O dashboard apresenta:

- KPI de faturamento total
- KPI de ticket médio
- KPI de clientes únicos
- KPI de total de vendas
- Evolução temporal do faturamento
- Produtos mais vendidos
- Faturamento por categoria
- Filtros por período
- Integração com PostgreSQL

---

# 📈 Consultas SQL Utilizadas

## Total de vendas

```sql
SELECT 
SUM(v.quantidade * p.preco) AS total_vendas
FROM vendas v
JOIN produtos p 
ON v.id_produto = p.id_produto;
```

## Ticket médio

```sql
SELECT 
AVG(v.quantidade * p.preco) AS media_por_venda
FROM vendas v
JOIN produtos p 
ON v.id_produto = p.id_produto;
```

## Produtos mais vendidos

```sql
SELECT 
p.nome_produto,
SUM(v.quantidade) AS total_vendido,
SUM(v.quantidade * p.preco) AS faturamento
FROM vendas v
JOIN produtos p 
ON v.id_produto = p.id_produto
GROUP BY p.nome_produto
ORDER BY total_vendido DESC;
```

## Clientes que mais compraram

```sql
SELECT 
c.nome,
COUNT(v.id_venda) AS quantidade_compras
FROM vendas v
JOIN clientes c 
ON v.id_cliente = c.id_cliente
GROUP BY c.nome
ORDER BY quantidade_compras DESC;
```

---

# ▶️ Como Executar o Projeto

## 1. Clone o repositório

```bash
git clone https://github.com/seuusuario/dashboard-ecommerce.git
```

## 2. Instale as dependências

```bash
pip install streamlit pandas psycopg2 plotly
```

## 3. Configure o PostgreSQL

Crie o banco de dados:

```sql
CREATE DATABASE vendas;
```

Execute os scripts SQL das tabelas e inserts.

---

# ▶️ Executando o Dashboard

```bash
streamlit run vendas.py
```

---

# 📌 Conceitos Aplicados

O projeto utiliza diversos conceitos de banco de dados e visualização:

- SELECT
- WHERE
- ORDER BY
- GROUP BY
- JOIN
- COUNT
- SUM
- AVG
- MIN e MAX
- Relacionamento entre tabelas
- Visualização de dados com Plotly
- Dashboard interativo com Streamlit

---

# 📷 Dashboard

O dashboard possui:

- 📈 Gráfico de linhas
- 📊 Gráfico de barras
- 🥧 Gráfico de pizza
- 📌 KPIs interativos

<img width="1918" height="907" alt="image" src="https://github.com/user-attachments/assets/ee12caea-089b-4a16-aa26-ee15c4f100ec" />
