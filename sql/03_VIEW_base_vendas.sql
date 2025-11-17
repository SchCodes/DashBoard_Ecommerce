CREATE OR REPLACE VIEW ecommerce.vw_base_vendas AS
SELECT
    p.id_pedido,
    p.data_pedido,
    YEAR(p.data_pedido)  AS ano_pedido,
    MONTH(p.data_pedido) AS mes_pedido,

    c.id_cliente,
    c.nome                AS nome_cliente,
    CASE
        WHEN cpf.id_cliente IS NOT NULL THEN 'PF'
        WHEN pj.id_cliente  IS NOT NULL THEN 'PJ'
        ELSE 'N/I'
    END                   AS tipo_cliente,

    e.cidade,
    e.estado,

    pr.id_produto,
    pr.nome               AS nome_produto,
    pr.categoria          AS categoria_produto,

    ip.quantidade,
    ip.preco_unitario,
    (ip.quantidade * ip.preco_unitario) AS valor_item,

    p.valor_frete,
    p.status              AS status_pedido,

    fp.tipo               AS forma_pagamento,

    ent.status_entrega,
    ent.data_envio,
    ent.data_entrega,
    ent.codigo_rastreio   AS codigo_rastreio

FROM ecommerce.Pedido p
JOIN ecommerce.Cliente c
    ON c.id_cliente = p.id_cliente
LEFT JOIN ecommerce.ClientePF cpf
    ON cpf.id_cliente = c.id_cliente
LEFT JOIN ecommerce.ClientePJ pj
    ON pj.id_cliente = c.id_cliente
LEFT JOIN ecommerce.Endereco e
    ON e.id_cliente = c.id_cliente
JOIN ecommerce.ItemPedido ip
    ON ip.id_pedido = p.id_pedido
JOIN ecommerce.Produto pr
    ON pr.id_produto = ip.id_produto
LEFT JOIN ecommerce.FormaPagamento fp
    ON fp.id_pagamento = p.id_pagamento
LEFT JOIN ecommerce.Entrega ent
    ON ent.id_pedido = p.id_pedido;
