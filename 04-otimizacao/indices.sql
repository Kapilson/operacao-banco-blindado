-- Fase 4: Optimizacao com Indices
-- Projecto: Operacao Banco Blindado
-- Universidade de Luanda

-- Verificar query ANTES do indice
EXPLAIN SELECT * FROM produtos WHERE categoria = 'Electronica';
EXPLAIN SELECT * FROM pedidos WHERE cliente_id = 1;
EXPLAIN SELECT * FROM pedidos WHERE data_pedido > '2026-01-01';

-- Criar indices para optimizar as queries
CREATE INDEX idx_produtos_categoria ON produtos(categoria);
CREATE INDEX idx_pedidos_cliente ON pedidos(cliente_id);
CREATE INDEX idx_pedidos_data ON pedidos(data_pedido);

-- Verificar query DEPOIS do indice
EXPLAIN SELECT * FROM produtos WHERE categoria = 'Electronica';
EXPLAIN SELECT * FROM pedidos WHERE cliente_id = 1;
EXPLAIN SELECT * FROM pedidos WHERE data_pedido > '2026-01-01';