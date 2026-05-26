import streamlit as st
import pandas as pd
import psycopg2
import plotly.express as px

# Configuração da página do Streamlit
st.set_page_config(page_title="Dashboard de E-Commerce", layout="wide")
st.title("📊 Dashboard Analítico de E-Commerce")

# CONEXÃO COM O BANCO DE DADOS
def abrir_conexao():
    conn = psycopg2.connect(
        dbname="vendas",
        user="postgres",
        password="root",
        host="localhost",
        port="5432"
    )
    return conn

# BARRA LATERAL
st.sidebar.header("Filtros")

# Filtro de Data
data_inicio = st.sidebar.date_input(
    "Data Inicial",
    pd.to_datetime("2026-05-01")
)

data_fim = st.sidebar.date_input(
    "Data Final",
    pd.to_datetime("2026-05-30")
)

# CONSULTAS SQL 
conn = abrir_conexao()

# KPIs Gerais (WHERE, COUNT, SUM, AVG)
query_kpis = """
SELECT
    COUNT(v.id_venda) AS total_vendas,

    SUM(v.quantidade * p.preco) AS faturamento_total,

    AVG(v.quantidade * p.preco) AS ticket_medio,

    COUNT(DISTINCT v.id_cliente) AS clientes_unicos

FROM vendas v
JOIN produtos p
ON v.id_produto = p.id_produto

WHERE v.data_venda BETWEEN %s AND %s;
"""

df_kpis = pd.read_sql_query(
    query_kpis,
    conn,
    params=(data_inicio, data_fim)
)

# Evolução das vendas
query_linhas = """
SELECT
    data_venda,
    SUM(v.quantidade * p.preco) AS faturamento
FROM vendas v
JOIN produtos p
ON v.id_produto = p.id_produto

WHERE data_venda BETWEEN %s AND %s

GROUP BY data_venda
ORDER BY data_venda;
"""

df_linhas = pd.read_sql_query(
    query_linhas,
    conn,
    params=(data_inicio, data_fim)
)

# Produtos mais vendidos 
query_barras = """
SELECT
    p.nome_produto,
    SUM(v.quantidade) AS total_vendido

FROM vendas v

JOIN produtos p
ON v.id_produto = p.id_produto

WHERE v.data_venda BETWEEN %s AND %s

GROUP BY p.nome_produto
ORDER BY total_vendido DESC;
"""

df_barras = pd.read_sql_query(
    query_barras,
    conn,
    params=(data_inicio, data_fim)
)

# Vendas por categoria
query_pizza = """
SELECT
    p.categoria,
    SUM(v.quantidade * p.preco) AS faturamento

FROM vendas v

JOIN produtos p
ON v.id_produto = p.id_produto

GROUP BY p.categoria;
"""

df_pizza = pd.read_sql_query(query_pizza, conn)

#Fecha conexão
conn.close()

# KPI's
st.markdown("---")

col1, col2, col3, col4 = st.columns(4)

with col1:
    st.metric(
        "Total de Vendas",
        int(df_kpis['total_vendas'].iloc[0])
    )

with col2:
    faturamento = df_kpis['faturamento_total'].iloc[0] or 0

    st.metric(
        "Faturamento Total",
        f"R$ {faturamento:,.2f}"
    )

with col3:
    ticket = df_kpis['ticket_medio'].iloc[0] or 0

    st.metric(
        "Ticket Médio",
        f"R$ {ticket:,.2f}"
    )

with col4:
    st.metric(
        "Clientes Únicos",
        int(df_kpis['clientes_unicos'].iloc[0])
    )

# Gráficos
st.markdown("---")

col_esq, col_dir = st.columns(2)

with col_esq:

    st.subheader("📈 Evolução do Faturamento")

    fig_linha = px.line(
        df_linhas,
        x='data_venda',
        y='faturamento',
        markers=True
    )

    st.plotly_chart(
        fig_linha,
        use_container_width=True
    )

with col_dir:

    st.subheader("🏆 Produtos Mais Vendidos")

    fig_barra = px.bar(
        df_barras,
        x='total_vendido',
        y='nome_produto',
        orientation='h'
    )

    st.plotly_chart(
        fig_barra,
        use_container_width=True
    )

#Pizza
st.markdown("---")

st.subheader("📊 Faturamento por Categoria")

fig_pizza = px.pie(
    df_pizza,
    values='faturamento',
    names='categoria',
    hole=0.4
)

st.plotly_chart(
    fig_pizza,
    use_container_width=True
)        
