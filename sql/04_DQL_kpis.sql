USE ecommerce;

-- =========================================================
-- 1. INDICADORES FINANCEIROS
-- =========================================================

-- 1.1 Valor total de vendas (pedidos pagos, enviados ou entregues)
SELECT 
    ROUND(SUM(i.quantidade * i.preco_unitario) + SUM(p.valor_frete), 2) AS valor_total_vendas
FROM Pedido p
JOIN ItemPedido i ON p.id_pedido = i.id_pedido
WHERE p.status IN ('Pago', 'Enviado', 'Entregue');

-- 1.2 Valor total perdido com cancelamentos
SELECT 
    ROUND(SUM(i.quantidade * i.preco_unitario), 2) AS valor_perdido_cancelamentos
FROM Pedido p
JOIN ItemPedido i ON p.id_pedido = i.id_pedido
WHERE p.status = 'Cancelado';

-- 1.3 Ticket médio por pedido
SELECT 
    ROUND(SUM(i.quantidade * i.preco_unitario) / COUNT(DISTINCT p.id_pedido), 2) AS ticket_medio
FROM Pedido p
JOIN ItemPedido i ON p.id_pedido = i.id_pedido
WHERE p.status IN ('Pago', 'Enviado', 'Entregue');

-- 1.4 Receita por mês (considera data do pedido)
SELECT 
    DATE_FORMAT(p.data_pedido, '%Y-%m') AS mes_referencia,
    ROUND(SUM(i.quantidade * i.preco_unitario) + SUM(p.valor_frete), 2) AS receita_total
FROM Pedido p
JOIN ItemPedido i ON p.id_pedido = i.id_pedido
WHERE p.status IN ('Pago', 'Enviado', 'Entregue')
GROUP BY mes_referencia
ORDER BY mes_referencia;	

-- 1.5 Taxa e quantidade de pedidos cancelados
SELECT 
    COUNT(*) AS total_pedidos,
    SUM(CASE WHEN status = 'Cancelado' THEN 1 ELSE 0 END) AS pedidos_cancelados,
    ROUND(
        (SUM(CASE WHEN status = 'Cancelado' THEN 1 ELSE 0 END) / COUNT(*)) * 100, 
        2
    ) AS taxa_cancelamento_percentual
FROM Pedido;

-- =========================================================
-- 2. INDICADORES DE CLIENTES
-- =========================================================

-- 2.1 Total de clientes ativos (que possuem pedidos)
SELECT 
    COUNT(DISTINCT p.id_cliente) AS clientes_ativos
FROM Pedido p
WHERE p.status IN ('Pago', 'Enviado', 'Entregue');

-- 2.2 Top 5 clientes por valor gasto
SELECT 
    c.nome AS cliente,
    ROUND(SUM(i.quantidade * i.preco_unitario) + SUM(p.valor_frete), 2) AS total_gasto
FROM Pedido p
JOIN Cliente c ON p.id_cliente = c.id_cliente
JOIN ItemPedido i ON p.id_pedido = i.id_pedido
WHERE p.status IN ('Pago', 'Enviado', 'Entregue')
GROUP BY c.id_cliente
ORDER BY total_gasto DESC
LIMIT 5;

-- 2.3 Valor médio gasto por cliente
SELECT 
    ROUND(SUM(i.quantidade * i.preco_unitario) / COUNT(DISTINCT p.id_cliente), 2) AS gasto_medio_cliente
FROM Pedido p
JOIN ItemPedido i ON p.id_pedido = i.id_pedido
WHERE p.status IN ('Pago', 'Enviado', 'Entregue');

-- 2.4 Clientes que gastaram acima da média geral
SELECT 
    c.nome,
    ROUND(SUM(i.quantidade * i.preco_unitario) + SUM(p.valor_frete), 2) AS total_gasto
FROM Pedido p
JOIN Cliente c ON p.id_cliente = c.id_cliente
JOIN ItemPedido i ON p.id_pedido = i.id_pedido
WHERE p.status IN ('Pago', 'Enviado', 'Entregue')
GROUP BY c.id_cliente
HAVING total_gasto > (
    SELECT 
        AVG(sub.total)
    FROM (
        SELECT 
            SUM(i2.quantidade * i2.preco_unitario) + SUM(p2.valor_frete) AS total
        FROM Pedido p2
        JOIN ItemPedido i2 ON p2.id_pedido = i2.id_pedido
        WHERE p2.status IN ('Pago', 'Enviado', 'Entregue')
        GROUP BY p2.id_cliente
    ) AS sub
)
ORDER BY total_gasto DESC;

-- 2.5 Distribuição de clientes PF e PJ ativos
SELECT 
    CASE
        WHEN pf.id_cliente IS NOT NULL THEN 'Pessoa Física'
        WHEN pj.id_cliente IS NOT NULL THEN 'Pessoa Jurídica'
    END AS tipo_cliente,
    COUNT(DISTINCT p.id_cliente) AS quantidade
FROM Pedido p
LEFT JOIN ClientePF pf ON p.id_cliente = pf.id_cliente
LEFT JOIN ClientePJ pj ON p.id_cliente = pj.id_cliente
WHERE p.status IN ('Pago', 'Enviado', 'Entregue')
GROUP BY tipo_cliente;

-- 2.6 Clientes cadastrados que nunca realizaram pedidos
SELECT 
    c.id_cliente,
    c.nome,
    c.email,
    CASE
        WHEN pf.id_cliente IS NOT NULL THEN 'Pessoa Física'
        WHEN pj.id_cliente IS NOT NULL THEN 'Pessoa Jurídica'
    END AS tipo_cliente,
    c.data_cadastro
FROM Cliente c
LEFT JOIN Pedido p ON c.id_cliente = p.id_cliente
LEFT JOIN ClientePF pf ON c.id_cliente = pf.id_cliente
LEFT JOIN ClientePJ pj ON c.id_cliente = pj.id_cliente
WHERE p.id_pedido IS NULL
ORDER BY tipo_cliente, c.nome;
		
-- =========================================================
-- 3. INDICADORES DE PRODUTOS
-- =========================================================

-- 3.1 Top 5 produtos mais vendidos
SELECT 
    pr.nome AS produto,
    SUM(i.quantidade) AS total_vendido,
    ROUND(SUM(i.quantidade * i.preco_unitario), 2) AS receita_gerada
FROM ItemPedido i
JOIN Pedido p ON i.id_pedido = p.id_pedido
JOIN Produto pr ON i.id_produto = pr.id_produto
WHERE p.status IN ('Pago', 'Enviado', 'Entregue')
GROUP BY pr.id_produto
ORDER BY total_vendido DESC
LIMIT 5;

-- 3.2 Produtos com maior receita acumulada
SELECT 
    pr.nome AS produto,
    ROUND(SUM(i.quantidade * i.preco_unitario), 2) AS receita_total
FROM ItemPedido i
JOIN Pedido p ON i.id_pedido = p.id_pedido
JOIN Produto pr ON i.id_produto = pr.id_produto
WHERE p.status IN ('Pago', 'Enviado', 'Entregue')
GROUP BY pr.id_produto
ORDER BY receita_total DESC
LIMIT 5;

-- 3.3 Categorias com maior volume de vendas
SELECT 
    pr.categoria,
    ROUND(SUM(i.quantidade * i.preco_unitario), 2) AS receita_categoria
FROM ItemPedido i
JOIN Pedido p ON i.id_pedido = p.id_pedido
JOIN Produto pr ON i.id_produto = pr.id_produto
WHERE p.status IN ('Pago', 'Enviado', 'Entregue')
GROUP BY pr.categoria
ORDER BY receita_categoria DESC;

-- 3.4 Produtos sem vendas registradas
SELECT 
    pr.nome AS produto,
    pr.categoria,
    pr.estoque
FROM Produto pr
LEFT JOIN ItemPedido i ON pr.id_produto = i.id_produto
LEFT JOIN Pedido p ON i.id_pedido = p.id_pedido
WHERE p.id_pedido IS NULL;

-- =========================================================
-- 4. INDICADORES LOGÍSTICOS
-- =========================================================

-- 4.1 Total de entregas por status
SELECT 
    status_entrega,
    COUNT(*) AS quantidade
FROM Entrega
GROUP BY status_entrega
ORDER BY quantidade DESC;

-- 4.2 Percentual de entregas concluídas
SELECT 
    ROUND(
        (SUM(CASE WHEN status_entrega = 'Entregue' THEN 1 ELSE 0 END) / COUNT(*)) * 100, 2
    ) AS percentual_entregas_concluidas
FROM Entrega;

-- 4.3 Tempo médio de entrega (em dias)
SELECT 
    ROUND(AVG(DATEDIFF(data_entrega, data_envio)), 2) AS tempo_medio_dias
FROM Entrega
WHERE status_entrega = 'Entregue';

-- 4.4 Pedidos com entrega pendente
SELECT 
    p.id_pedido,
    c.nome AS cliente,
    e.codigo_rastreio,
    e.status_entrega
FROM Entrega e
JOIN Pedido p ON e.id_pedido = p.id_pedido
JOIN Cliente c ON p.id_cliente = c.id_cliente
WHERE e.status_entrega = 'Pendente';

-- 4.5 Clientes com maior número de entregas concluídas
SELECT 
    c.nome AS cliente,
    COUNT(e.id_entrega) AS entregas_realizadas
FROM Entrega e
JOIN Pedido p ON e.id_pedido = p.id_pedido
JOIN Cliente c ON p.id_cliente = c.id_cliente
WHERE e.status_entrega = 'Entregue'
GROUP BY c.id_cliente
ORDER BY entregas_realizadas DESC
LIMIT 5;