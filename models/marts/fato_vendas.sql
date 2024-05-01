{{ config(materialized='table') }}

WITH detalhes_venda AS (
    SELECT
        d.detail_id AS id_detalhe_venda,
        d.order_id AS id_venda,
        d.product_id AS id_produto,
        d.order_qty AS quantidade,
        d.unit_price AS preco_unitario,
        d.unit_price_discount AS desconto_unitario,
        h.customer_id AS id_cliente,
        h.salesperson_id AS id_vendedor,
        h.order_date AS data_venda,
        h.ship_date AS data_envio,
        h.total_due AS total_devido,
        h.STATUS AS status,
        h.row_guid AS guid_linha,
        h.modified_date AS data_modificacao,
        p.sk_pessoas,
        c.sk_clientes,
        pr.sk_produtos,
        f.sk_funcionarios,
        ROW_NUMBER() OVER (PARTITION BY d.order_id, d.detail_id ORDER BY h.modified_date DESC) AS rn
    FROM EQUATORIAL.dbt_brenotcneto_dbt_brenotcneto.stg_sales_order_details d
    JOIN EQUATORIAL.dbt_brenotcneto_dbt_brenotcneto.stg_sales_order_headers h ON d.order_id = h.order_id
    LEFT JOIN EQUATORIAL.dbt_brenotcneto_dbt_brenotcneto.dim_pessoas p ON h.customer_id = p.id_pessoa
    LEFT JOIN EQUATORIAL.dbt_brenotcneto_dbt_brenotcneto.dim_clientes c ON h.customer_id = c.id_cliente
    LEFT JOIN EQUATORIAL.dbt_brenotcneto_dbt_brenotcneto.dim_produtos pr ON d.product_id = pr.id_produto
    LEFT JOIN EQUATORIAL.dbt_brenotcneto_dbt_brenotcneto.dim_funcionarios f ON h.salesperson_id = f.id_funcionario
)
SELECT
    MD5(id_venda || id_detalhe_venda || data_modificacao) AS sk_vendas,
    id_venda,
    id_detalhe_venda,
    sk_produtos,
    quantidade,
    preco_unitario,
    desconto_unitario,
    sk_clientes,
    sk_pessoas,
    sk_funcionarios,
    data_venda,
    data_envio,
    total_devido,
    status,
    guid_linha,
    data_modificacao
FROM detalhes_venda
WHERE rn = 1