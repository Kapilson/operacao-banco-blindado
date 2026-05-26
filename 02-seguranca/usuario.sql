-- Fase 2: Seguranca e Acessos
-- Projecto: Operacao Banco Blindado
-- Universidade de Luanda

-- Utilizador estagiario: apenas leitura
CREATE USER 'estagiario'@'localhost' IDENTIFIED BY 'est123';
GRANT SELECT ON ecommer_db.* TO 'estagiario'@'localhost';

-- Utilizador sistema_app: leitura e insercao
CREATE USER 'sistema_app'@'localhost' IDENTIFIED BY 'app456';
GRANT SELECT, INSERT ON ecommer_db.* TO 'sistema_app'@'localhost';

-- Utilizador gerente: tudo menos apagar clientes
CREATE USER 'gerente'@'localhost' IDENTIFIED BY 'ger789';
GRANT SELECT, INSERT, UPDATE, DELETE ON ecommer_db.pedidos TO 'gerente'@'localhost';
GRANT SELECT, INSERT, UPDATE, DELETE ON ecommer_db.produtos TO 'gerente'@'localhost';
GRANT SELECT, INSERT, UPDATE, DELETE ON ecommer_db.itens_pedido TO 'gerente'@'localhost';
GRANT SELECT ON ecommer_db.clientes TO 'gerente'@'localhost';
FLUSH PRIVILEGES;

-- Trigger: impede apagar clientes em producao
DELIMITER //
CREATE TRIGGER proteger_clientes
BEFORE DELETE ON clientes
FOR EACH ROW
BEGIN
    SIGNAL SQLSTATE '45000'
    SET MESSAGE_TEXT = 'ERRO: Proibido apagar clientes em producao!';
END //
DELIMITER ;