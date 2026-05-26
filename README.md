# 🛡️ Operação Banco Blindado

> Projeto prático de infraestrutura, segurança e continuidade de negócio em banco de dados relacional.

**Universidade de Luanda — Instituto de Tecnologias de Informação e Comunicação**

---

## 📋 Cenário

Uma startup de e-commerce cresceu rápido demais. O banco de dados atual não tem backup automatizado, qualquer pessoa acessa tudo e o sistema fica lento em horários de pico. A missão deste projeto é reestruturar esse ambiente com foco em segurança, disponibilidade e performance.

---

## 🗂️ Estrutura do Repositório

```
operacao-banco-blindado/
│
├── sql/
│   ├── criacao_tabelas.sql       # Estrutura normalizada do banco
│   └── importacao_dados.sql      # Migração dos dados do CSV
│
├── seguranca/
│   └── usuarios_permissoes.sql   # Criação de usuários e níveis de acesso
│
├── backup/
│   └── backup.sh                 # Script de backup automático (mysqldump)
│
├── otimizacao/
│   └── indices.sql               # Índices criados para consultas lentas
│
└── README.md
```

---

## ⚙️ Etapas do Projeto

### 1. Migração e Estrutura
- Dados migrados de arquivo CSV bruto para banco relacional MySQL
- Normalização aplicada: tabelas separadas para `clientes`, `produtos` e `pedidos`
- Chaves primárias e estrangeiras definidas para garantir integridade referencial

**Verificação:**
```sql
SHOW TABLES;
SELECT COUNT(*) FROM clientes;
SELECT COUNT(*) FROM produtos;
SELECT COUNT(*) FROM pedidos;
```

---

### 2. Segurança e Acessos
Níveis de acesso criados conforme o perfil de cada utilizador:

| Utilizador | Permissões |
|------------|------------|
| `estagiario` | Apenas `SELECT` |
| `sistema` | `SELECT`, `INSERT` |
| `gerente` | `SELECT`, `INSERT`, `UPDATE`, `DELETE` |

**Verificação:**
```sql
SELECT user, host FROM mysql.user;
SHOW GRANTS FOR 'estagiario'@'localhost';
```

---

### 3. Plano de Desastre (Backup)
- Script de backup automático usando `mysqldump`
- Arquivo `.sql` gerado com data e hora no nome
- Plano de recuperação testado: banco apagado e restaurado com sucesso

**Executar backup:**
```bash
bash backup/backup.sh
```

**Restaurar backup:**
```bash
mysql -u root -p nome_do_banco < backup/backup.sql
```

---

### 4. Otimização (Índices)
- Consultas lentas identificadas com `EXPLAIN`
- Índices criados nas colunas de busca frequente
- Resultado: `rows` = 1, `type` = `const` — busca direta sem varredura da tabela

**Antes do índice:**
```sql
EXPLAIN SELECT * FROM clientes WHERE email = 'ana@email.com';
-- rows: N (varredura completa)
```

**Depois do índice:**
```sql
CREATE INDEX idx_email ON clientes(email);
EXPLAIN SELECT * FROM clientes WHERE email = 'ana@email.com';
-- rows: 1 | key: idx_email | type: const
```

---

## ✅ Checklist Final

- [x] Migração e normalização do banco de dados
- [x] Níveis de acesso por perfil de utilizador
- [x] Backup automático com script de recuperação testado
- [x] Índices criados e performance validada com EXPLAIN

---

## 🧠 Perguntas Técnicas Respondidas

**Como garantiu que um desenvolvedor não apague a tabela de clientes em produção?**
> Criando um utilizador `sistema` com permissão apenas de `INSERT` — sem `DELETE` nem `DROP`.

**Qual é o RTO (Recovery Time Objective)?**
> Com o script de backup e o plano de restauração testado, o tempo de recuperação estimado é inferior a 10 minutos.

**Quais foram as consultas mais lentas e como foram aceleradas?**
> A busca por `email` na tabela `clientes` foi identificada via `EXPLAIN` com varredura total. Após `CREATE INDEX idx_email`, o resultado passou a `rows = 1`.

---

## 👤 Autor

**Kapilson**
Universidade de Luanda — ITIC
