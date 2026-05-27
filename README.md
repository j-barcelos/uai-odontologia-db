## Banco de Dados para a UAI Odontologia

Este repositório contém o script SQL que cria a estrutura de banco de dados necessária para a **Clínica Odontológica da UAI**. O modelo contempla profissionais (dentistas, assistentes etc.), pacientes e agendamentos de consultas ou procedimentos, com chaves estrangeiras e índices para otimizar as buscas.

---

### 📋 Descrição

- **Banco:** `clinica_odontologica`
- **Tabelas principais:**
  - `profissionais` – cadastro de dentistas, assistentes e demais colaboradores.
  - `pacientes` – informações de contato dos pacientes.
  - `agendamentos` – marcação de consultas ou procedimentos, relacionando pacientes e profissionais.
- **Integridade referencial:** chaves estrangeiras garantem consistência entre as tabelas; exclusão de pacientes remove seus agendamentos (`ON DELETE CASCADE`), enquanto a remoção de um profissional define o campo `profissional_id` como `NULL` nos agendamentos.
- **Índices auxiliares:** otimizam buscas por e‑mail de pacientes e profissionais, e por data/hora dos agendamentos.

---

### 🚀 Como usar

1. **Clone o repositório**

   ```bash
   git clone https://github.com/j-barcelos/uai-odontologia-db.git
   cd uai-odontologia-db
   ```

2. **Execute o script no seu MySQL/MariaDB**

   ```bash
   mysql -u SEU_USUARIO -p < criar_banco.sql
   ```

   O script criará o banco (se ainda não existir) e todas as tabelas e índices necessários.

3. **Verifique a estrutura**

   ```sql
   SHOW DATABASES;
   USE clinica_odontologica;
   SHOW TABLES;
   DESCRIBE profissionais;
   DESCRIBE pacientes;
   DESCRIBE agendamentos;
   ```

---

### 🗂️ Estrutura do banco

| Tabela          | Colunas principais                              | Descrição |
|-----------------|-------------------------------------------------|-----------|
| **profissionais** | `profissional_id` (PK), `nome`, `especialidade`, `email`, `telefone`, `criado_em` | Dados dos profissionais da clínica. |
| **pacientes**     | `paciente_id` (PK), `nome`, `email`, `telefone`, `criado_em` | Dados de contato dos pacientes. |
| **agendamentos**  | `agendamento_id` (PK), `paciente_id` (FK), `profissional_id` (FK), `data_consulta`, `hora_consulta`, `observacao`, `criado_em` | Registra consultas e procedimentos. |

**Índices adicionais**

- `idx_paciente_email` – busca rápida por e‑mail de paciente.  
- `idx_profissional_email` – busca rápida por e‑mail de profissional.  
- `idx_agendamento_data` – otimiza consultas por data/hora de agendamento.

---

### 🤝 Contribuindo

1. Fork o projeto.  
2. Crie uma branch para sua feature (`git checkout -b feature/nome`).  
3. Commit suas alterações (`git commit -am 'Descrição da mudança'`).  
4. Push para a branch (`git push origin feature/nome`).  
5. Abra um Pull Request.

Todas as contribuições são bem‑vindas! Por favor, siga as boas práticas de SQL (uso de `INNODB`, `utf8mb4`, comentários claros, etc.).

---

### 📄 Licença

Este projeto está licenciado sob a licença **MIT** – veja o arquivo `LICENSE` para mais detalhes.
